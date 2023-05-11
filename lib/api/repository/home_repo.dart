// @dart=2.9
import 'package:aec_medical_doctor/api/base/api_response.dart';
import 'package:aec_medical_doctor/api/exception/api_error_handler.dart';
import 'package:aec_medical_doctor/model/allpatientcomplete_model.dart';
import 'package:aec_medical_doctor/model/allpatients_model.dart';
import 'package:aec_medical_doctor/model/cancelledpatient_model.dart';
import 'package:aec_medical_doctor/model/completePayment_model.dart';
import 'package:aec_medical_doctor/model/completepatient_model.dart';
import 'package:aec_medical_doctor/model/counting_model.dart';
import 'package:aec_medical_doctor/model/earning_filter_model.dart';
import 'package:aec_medical_doctor/model/earning_model.dart';
import 'package:aec_medical_doctor/model/notification_model.dart';
import 'package:aec_medical_doctor/model/oldpatients_model.dart';
import 'package:aec_medical_doctor/model/paymentsDetailmodel.dart';
import 'package:aec_medical_doctor/model/upcomingpatient_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/upcoming_page.dart';
import 'package:flutter/cupertino.dart';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as gets;
import '../AppConstant.dart';
import '../AppUrlConstant.dart';
import '../sharedprefrence.dart';

class HomeRepo extends ChangeNotifier {
  /// upcomingPatient ////////////////////////////////////////////////////

  Future<List<UpcomingPatientData>> upcomingPatientApi() async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<UpcomingPatientData> upcomingPatientData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorId,
      });
      // print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.upcomingPatient,
          data: formData);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        // print("dsfds" + response.data);
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          list = list[0]['data'];
          upcomingPatientData = list
              .map((data) => new UpcomingPatientData.fromJson(data))
              .toList();
          // print("upcomingPatientApi" + list.toString());
          // print("gdgd" + upcomingPatientData[0].disease);
          return upcomingPatientData;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  /// oldPatient ////////////////////////////////////////////////////

  Future<List<OldPatientsData>> oldPatientApi() async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<OldPatientsData> oldPatientsData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.oldPatient,
          data: formData);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        // print("oldPatientApi" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        oldPatientsData =
            list.map((data) => new OldPatientsData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + oldPatientsData[0].disease);
        return oldPatientsData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// allPatient ////////////////////////////////////////////////////

  Future<List<AllPatientsData>> allPatientApi(var formdate, var todate) async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<AllPatientsData> allPatientsData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorId,
        'from_date': formdate,
        'to_date': todate,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.allPatient,
          data: formData);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "hey",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        print("allPatientApi" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        allPatientsData =
            list.map((data) => new AllPatientsData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + allPatientsData[0].disease);
        return allPatientsData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// updateWaitingTime api ///////////////////////////////

  Future<ApiResponse> updateWaitingTimeApi(String waitingTime) async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    String assignId =
        await SharedPrefManager.getPrefrenceString(AppConstant.ASSIGNID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorId,
        'AssignId': assignId,
        'WaitingTime': waitingTime,
      });
      print(formData.fields);
      print("kasjxlak");
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.updateWaitingTime,
          data: formData);
      if (response.statusCode == 200) {
        print("sjkla");
        list = jsonDecode(response.data);
        gets.Get.back();
        print("ghsdjdka" + list.toString());
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(
              msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(
              msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// Update token api  ///////////////////////////////

  Future updateTokenApi() async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    String token =
        await SharedPrefManager.getPrefrenceString(AppConstant.FCMTOKEN);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
        'Token': token,
      });

      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.updateToken,
          data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(
              msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  /// Update doctor status  ///////////////////////////////

  Future updateDoctorStatus(status) async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctorid': doctorId,
        'is_online': status,
      });

      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.doctorOnlineStatus,
          data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
          print("Massage : " + list[0].toString());
        } else {
          Fluttertoast.showToast(
              msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  /// checkDoctorAccount api ///////////////////////////////

  Future<ApiResponse> checkDoctorAccountApi() async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.checkDoctorAccount,
          data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(
              msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// notification ////////////////////////////////////////////////////

  Future<List<NotificationsData>> notificationApi() async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<NotificationsData> notificationsData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.notification,
          data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        notificationsData =
            list.map((data) => new NotificationsData.fromJson(data)).toList();
        print("notificationApi" + list.toString());
        print("gdgd" + notificationsData[0].message);
        return notificationsData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// earning list ////////////////////////////////////////////////////

  Future<List<EarningData>> earninglistApi(var fromdate, var todate) async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<EarningData> earningData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
        'from_date': fromdate,
        'to_date': todate,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.earninglist,
          data: formData);
      if (response.statusCode == 200) {
        print("dsfxxxxds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        earningData =
            list.map((data) => new EarningData.fromJson(data)).toList();
        print("earninglistApi" + list.toString());
        // print("gdgd" + earningData[0].user);
        return earningData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// counting  ///////////////////////////////////////////////////////

  Future<List<CountingModel>> countingApi() async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List<CountingModel> countingModel;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.counting,
          data: formData);
      if (response.statusCode == 200) {
        print("countingApi" + response.data);
        list = jsonDecode(response.data);
        countingModel =
            list.map((data) => new CountingModel.fromJson(data)).toList();
        print("gdssh");
        // Fluttertoast.showToast(msg: list[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        print("dataaaaa" + countingModel[0].data.amountPaid);
        print("status Code : " + list[0]['status'].toString());
        print("Massage : " + list[0]['msg'].toString());
      }
      return countingModel;
    } catch (e) {
      print(e);
    }
  }

  /// completePatient ////////////////////////////////////////////////////

  Future<List<AllPatientCompleteData>> completePatientApi() async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<AllPatientCompleteData> allPatientCompleteData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.completePatient,
          data: formData);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        allPatientCompleteData = list
            .map((data) => new AllPatientCompleteData.fromJson(data))
            .toList();
        print("completePatientApi" + list.toString());
        print("gdgd" + allPatientCompleteData[0].disease);
        return allPatientCompleteData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// cancelledPatient ////////////////////////////////////////////////////

  Future<List<CancelledPatientData>> filterPatientCancelledApi() async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<CancelledPatientData> cancelledPatientData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorId,
        'type': "Cancelled",
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.filterPatient,
          data: formData);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        cancelledPatientData = list
            .map((data) => new CancelledPatientData.fromJson(data))
            .toList();
        print("filterPatientCancelledApi" + list.toString());
        print("gdgd" + cancelledPatientData[0].disease);
        return cancelledPatientData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// completePayment  ////////////////////////////////////////////////////

  Future<List<CompletePaymentData>> completePaymentApi(
      String fromdate, String todate) async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List<CompletePaymentData> completePaymentData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
        'from_date': fromdate,
        'to_date': todate,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.completePayment,
          data: formData);
      if (response.statusCode == 200) {
        print("completePaymentApi" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        completePaymentData =
            list.map((data) => new CompletePaymentData.fromJson(data)).toList();
        print("completePaymentApi" + list.toString());
        print("gdgd" + completePaymentData[0].doctor);
        return completePaymentData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// paymentDetails  ////////////////////////////////////////////////////

  Future<List<PaymentDetailsData>> paymentDetailsApi(
      String fromdate, String todate) async {
    String doctorId =
        await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List<PaymentDetailsData> paymentDetailsData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
        'from_date': fromdate,
        'to_date': todate,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.paymentDetails,
          data: formData);
      if (response.statusCode == 200) {
        print("paymentDetailsApi" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        paymentDetailsData =
            list.map((data) => new PaymentDetailsData.fromJson(data)).toList();
        print("paymentDetailsApi" + list.toString());
        print("fasdfsd" + paymentDetailsData[0].totalAmount);
        return paymentDetailsData;
      }
    } catch (e) {
      print(e);
    }
  }
}
