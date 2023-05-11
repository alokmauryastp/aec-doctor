// // @dart=2.9
// import 'dart:convert';
// import 'package:aec_medical/model/offermodel/check_coupon_model.dart';
// import 'package:aec_medical/model/offermodel/offers_model.dart';
// import 'package:aec_medical/model/offermodel/offers_model.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../AppConstant.dart';
// import '../AppUrlConstant.dart';
// import '../sharedprefrence.dart';
//
// class OffersRepo extends ChangeNotifier{
//
//    /// coupon api ///////////////////////////////////////
//
//   Future<List<OffersData>> couponApi() async {
//     String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
//     List<OffersData> offersData;
//     List list;
//     Dio dio = Dio();
//     try {
//       FormData formData = new FormData.fromMap({
//         'UserId': userId,
//       });
//       print(formData.fields);
//       final response = await dio.post(
//           AppUrlConstant.baseUrlUser + AppUrlConstant.coupon, data: formData);
//
//       if (response.statusCode == 200) {
//         print("dsfds" + response.data);
//         list = jsonDecode(response.data);
//         list = list[0]['data'];
//         print("dhsdj"+list.toString());
//         offersData = list.map((data) => new OffersData.fromJson(data)).toList();
//         print("hhdhd" + list.toString());
//         print("gdgd" + offersData[0].couponCode);
//         return offersData;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   /// Check coupon code //////////////////////////////////////////////////////////
//
//
//
//   Future<List<CheckCouponModel>> checkcouponApi(String couponcode) async {
//     String userId = await SharedPrefManager.getPrefrenceString(AppConstant.CUSTOMERId);
//
//     List<CheckCouponModel> checkCouponModel=[];
//     List list;
//     Dio dio = Dio();
//     try {
//       FormData formData = new FormData.fromMap({
//         'coupon_code': couponcode,
//         'userid': userId,
//       });
//       print(formData.fields);
//       final response = await dio.post(
//           AppUrlConstant.baseUrlUser + AppUrlConstant.checkcoupon, data: formData);
//       if (response.statusCode == 200) {
//         list = jsonDecode(response.data);
//        print("shj"+list.toString());
//          if (list[0]['status'] == 1) {
//            checkCouponModel = list.map((data) => new CheckCouponModel.fromJson(data)).toList();
//           // await SharedPrefManager.savePrefString(AppConstant.MOBILE, otpVerifyModel[0].data.mobile);
//           // await SharedPrefManager.savePrefString(AppConstant.CUSTOMERId, otpVerifyModel[0].data.userId);
//           // await SharedPrefManager.savePrefString(AppConstant.IMAGE, otpVerifyModel[0].data.profile);
//           Fluttertoast.showToast(msg: checkCouponModel[0].msg,
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               backgroundColor: Colors.black,
//               textColor: Colors.white);
//           print("Status Code : " + checkCouponModel[0].status.toString());
//           print("Massagess : " + checkCouponModel[0].msg.toString());
//           // gets.Get.off(PrefferredLanguagePickerPage(),
//           //     transition: Transition.rightToLeftWithFade,
//           //     duration: Duration(milliseconds: 600));
//         } else {
//           Fluttertoast.showToast(msg: list[0]['msg'],
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               backgroundColor: Colors.black,
//               textColor: Colors.white);
//         }
//       }
//       return checkCouponModel;
//     } catch (e) {
//       print(e);
//     }
//   }
//
//
// }