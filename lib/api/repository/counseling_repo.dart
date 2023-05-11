// @dart=2.9

import 'dart:convert';

import 'package:aec_medical_doctor/api/base/api_response.dart';
import 'package:aec_medical_doctor/api/exception/api_error_handler.dart';
import 'package:aec_medical_doctor/model/newcounselling_model.dart';
import 'package:aec_medical_doctor/model/oldcounselling_model.dart';
import 'package:aec_medical_doctor/model/show_counseling_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../AppConstant.dart';
import '../AppUrlConstant.dart';
import '../sharedprefrence.dart';
import 'package:get/get.dart' as gets;

class CounselingRepo extends ChangeNotifier{



  Future<ApiResponse> addFollowUp(String reason,String date,String time) async {
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);

    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'consultid': consultId,
        'reasone': reason,
        'date': date,
        'time': time
      });

      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.doctorFollowup, data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        print(response.data);
        list = jsonDecode(response.data);
        if (list[0]['status'] == 0) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          gets.Get.back();
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


  /// add counseling ////////////////////////////////////////////////////



  Future<ApiResponse> addCouncelingApi(String name,String title, String price, String offerprice,String startdate, String hour, String minute,
      String duration, String link, String subject, String description) async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorId,
        'name': name,
        'title': title,
        'price': price,
        'start_date': startdate,
        'hour': hour,
        'minute': minute,
        'duration': duration,
        'link': link,
        'subject': subject,
        'description': description,
        'offer_price': offerprice,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.addCounceling, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          gets.Get.back();
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

  /// showCounseling ////////////////////////////////////////////////////

  Future<List<ShowCounselingData>> showCounselingApi() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    List<ShowCounselingData> showCounselingData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.showCounseling, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        showCounselingData = list.map((data) => new ShowCounselingData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + showCounselingData[0].name);
        return showCounselingData;
      }
    } catch (e) {
      print(e);
    }
  }


  /// editCounceling /////////////////////////////////////////////////////////////

  Future<ApiResponse> editCouncelingApi(String drcounselingid,String name,String title, String price, String offerprice,var startdate, String hour, String minute,
      String duration, String link, String subject, String description) async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'dr_counseling_id': drcounselingid,
        'doctor_id': doctorId,
        'name': name,
        'title': title,
        'price': price,
        'start_date': startdate,
        'hour': hour,
        'minute': minute,
        'duration': duration,
        'link': link,
        'subject': subject,
        'description': description,
        'offer_price': offerprice,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.editCounceling, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        if (list[0]['status'] == 1) {
          Fluttertoast.showToast(msg: list[0]['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          gets.Get.back();
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



  /// newCounseling  ////////////////////////////////////////////////////

  Future<List<NewCounselingData>> newCounselingApi() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List<NewCounselingData> newCounselingData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.assignCounseling, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        newCounselingData = list.map((data) => new NewCounselingData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + newCounselingData[0].title);
        return newCounselingData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// oldCounseling  ////////////////////////////////////////////////////

  Future<List<OldCounselingData>> oldCounselingApi() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List<OldCounselingData> oldCounselingData;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.assignOldCounseling, data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        oldCounselingData = list.map((data) => new OldCounselingData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + oldCounselingData[0].title);
        return oldCounselingData;
      }
    } catch (e) {
      print(e);
    }
  }

}