// @dart=2.9
import 'dart:convert';

import 'package:aec_medical_doctor/api/base/api_response.dart';
import 'package:aec_medical_doctor/api/exception/api_error_handler.dart';
import 'package:aec_medical_doctor/model/profile/symptoms_model.dart';
import 'package:aec_medical_doctor/model/speciality_model.dart';
import 'package:aec_medical_doctor/model/verifyotp_model.dart';
import 'package:aec_medical_doctor/pages/authentication/otp_page.dart';
import 'package:aec_medical_doctor/pages/authentication/otp_verify_page.dart';
import 'package:aec_medical_doctor/pages/authentication/update_documents_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/upcoming_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/home_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/profile/update_documents_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get.dart' as gets;

import '../AppConstant.dart';
import '../AppUrlConstant.dart';
import '../sharedprefrence.dart';
class AuthRepo extends ChangeNotifier {

  static bool kTry = true;

  ///  Doctor Login with otp API ///////////////////////////////////////////////////

  Future doctorloginwithotp(String mobile) async {
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'mobile': mobile,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.doctorloginwithotp, data: formData);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds"+response.data);
        list = jsonDecode(response.data);
        print(list);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("status Code : " + list[0]['status'] .toString());
          print("Massage : " + list[0]['msg'].toString());
          // await SharedPrefManager.savePrefString(AppConstant.MOBILE, mobile);
          gets.Get.to(OtpPage(), arguments: mobile,
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Internal Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  /// login otp verify /////////////////////////////////////////

  Future<List<VerifyOtpModel>> verifyOtpApi(String mobile, String pincode) async {
    List<VerifyOtpModel> verifyOtpModel=[];
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'mobile': mobile,
        'OTP': pincode,
      });
      print("gfsd");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.loginotpverify, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        verifyOtpModel = list.map((data) => new VerifyOtpModel.fromJson(data)).toList();
        print("gfjas");
        if (verifyOtpModel[0].status == 1) {
          await SharedPrefManager.savePrefString(
              AppConstant.MOBILE, verifyOtpModel[0].data.mobile);
          await SharedPrefManager.savePrefString(AppConstant.DOCTORID, verifyOtpModel[0].data.doctorId);
          await SharedPrefManager.savePrefString(AppConstant.COUNSELINGSTATUS, verifyOtpModel[0].data.counselingStatus);
          String mobile = await SharedPrefManager.getPrefrenceString(AppConstant.MOBILE);
          print("dhd" + mobile);
          Fluttertoast.showToast(msg: verifyOtpModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("Status Code : " + verifyOtpModel[0].status.toString());
          print("Massage : " + verifyOtpModel[0].msg.toString());
          await SharedPrefManager.savePrefString(AppConstant.FIRSTVERIFIY, verifyOtpModel[0].data.verifyStatus);
          if (verifyOtpModel[0].data.verifyStatus=="1") {
            await SharedPrefManager.savePreferenceBoolean(true);
            String counsellingstatus = await SharedPrefManager.getPrefrenceString(AppConstant.COUNSELINGSTATUS.toString());
            gets.Get.offAll(HomePage(),
                transition: Transition.rightToLeftWithFade,
                duration: Duration(milliseconds: 600));
          } else {
            gets.Get.offAll(OtpVerificationPage(),arguments: mobile,
                transition: Transition.rightToLeftWithFade,
                duration: Duration(milliseconds: 600));

          }
        }   else {
          Fluttertoast.showToast(msg: verifyOtpModel[0].msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }
      }
      return verifyOtpModel;
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Please enter valid otp",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  /// resend api ///////////////////////////////

  Future<ApiResponse> resendOtpApi(String mobile) async {
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'mobile': mobile,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.resendOtp, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
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






  /// signupupdate profile ////////////////////////////////////////////////////

  Future<ApiResponse> signupupdateproifileApi(String name ,String email, String mobile ,
      var dob ,String gender , String experiance , String highestqualification ,
      String qualification , String medicalregistrationid , var speciality, String symptoms, String award) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'name': name,
        'email': email,
        'mobile': mobile,
        'dob': dob,
        'gender':gender,
        'experiance': experiance,
        'highest_qualification': highestqualification,
        'qualification': qualification,
        'medical_registration_id': medicalregistrationid,
        'speciality': 8,
        'symptoms': symptoms,
        'award':award,
      });
      print("hhkhjkjkuh");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.profileUpdateSubmit, data: formData);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds"+response.data);
        list = jsonDecode(response.data);
        print(list);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("status Code : " + list[0]['status'] .toString());
          print("Massage : " + list[0]['msg'].toString());
          gets.Get.to(SigninUpdateDocumentPage(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));

        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  /// update clinicUpdate  ////////////////////////////////////////////////////

  Future<ApiResponse> clinicUpdateApi(String clinicname ,String address, String pincode , String state ,String district) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'clinic_name': clinicname,
        'address': address,
        'pincode': pincode,
        'state': state,
        'district':district,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.clinicUpdate, data: formData);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds"+response.data);
        list = jsonDecode(response.data);
        print(list);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("status Code : " + list[0]['status'] .toString());
          print("Massage : " + list[0]['msg'].toString());
          String counsellingstatus = await SharedPrefManager.getPrefrenceString(AppConstant.COUNSELINGSTATUS.toString());
          gets.Get.offAll(HomePage(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));

        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  /// update bankUpdate  ////////////////////////////////////////////////////

  Future<ApiResponse> bankUpdateApi(String accountholder ,String accountnumber, String ifsc , String bankname ,String branchname) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'account_holder': accountholder,
        'account_number': accountnumber,
        'ifsc': ifsc,
        'bank_name': bankname,
        'branch_name':branchname,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.bankUpdate, data: formData);
      print("hhkhjk");
      if (response.statusCode == 200) {
        print("dsfds"+response.data);
        list = jsonDecode(response.data);
        print(list);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print("status Code : " + list[0]['status'] .toString());
          print("Massage : " + list[0]['msg'].toString());
          // gets.Get.off(HomePage());

        } else {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          print(response.data[0]['msg'].toString());
        }
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  /// symptoms ////////////////////////////////////////////////////

  Future<List<SymptomsData>> symptomsApi() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<SymptomsData> symptomsData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.symptoms, data: formData);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "hey",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        symptomsData = list.map((data) => new SymptomsData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + symptomsData[0].symptoms);
        return symptomsData;
      }
    } catch (e) {
      print(e);
    }
  }




  /// speciality ////////////////////////////////////////////////////

  Future<List<SpecialityData>> specialityApi() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<SpecialityData> specialityData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.speciality, data: formData);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: "hey",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        specialityData = list.map((data) => new SpecialityData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + specialityData[0].speciality);
        return specialityData;
      }
    } catch (e) {
      print(e);
    }
  }



}