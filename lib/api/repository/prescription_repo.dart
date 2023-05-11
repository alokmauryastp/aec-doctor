// @dart=2.9

import 'dart:convert';

import 'package:aec_medical_doctor/api/base/api_response.dart';
import 'package:aec_medical_doctor/api/exception/api_error_handler.dart';
import 'package:aec_medical_doctor/model/prescriptionModel/allprescription_model.dart';
import 'package:aec_medical_doctor/model/prescriptionModel/prescriptionDetails_model.dart';
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

class PrescriptionRepo extends ChangeNotifier {



  /// submitPrescription ////////////////////////////////////////////////////



  Future<ApiResponse> submitPrescriptionApi(String comment, var medicinename, var medicinestrength,
      var dose, var duration,
      var instruction, var advicetitle, var advicedescription, var test, var testdescription) async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    String consultId = await SharedPrefManager.getPrefrenceString(AppConstant.CONSULTID);
    String userId = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTPD);
    String patientname = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTNAME);
    String patientage = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTAGE);
    String address = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTADDRESS);
    String gender = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTGENDER);
    String o_ex = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTOEX);
    String pd = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTPD);
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctorid': doctorId,
        'consultid': consultId,
        'userid': userId,
        'patient_name': patientname,
        'patient_age': patientage,
        'address': address,
        'gender': gender,
        'o_ex': o_ex,
        'pd': pd,
        'comment': comment,
        'medicine_name': medicinename,
        'medicine_strength': medicinestrength,
        'dose': dose,
        'duration': duration,
        'instruction': instruction,
        'advice_title': advicetitle,
        'advice_description': advicedescription,
        'test': test,
        'test_description': testdescription,
      });

      print("dhskjlfhdksl");
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.submitPrescription, data: formData);
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("sdfgjshklfkhjl");
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

  /// showPrescription ////////////////////////////////////////////////////

  Future<List<AllPrescriptionData>> showPrescriptionApi() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(
        AppConstant.DOCTORID);
    List list;
    List<AllPrescriptionData> allPrescriptionData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'DoctorId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.showPrescription,
          data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        allPrescriptionData =
            list.map((data) => new AllPrescriptionData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + allPrescriptionData[0].address);
        return allPrescriptionData;
      }
    } catch (e) {
      print(e);
    }
  }

  /// singlePrescription ////////////////////////////////////////////////////

  Future<List<PrescriptionDetailsData>> singlePrescriptionApi() async {
    String prescriptionId = await SharedPrefManager.getPrefrenceString(AppConstant.PRESCRIPTIONID);
    List list;
    List<PrescriptionDetailsData> prescriptionDetailsData;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'PrescriptionId': prescriptionId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.singlePrescription,
          data: formData);
      if (response.statusCode == 200) {
        print("dsfds" + response.data);
        list = jsonDecode(response.data);
        list = list[0]['data'];
        prescriptionDetailsData =
            list.map((data) => new PrescriptionDetailsData.fromJson(data)).toList();
        print("hhdhd" + list.toString());
        print("gdgd" + prescriptionDetailsData[0].address);
        return prescriptionDetailsData;
      }
    } catch (e) {
      print(e);
    }
  }

}