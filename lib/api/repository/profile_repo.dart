// @dart=2.9

import 'dart:convert';
import 'package:aec_medical_doctor/api/base/api_response.dart';
import 'package:aec_medical_doctor/api/exception/api_error_handler.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/upcoming_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/home_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/profile/update_documents_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get.dart' as gets;
import 'package:get/get_navigation/src/snackbar/snack.dart';
import '../AppConstant.dart';
import '../AppUrlConstant.dart';
import '../sharedprefrence.dart';

class ProfileRepo extends ChangeNotifier{


  /// get profile ///////////////////////////////////////////////////////

  Future<List<GetProfileModel>> getproifileApi() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List<GetProfileModel> getProfileModel;
    List list;
    Dio dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'UserId': doctorId,
      });
      print(formData.fields);
      final response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.getProfile, data: formData);
      if (response.statusCode == 200) {
        print("getproifileApi"+response.data);
        list = jsonDecode(response.data);
        getProfileModel = list.map((data) => new GetProfileModel.fromJson(data)).toList();
        print("gdssh");
        await SharedPrefManager.savePreferenceBoolean(true);
        await SharedPrefManager.savePrefString(
            AppConstant.MOBILE, getProfileModel[0].data.mobile);
        await SharedPrefManager.savePrefString(
            AppConstant.DOCTORID, getProfileModel[0].data.doctorId);
        await SharedPrefManager.savePrefString(
            AppConstant.IMAGE, getProfileModel[0].data.profile);
        await SharedPrefManager.savePrefString(
            AppConstant.NAME, getProfileModel[0].data.name);
        await SharedPrefManager.savePrefString(
            AppConstant.EMAIL, getProfileModel[0].data.email);
        await SharedPrefManager.savePrefString(
            AppConstant.DOB, getProfileModel[0].data.dOB);
        await SharedPrefManager.savePrefString(
            AppConstant.EXPERIANCE, getProfileModel[0].data.experiance);
        await SharedPrefManager.savePrefString(AppConstant.HQUALIFICATION,
            getProfileModel[0].data.highestQualification);
        await SharedPrefManager.savePrefString(
            AppConstant.QUALIFICATION, getProfileModel[0].data.qualification);
        await SharedPrefManager.savePrefString(
            AppConstant.SPECIALITY, getProfileModel[0].data.speciality);
        await SharedPrefManager.savePrefString(
            AppConstant.MEDICALREGISTRATIONID,
            getProfileModel[0].data.medicalRegistrationId);
        await SharedPrefManager.savePrefString(
            AppConstant.ADDRESS, getProfileModel[0].data.address);
        await SharedPrefManager.savePrefString(
            AppConstant.CLINICNAME, getProfileModel[0].data.clinicName);
        await SharedPrefManager.savePrefString(
            AppConstant.PINCODE, getProfileModel[0].data.pincode);
        await SharedPrefManager.savePrefString(
            AppConstant.STATE, getProfileModel[0].data.state);
        await SharedPrefManager.savePrefString(AppConstant.DISTRICT, getProfileModel[0].data.district);
        await SharedPrefManager.savePrefString(AppConstant.SYMPTOMS, getProfileModel[0].data.symptoms);



        // Fluttertoast.showToast(msg: list[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
        // print("dataaaaa"+getProfileModel[0].data.mobile);
        // print("status Code : " + list[0]['status'] .toString());
        // print("Massage : " + list[0]['msg'].toString());

      }
      return getProfileModel;
    } catch (e) {
      print(e);
    }
  }







  /// update profile ////////////////////////////////////////////////////

  Future<ApiResponse> updateproifileApi(String name ,String email, String mobile ,
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
        'speciality': speciality,
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
          gets.Get.to(UpdateDocumentPage(),
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
      print("hhkhjk");
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


  /// uploadPhotoIdFront ////////////////////////////////////////////////////

  Future<MultipartFile> uploadPhotoIdFrontApi(String filename) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List list;
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'photo_id_front': filename});
      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.uploadPhotoIdFront, data: formData);

      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        list = jsonDecode(response.data);
        print("dghjasggk");
        await SharedPrefManager.savePrefString(AppConstant.STATUSFRONTPHOTO, list[0]['status'].toString());
        Fluttertoast.showToast(msg: "Front photo Id upload successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        print(response.data);
        print("dhdjfhdfj");
      }
    } catch (e) {
      print(e);
    }
  }

  /// uploadPhotoIdBack ////////////////////////////////////////////////////

  Future<MultipartFile> uploadPhotoIdBackApi(String filename) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'photo_id_back': filename});
      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.uploadPhotoIdBack, data: formData);

      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Back photo Id upload successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        print(response.data);
        print("dhdjfhdfj");
      }
    } catch (e) {
      print(e);
    }
  }

  /// uploadSignature ////////////////////////////////////////////////////

  Future<MultipartFile> uploadSignatureApi(String filename) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'signature': filename});
      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.uploadSignature, data: formData);

      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Signature upload successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        print(response.data);
        print("dhdjfhdfj");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<MultipartFile> uploadSignatureImageApi() async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    String filename = await SharedPrefManager.getPrefrenceString(AppConstant.SIGNATUREIMAGE);
    // ByteData imageBytes = filename.readAsBytesSync();
    // String base64Image = base64.encode(imageBytes);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'signature': filename});
      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.uploadSignature, data: formData);

      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Signature upload successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        print(response.data);
        print("dhdjfhdfj");
      }
    } catch (e) {
      print(e);
    }
  }


  /// uploadQualificationImage ////////////////////////////////////////////////////

  Future<MultipartFile> uploadQualificationImageeApi(String filename) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'qualification_image': filename});
      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.uploadQualificationImagee, data: formData);

      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Qualification certificate upload successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        print(response.data);
        print("dhdjfhdfj");
      }
    } catch (e) {
      print(e);
    }
  }


  /// uploadMedicalRegistration ////////////////////////////////////////////////////

  Future<MultipartFile> uploadMedicalRegistrationApi(String filename) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'medical_registration_image': filename});
      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(
          AppUrlConstant.baseUrlDoctor + AppUrlConstant.uploadMedicalRegistration, data: formData);

      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Medical registration image upload successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        print(response.data);
        print("dhdjfhdfj");
      }
    } catch (e) {
      print(e);
    }
  }


  /// uploadIndemnityCertificate ////////////////////////////////////////////////////

  Future<MultipartFile> uploadIndemnityCertificateApi(String filename) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'indemnity_certificate': filename});
      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(AppUrlConstant.baseUrlDoctor + AppUrlConstant.uploadIndemnityCertificate, data: formData);
      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Indemnity Certificate upload successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        print(response.data);
        print("dhdjfhdfj");
      }
    } catch (e) {
      print(e);
    }
  }


  /// uploadProfileImage ////////////////////////////////////////////////////

  Future<MultipartFile> uploadProfileImageAPi(String filename) async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap({
        'doctor_id': doctorid,
        'profile': filename});
      print("xxxxxxxxxxxxxxxxxxxx"+formData.fields.toString());
      Response response = await dio.post(AppUrlConstant.baseUrlDoctor + AppUrlConstant.uploadProfileImage, data: formData);
      print("ghgghghhggh"+response.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Profile photo upload successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
        print(response.data);
        print("dhdjfhdfj");
      }
    } catch (e) {
      print(e);
    }
  }

}