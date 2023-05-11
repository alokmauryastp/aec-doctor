import 'dart:convert';

import 'package:aec_medical_doctor/api/AppUrlConstant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;


class CmsRepo{
   Future<dynamic> getFaqApi(String type) async {
    List faqList;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.faq),
          body: {
            'Type': type,
          });
      print(response.body);
      if (response.statusCode == 200) {
       
        faqList = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: faqList[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
          

        return faqList[0];
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return "";
    }
  }
}