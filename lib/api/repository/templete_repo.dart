import 'dart:convert';

import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/AppUrlConstant.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;


class TemplateRep{

  Future<dynamic> getMedicineList() async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List medicineList;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.showMedicine),
          body: {
            'doctor_id': doctorid,
          });
      //  print(response.body);
      if (response.statusCode == 200) {

        medicineList = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: medicineList[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return medicineList[0];
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





  Future<dynamic> getQuestionList() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

    List questionList;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.showQuestion),
          body: {
            'doctor_id': doctorId,
          });
      //  print(response.body);
      if (response.statusCode == 200) {

        questionList = jsonDecode(response.body);

        // Fluttertoast.showToast(
        //     msg: questionList[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);


        return questionList[0];
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

  Future<dynamic> getTestList() async {
    String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

    List testList;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.showTest),
          body: {
            'doctor_id': doctorId,
          });
      //  print(response.body);
      if (response.statusCode == 200) {

        testList = jsonDecode(response.body);

        // Fluttertoast.showToast(
        //     msg: testList[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);


        return testList[0];
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


  Future<dynamic> getQuestionAssistant() async {

    List testList;
    try {
      var response = await http.get(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.getQuestionAssistant),
        );
       print('getQuestionAssistant');
       print(response.body);
      if (response.statusCode == 200) {

        testList = jsonDecode(response.body);
        print(testList[0]['data']);



        // Fluttertoast.showToast(
        //     msg: testList[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);


        return testList[0]['data'];
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


  Future<dynamic>addMedicine(Map parameter)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.addMedicine),
          body: parameter

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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
  Future<dynamic>addQuestion(Map parameter)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.addQuestion),
          body: parameter

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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
  Future<dynamic>editQuestion(Map parameter)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.editQuestion),
          body: parameter

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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


  Future<dynamic>addTest(Map parameter)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.addTest),
          body: parameter

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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


  Future<dynamic>addAdvice(Map parameter)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.addAdvice),
          body: parameter

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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



  Future<dynamic> getAdvice() async {
    String doctorid = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
    List medicineList;
    try {
      print(doctorid);
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.getAdvice),
          body: {
            'doctor_id': doctorid,
          });
      //  print(response.body);
      if (response.statusCode == 200) {

        medicineList = jsonDecode(response.body);

        // Fluttertoast.showToast(
        //     msg: medicineList[0]['msg'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);


        return medicineList[0];
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



  Future<dynamic>editAdvice(Map parameter)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.editAdvice),
          body: parameter

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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



  Future<dynamic>deleteAdvice(adviceId)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.deleteAdvice),
          body: {
            'advice_id':adviceId
          }

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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

  Future<dynamic>editMedicine(Map parameter)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.editMedicine),
          body: parameter

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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

  Future<dynamic>deleteMedicine(medicineId)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.deleteMedicine),
          body: {
            "medicine_id": medicineId,
          }

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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


  Future<dynamic>editTest(Map parameter)async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.editTest),
          body: parameter

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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

  Future<dynamic>deleteTest(testId
      )async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.deleteTest),
          body: {
            "test_id": testId,
          }

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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



  Future<dynamic>deleteQuestion(question_id
      )async{
    List res;
    try {
      var response = await http.post(
          Uri.parse(AppUrlConstant.baseUrlDoctor + AppUrlConstant.deleteQuestion),
          body: {
            "question_id": question_id,
          }

      );
      //  print(response.body);
      if (response.statusCode == 200) {

        res  = jsonDecode(response.body);

        Fluttertoast.showToast(
            msg: res[0]['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);


        return res[0];
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