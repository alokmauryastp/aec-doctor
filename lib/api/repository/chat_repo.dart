// @dart=2.9

import 'dart:convert';
import 'package:aec_medical_doctor/api/base/api_response.dart';
import 'package:aec_medical_doctor/api/exception/api_error_handler.dart';
import 'package:aec_medical_doctor/model/chatModel/getchat_model.dart';
import 'package:aec_medical_doctor/model/chatModel/getmedicalhistory_model.dart';
import 'package:aec_medical_doctor/model/chatModel/messagecount_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get.dart' as gets;
import 'package:get/get_navigation/src/snackbar/snack.dart';
import '../AppConstant.dart';
import '../AppUrlConstant.dart';
import '../sharedprefrence.dart';

class ChatRepo extends ChangeNotifier {


  /// getChat api  ///////////////////////////////////////////////////////

  Future<List<GetChatData>> getChatApi() async {
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List<GetChatData> getChatData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'consult_id': consultId,
        'doctor_id': doctorId,
      });
      print("dgjf");
      print(formData.fields);
      final response = await dio.post(AppUrlConstant.baseUrlDoctor + AppUrlConstant.getChat,data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        // Fluttertoast.showToast(msg: list[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        list = list[0]['data'];
        getChatData = list.map((data) => new GetChatData.fromJson(data)).toList();
        return getChatData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// saveDoctorChatMessage api  ///////////////////////////////////////////////////////

  Future<ApiResponse> saveDoctorChatMessageApi(String message, String image) async {
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'message': message,
        'consult_id': consultId,
        'doctor_id': doctorId,
        'image': image,
      });
      print("gdh");
      print(formData.fields);
      final response = await dio.post(AppUrlConstant.baseUrlDoctor + AppUrlConstant.saveDoctorChatMessage,data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("sssssdf"+list.toString());
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
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


  /// checkMesagesCount ///////////////////////////////////////////////////////

  Future<List<MessageCountModel>> checkMesagesCountApi() async {
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);

    List list;
    List<MessageCountModel> messageCountModel;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'consult_id': consultId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.checkMesagesCount, data: formData);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds"+response.data);
        list = jsonDecode(response.data);
        messageCountModel = list.map((data) => new MessageCountModel.fromJson(data)).toList();
        print(list);
        if (list[0]['status'] == 1) {
          // Fluttertoast.showToast(msg: list[0]['msg'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
          print("dataaaaa"+messageCountModel[0].data.num.toString());
          print("status Code : " + list[0]['status'] .toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
      }
      return messageCountModel;
    } catch (e) {
      print(e);
    }
  }


  /// sendChatNotification api  ///////////////////////////////////////////////////////

  Future<ApiResponse> sendChatNotificationApi() async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.USERID);
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);

    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
       // 'UserId': userId,
        'ConsultId': consultId,
      });
      print("gdh");
      print(formData.fields);
      final response = await dio.post(AppUrlConstant.baseUrlDoctor + AppUrlConstant.sendChatNotification,data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("sssssdf"+list.toString());
        if (list[0]['status'] == 1) {
        // await SharedPrefManager.savePrefString(AppConstant.STATUS, list[0]['status']);

          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
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

  /// sendCallNotification api  ///////////////////////////////////////////////////////

  Future<ApiResponse> sendCallNotificationApi(VideoUrl) async {
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.USERID);
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);

    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
       // 'UserId': userId,
        'ConsultId': consultId,
        'VideoUrl': VideoUrl,
      });
      print("gdh");
      print(formData.fields);
      final response = await dio.post(AppUrlConstant.baseUrlDoctor + AppUrlConstant.sendCallNotification,data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("sssssdf"+list.toString());
        if (list[0]['status'] == 1) {
        // await SharedPrefManager.savePrefString(AppConstant.STATUS, list[0]['status']);
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
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


  /// callingApi   ///////////////////////////////////////////////////////

  Future<ApiResponse> callingApi() async {
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);


    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'consult_id': consultId,
        'call_status': "call_iniated",
      });
      print("callingApi");
      print(formData.fields);
      final response = await dio.post('https://apolloeclinic.com/API/V1/Doctor/updateCallStatus',data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("callingApi"+list.toString());
        if (list[0]['status'] == 1) {
        // await SharedPrefManager.savePrefString(AppConstant.STATUS, list[0]['status']);
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
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

  /// getMedicalHistory ////////////////////////////////////////////////////

  Future<List<GetMedicalHistoryModel>> getMedicalHistoryApi() async {
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    List<GetMedicalHistoryModel> getMedicalHistoryModel=[];
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'ConsultId': consultId,
      });
      print("ghsdgdhss");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.getMedicalHistory, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("kajsgdhka"+list.toString());
        getMedicalHistoryModel = list.map((data) => new GetMedicalHistoryModel.fromJson(data)).toList();
        if (getMedicalHistoryModel[0].status == 1) {
          print("kajsgdhka"+getMedicalHistoryModel.toString());
          Fluttertoast.showToast(msg: getMedicalHistoryModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + getMedicalHistoryModel[0].status.toString());
          print("Massage : " + getMedicalHistoryModel[0].msg.toString());
          // gets.Get.off(PaymentConfirmedPage(),
          //     transition: Transition.rightToLeftWithFade,
          //     duration: Duration(milliseconds: 600));
        } else {
          Fluttertoast.showToast(msg: getMedicalHistoryModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return getMedicalHistoryModel;
    } catch (e) {
      print(e);
    }
  }


  /// chatStatus api  ///////////////////////////////////////////////////////

  Future<ApiResponse> chatStatusApi() async {
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    print("gdh");
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'consultid': consultId,
        'doctorid': doctorId,
      });
      print("gdh");
      print(formData.fields);
      final response = await dio.post(AppUrlConstant.baseUrlDoctor + AppUrlConstant.chatStatus,data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("sssssdf"+list.toString());
        if (list[0]['status'] == 1) {
          await SharedPrefManager.savePrefString(AppConstant.COMPLETECONSULTATIONSTS, "1");
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + list[0]['status'].toString());
          print("Massage : " + list[0]['msg'].toString());
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
    } catch (e) {
      print(e);
      print("udhlasjk;");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}