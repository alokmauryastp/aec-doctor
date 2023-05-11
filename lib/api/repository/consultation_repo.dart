// // @dart=2.9
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get_navigation/src/routes/transitions_type.dart';
// import 'package:get/get.dart' as gets;
// import 'package:get/get_navigation/src/snackbar/snack.dart';
// import '../AppUrlConstant.dart';
//
// class ConsultationRepo extends ChangeNotifier {
//
//   /// symptoms ////////////////////////////////////////////////////
//
//   Future<List<SymptomsData>> symptomsApi() async {
//     String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
//     List<SymptomsData> symptomsData;
//     List list;
//     Dio dio = Dio();
//     try {
//       FormData formData = new FormData.fromMap({
//         'UserId': userId,
//       });
//       print(formData.fields);
//       final response = await dio.post(
//           AppUrlConstant.baseUrlUser + AppUrlConstant.symptoms, data: formData);
//
//       if (response.statusCode == 200) {
//         print("dsfds" + response.data);
//         list = jsonDecode(response.data);
//         list = list[0]['data'];
//         symptomsData = list.map((data) => new SymptomsData.fromJson(data)).toList();
//         print("hhdhd" + list.toString());
//         print("gdgd" + symptomsData[0].price);
//         return symptomsData;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//
//   /// speciality ////////////////////////////////////////////////////
//
//   Future<List<SpecialityData>> specialityApi() async {
//     String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
//     List list;
//     List<SpecialityData> specialityData;
//     Dio dio = Dio();
//     try {
//       FormData formData = new FormData.fromMap({
//         'UserId': userId,
//       });
//       print(formData.fields);
//       final response = await dio.post(
//           AppUrlConstant.baseUrlUser + AppUrlConstant.speciality, data: formData);
//
//       if (response.statusCode == 200) {
//         print("dsfds" + response.data);
//         list = jsonDecode(response.data);
//         list = list[0]['data'];
//         specialityData = list.map((data) => new SpecialityData.fromJson(data)).toList();
//         print("hhdhd" + list.toString());
//         print("gdgd" + specialityData[0].speciality);
//         return specialityData;
//       }
//     } catch (e) {e
//       print(e);
//     }
//   }
//
//   /// getDoctorDetails ////////////////////////////////////////////////////
//
//   Future<List<FindDoctorsData>> getDoctorDetailsApi() async {
//     String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
//     String table= await SharedPrefManager.getPrefrenceString(AppConstant.TABLE.toString());
//     String value= await SharedPrefManager.getPrefrenceString(AppConstant.VALUE.toString());
//     List list;
//     List<FindDoctorsData> findDoctorsData;
//     Dio dio = Dio();
//     try {
//       FormData formData = new FormData.fromMap({
//         'table': table,
//         'UserId': userId,
//         'value': value,
//       });
//       print(formData.fields);
//       final response = await dio.post(
//           AppUrlConstant.baseUrlUser + AppUrlConstant.getDoctorDetails, data: formData);
//       if (response.statusCode == 200) {
//         print("dsfds" + response.data);
//         list = jsonDecode(response.data);
//         list = list[0]['data'];
//         findDoctorsData = list.map((data) => new FindDoctorsData.fromJson(data)).toList();
//         print("hhdhd" + list.toString());
//         print("gdgd" + findDoctorsData[0].name);
//         return findDoctorsData;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
// }