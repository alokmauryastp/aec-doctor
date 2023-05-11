// @dart=2.9
import 'dart:async';

import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/chat_repo.dart';
import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/api/repository/prescription_repo.dart';
import 'package:aec_medical_doctor/api/repository/templete_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/model/AdviceModel.dart';
import 'package:aec_medical_doctor/model/chatModel/messagecount_model.dart';
import 'package:aec_medical_doctor/model/oldpatients_model.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/model/showquestion_model.dart';
import 'package:aec_medical_doctor/model/showtest_model.dart';
import 'package:aec_medical_doctor/model/upcomingpatient_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/settings/updatewaitingtime_page.dart';
import 'package:aec_medical_doctor/pages/newchat/newchatscreen.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../notification_page.dart';

class SubmitPrescriptionPage extends StatefulWidget {
  @override
  _SubmitPrescriptionPageState createState() => _SubmitPrescriptionPageState();
}

class _SubmitPrescriptionPageState extends State<SubmitPrescriptionPage> {

  // GetProfileData profiledata = Get.arguments;
  final formKey = GlobalKey<FormState>();


   Future future;

  bool isTyppingStart = false;
  bool show = false;
  FocusNode focusNode = FocusNode();

  var _enteredMessage = '',base64Image = '';
  final controller = new TextEditingController();

  bool checkboxValueadvice = false;
  List<String> selectedadvices = [];
  List<AdviceDatum> advices = [];
  bool isLoading = false;
  void getAdvice() async {
    advices.clear();
    setState(() {
      isLoading = true;
    });
    TemplateRep().getAdvice().then((value) {
      print(value);
      if (value['status'] == 1) {
        print("success full");
        print(value);
        for (int i = 0; i < value['data'].length; i++) {
          AdviceDatum data = AdviceDatum.fromJson(value['data'][i]);
          advices.add(data);
        }
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  /// question ///////////////////////////////
  List<String> selectedquestions = [];
  List<QnDatum> questions = [];
  void getQuestion() async {
    questions.clear();
    setState(() {
      isLoading = true;
    });
    TemplateRep().getQuestionList().then((value) {
      print(value);
      if (value['status'] == 1) {
        print("success full");
        print(value);
        for (int i = 0; i < value['data'].length; i++) {
          QnDatum data = QnDatum.fromJson(value['data'][i]);
          questions.add(data);
        }
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  /// tests ///////////////////////////////////////////////////////////////
  List<String> selectedtests = [];
  List<TestDatum> testList = [];
  void getTestList() async {
    testList.clear();
    setState(() {
      isLoading = true;
    });
    TemplateRep().getTestList().then((value) {
      print(value);
      if (value['status'] == 1) {
        print("successfull");
        for (int i = 0; i < value['data'].length; i++) {
          TestDatum data = TestDatum.fromJson(value['data'][i]);
          testList.add(data);
        }
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  List<String> dose = [];
  List<String> strength = [];
  List<String> medicianname = [];
  List<String> duration = [];
  List<String> instruction = [];

  List<int> addRow = [];


  List<String> title = [];
  List<String> description = [];

  List<int> addRowadvice = [];

  List<String> test = [];
  List<String> descriptiontest = [];

  List<int> addRowtests = [];
  final _comments = TextEditingController();

  bool _isLoad = false;

   submitprescription()async{
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoad = true;
      });
      PrescriptionRepo prescriptionRepo = new PrescriptionRepo();
      await prescriptionRepo.submitPrescriptionApi(_comments.text,  medicianname, strength, dose,  duration,
          instruction,  title, description, test, descriptiontest);
      setState(() {
        _isLoad = false;
      });
    }

  }



  // print("checkkkkkkk:  "+medicianname.toList().toString());
  // print("checkkkkkkk:  "+strength.toList().toString());
  // print("checkkkkkkk:  "+dose.toList().toString());
  // print("checkkkkkkk:  "+duration.toList().toString());
  // print("checkkkkkkk:  "+instruction.toList().toString());
  // print("check:  "+title.toList().toString());
  // print("check:  "+description.toList().toString());
  // print("checkit:  "+test.toList().toString());
  // print("checkit:  "+descriptiontest.toList().toString());

  Timer timer;

  @override
  void initState() {
    getAdvice();
    getQuestion();
    getTestList();
     addRow.add(1);
     addRowadvice.add(1);
     addRowtests.add(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appbarbackgroundColor,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 30,
                    width: 30,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(NotificationPage(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(milliseconds: 600));
                    },
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Medications",style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.appbarbackgroundColor
                            ),),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    // addRow.clear();
                                    formKey.currentState.save();
                                    setState(() {
                                      addRow.add(addRow.length+1);
                                    });
                                  },
                                  child: CircleAvatar(backgroundColor: AppColors.whitetextColor,
                                      radius: 15,
                                      child: Icon(Icons.add,size: 20, color: Colors.black,)),
                                ),

                                SizedBox(width: 6,),
                                InkWell(
                                    onTap: (){
                                              // addRow.remove("value");
                                              setState(() {
                                               addRow.remove(addRow.length--);
                                              });
                                            },
                                  child: CircleAvatar(backgroundColor: AppColors.whitetextColor,
                                      radius: 15,
                                      child: Icon(Icons.remove,size: 20, color: Colors.black,)),
                                ),
                                SizedBox(width: 6,),
                                InkWell(
                                  // onTap: () {
                                  //   showDialog(
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return Question(
                                  //             question: questions,
                                  //             selectedquestion: selectedquestions,
                                  //             onSelectedQuestionListChanged: (question) {
                                  //               selectedquestions = question;
                                  //               print(selectedquestions);
                                  //             });
                                  //       });
                                  // },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      gradient: LinearGradient(colors: [
                                        Colors.black26,
                                        Colors.black87,
                                      ]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Text("Templates Medicine",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(20,10,20,10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: addRow.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // Align(
                                    //   alignment: Alignment.centerRight,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(right: 7.0),
                                    //     child: InkWell(
                                    //       onTap: (){
                                    //         print("indexsss"+index.toString());
                                    //         // addRow.remove("value");
                                    //         // int newIndex = index;
                                    //         setState(() {
                                    //          addRow.removeWhere((element) => element == index);
                                    //         });
                                    //       },
                                    //       child: Icon(Icons.delete_outline,size: 28,
                                    //         color: Colors.red.shade700,),
                                    //     ),
                                    //   ),
                                    // ),

                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            " medicine Name",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  medicianname.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  // contentPadding: EdgeInsets.only(left: 5),
                                                  hintText: "Medicine Name",
                                                ),
                                                validator: (value) {
                                                  if (value.trim().isEmpty) {
                                                    return "Please, enter the Medicine Name";
                                                  }

                                                  return null;
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Strength",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  strength.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  hintText: "Strength",
                                                ),
                                                validator: (value) {
                                                  if (value.trim().isEmpty) {
                                                    return "Please, enter the strength";
                                                  }

                                                  return null;
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Dose",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  dose.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  hintText: "Dose",
                                                ),
                                                validator: (value) {
                                                  if (value.trim().isEmpty) {
                                                    return "Please, enter dose";
                                                  }

                                                  return null;
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Duration",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  duration.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  hintText: "Duration",
                                                ),
                                                validator: (value) {
                                                  if (value.trim().isEmpty) {
                                                    return "Please, enter the Medicine Name";
                                                  }

                                                  return null;
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            " Instruction",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  instruction.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  hintText: "Instruction",
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    // _deletefield(),
                                  ],
                                ),
                              );
                            }),
                      ),


                    ],
                  ),

                  SizedBox(height: 30,),
                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Advice",style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: AppColors.appbarbackgroundColor
                            ),),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    // addRow.clear();
                                    formKey.currentState.save();
                                    setState(() {
                                      addRowadvice.add(addRowadvice.length+1);
                                    });
                                  },
                                  child: CircleAvatar(backgroundColor: AppColors.whitetextColor,
                                      radius: 15,
                                      child: Icon(Icons.add,size: 20, color: Colors.black,)),
                                ),

                                SizedBox(width: 6,),
                                InkWell(
                                  onTap: (){
                                    // addRow.remove("value");
                                    setState(() {
                                      addRow.remove(addRowadvice.length--);
                                    });
                                  },
                                  child: CircleAvatar(backgroundColor: AppColors.whitetextColor,
                                      radius: 15,
                                      child: Icon(Icons.remove,size: 20, color: Colors.black,)),
                                ),
                                SizedBox(width: 6,),
                                InkWell(
                                  // onTap: () {
                                  //   showDialog(
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return _Advices(
                                  //             advice: advices,
                                  //             selectedadvices: selectedadvices,
                                  //             onSelectedAdviceListChanged: (advice) {
                                  //               selectedadvices = advice;
                                  //               print(selectedadvices);
                                  //             });
                                  //       });
                                  // },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      gradient: LinearGradient(colors: [
                                        Colors.black26,
                                        Colors.black87,
                                      ]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Text("Templates Advice",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(20,10,20,10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: addRowadvice.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // Align(
                                    //   alignment: Alignment.centerRight,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(right: 7.0),
                                    //     child: InkWell(
                                    //       onTap: (){
                                    //         print("indexsss"+index.toString());
                                    //         // addRow.remove("value");
                                    //         // int newIndex = index;
                                    //         setState(() {
                                    //          addRow.removeWhere((element) => element == index);
                                    //         });
                                    //       },
                                    //       child: Icon(Icons.delete_outline,size: 28,
                                    //         color: Colors.red.shade700,),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            " Title",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  title.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  // contentPadding: EdgeInsets.only(left: 5),
                                                  hintText: "Title",
                                                ),
                                                validator: (value) {
                                                  if (value.trim().isEmpty) {
                                                    return "Please, enter the Title";
                                                  }

                                                  return null;
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Description",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  description.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  hintText: "Description",
                                                ),
                                                validator: (value) {
                                                  if (value.trim().isEmpty) {
                                                    return "Please, enter the Description";
                                                  }

                                                  return null;
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),

                  SizedBox(height: 30,),
                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tests",style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: AppColors.appbarbackgroundColor
                            ),),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    // addRow.clear();
                                    formKey.currentState.save();
                                    setState(() {
                                      addRowtests.add(addRowtests.length+1);
                                    });
                                  },
                                  child: CircleAvatar(backgroundColor: AppColors.whitetextColor,
                                      radius: 15,
                                      child: Icon(Icons.add,size: 20, color: Colors.black,)),
                                ),

                                SizedBox(width: 6,),
                                InkWell(
                                  onTap: (){
                                    // addRow.remove("value");
                                    setState(() {
                                      addRow.remove(addRowtests.length--);
                                    });
                                  },
                                  child: CircleAvatar(backgroundColor: AppColors.whitetextColor,
                                      radius: 15,
                                      child: Icon(Icons.remove,size: 20, color: Colors.black,)),
                                ),
                                SizedBox(width: 6,),
                                InkWell(
                                  // onTap: () {
                                  //   showDialog(
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return Test(
                                  //             test: testList,
                                  //             selectedtest: selectedtests,
                                  //             onSelectedTestListChanged: (question) {
                                  //               selectedtests = question;
                                  //               print(selectedtests);
                                  //             });
                                  //       });
                                  // },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      gradient: LinearGradient(colors: [
                                        Colors.black26,
                                        Colors.black87,
                                      ]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Text("Templates Test",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(20,10,20,10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: addRowtests.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // Align(
                                    //   alignment: Alignment.centerRight,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(right: 7.0),
                                    //     child: InkWell(
                                    //       onTap: (){
                                    //         print("indexsss"+index.toString());
                                    //         // addRow.remove("value");
                                    //         // int newIndex = index;
                                    //         setState(() {
                                    //          addRow.removeWhere((element) => element == index);
                                    //         });
                                    //       },
                                    //       child: Icon(Icons.delete_outline,size: 28,
                                    //         color: Colors.red.shade700,),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            " Test",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  test.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  // contentPadding: EdgeInsets.only(left: 5),
                                                  hintText: "Test",
                                                ),
                                                validator: (value) {
                                                  if (value.trim().isEmpty) {
                                                    return "Please, enter the Test";
                                                  }

                                                  return null;
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Description",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.appbarbackgroundColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: 50,
                                              width: Get.width / 1.7,
                                              decoration: BoxDecoration(
                                                color: AppColors.whitetextColor,
                                                borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20)),
                                                border: Border.all(color: AppColors.appbarbackgroundColor),
                                              ),
                                              child: TextFormField(
                                                // controller: _medicianname,
                                                onSaved: (value){
                                                  descriptiontest.add(value.toString());
                                                },
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.done,
                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                textAlignVertical: TextAlignVertical.top,
                                                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),
                                                  border: InputBorder.none,
                                                  hintText: "Description",
                                                ),
                                                validator: (value) {
                                                  if (value.trim().isEmpty) {
                                                    return "Please, enter the Description";
                                                  }

                                                  return null;
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  _commentsfield(),
                  SizedBox(height: 10,),
                  if(_isLoad) CircularProgressIndicator()
                  else _nextbutton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  _nextbutton() {
    // ignore: deprecated_member_use
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FlatButton(
            onPressed: () async{
              medicianname.clear();
              strength.clear();
              dose.clear();
              duration.clear();
              instruction.clear();
              title.clear();
              description.clear();
              test.clear();
              descriptiontest.clear();
              formKey.currentState.save();

              print("checkkkkkkk:  "+medicianname.toList().toString());
              print("checkkkkkkk:  "+strength.toList().toString());
              print("checkkkkkkk:  "+dose.toList().toString());
              print("checkkkkkkk:  "+duration.toList().toString());
              print("checkkkkkkk:  "+instruction.toList().toString());
              print("check:  "+title.toList().toString());
              print("check:  "+description.toList().toString());
              print("checkit:  "+test.toList().toString());
              print("checkit:  "+descriptiontest.toList().toString());
             await submitprescription();
                // await SharedPrefManager.savePrefString(AppConstant.PATIENTNAME, _patientname.text );
                // await SharedPrefManager.savePrefString(AppConstant.PATIENTAGE, _patientage.text);
                // await SharedPrefManager.savePrefString(AppConstant.PATIENTADDRESS, _patientaddress.text);
                // await SharedPrefManager.savePrefString(AppConstant.PATIENTOEX, _patientOex.text);
                // await SharedPrefManager.savePrefString(AppConstant.PATIENTPD, _patientPd.text);
                //
                // String name = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTNAME);
                // String age = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTAGE);
                // String gen = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTGENDER);
                // String add = await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTADDRESS);
                // print("shsas"+name);
                // print("aa"+age);
                // print("shsas"+gen);
                // print("shsas"+add);
                // Get.off(FindDoctorsPage(),
                //     transition: Transition.rightToLeftWithFade,
                //     duration: Duration(milliseconds: 600));

            },
            child:
            CustomButton(text1: "", text2: "Submit", width: 150, height: 45)),
      ),
    );
  }

  _commentsfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " Comments",
            style: StringsStyle.normaltextstyle,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
               height: 70,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.whitetextColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.appbarbackgroundColor),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(3, 3))
                ],
              ),
              child: TextFormField(
                controller: _comments,
                keyboardType: TextInputType.text,
                maxLines: 10,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                      new BorderSide(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide:
                      new BorderSide(color: Colors.yellow, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "  Comments",
                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Please, enter the Comments";
                  }

                  return null;
                },
              )),
        ],
      ),
    );
  }

}


/// advices ////////////////////////////////////////////////////////////////////

class _Advices extends StatefulWidget {
  _Advices({
    this.advice,
    this.selectedadvices,
    this.onSelectedAdviceListChanged,
  });

  final List<AdviceDatum> advice;
  final List<String> selectedadvices;
  final ValueChanged<List<String>> onSelectedAdviceListChanged;

  @override
  __AdvicesState createState() => __AdvicesState();
}

class __AdvicesState extends State<_Advices> {
  List<String> _tempSelectedAdvices = [];


  void _sendMessage() async {
    String advice = await SharedPrefManager.getPrefrenceString(AppConstant.ADVICE);
    FocusScope.of(context).unfocus();
    setState(() {
      String replaceString = advice.replaceAll(new RegExp(r'[^\w\s]+'),'');
      Provider.of<ChatRepo>(context,listen: false).saveDoctorChatMessageApi( replaceString,'');});
  }

  @override
  void initState() {
    _tempSelectedAdvices = widget.selectedadvices;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Text(
              'ADVICES',
              style: TextStyle(fontSize: 20.0, color: AppColors.appbarbackgroundColor,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(fontSize: 15.0, color: Colors.black,fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Select',
                    style: TextStyle(fontSize: 15.0, color: Colors.black,fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.advice.length,
                  itemBuilder: (BuildContext context, int index) {
                    AdviceDatum cityName = widget.advice[index];
                    return Container(
                      child: CheckboxListTile(
                          title: Text(cityName.description.toString()),
                          value: _tempSelectedAdvices.contains(cityName.title),
                          onChanged: (bool value) {
                            if (value) {
                              if (!_tempSelectedAdvices.contains(cityName.title)) {
                                setState(() {
                                  _tempSelectedAdvices.add(cityName.title.toString());
                                });
                              }
                            } else {
                              if (_tempSelectedAdvices.contains(cityName.title)) {
                                setState(() {
                                  _tempSelectedAdvices.removeWhere(
                                          (String city) => city == cityName.title);
                                });
                              }
                            }
                            widget.onSelectedAdviceListChanged(_tempSelectedAdvices);
                          }),
                    );
                  }),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,bottom: 10.0),
                  child:InkWell(
                    onTap: () async{
                      await SharedPrefManager.savePrefString(AppConstant.ADVICE,_tempSelectedAdvices.toString());
                      String advice = await SharedPrefManager.getPrefrenceString(AppConstant.ADVICE);
                      if(_tempSelectedAdvices.toList().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select then send",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black,
                            textColor: Colors.white);
                      }else{
                        await  Navigator.pop(context);
                        _sendMessage();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                        gradient: LinearGradient(colors: [
                          AppColors.appbarbackgroundColor,
                          AppColors.appbarbackgroundColor,
                        ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Send',
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



/// Question ////////////////////////////////////////////////////////////////////

class Question extends StatefulWidget {
  Question({
    this.question,
    this.selectedquestion,
    this.onSelectedQuestionListChanged,
  });

  final List<QnDatum> question;
  final List<String> selectedquestion;
  final ValueChanged<List<String>> onSelectedQuestionListChanged;

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  List<String> _tempSelectedQuestion = [];


  void _sendMessage() async {
    String question = await SharedPrefManager.getPrefrenceString(AppConstant.QUESTION);
    FocusScope.of(context).unfocus();
    setState(() {
      String replaceString = question.replaceAll(new RegExp(r'[^\w\s]+'),'');
      Provider.of<ChatRepo>(context,listen: false).saveDoctorChatMessageApi( replaceString,'');});
  }

  @override
  void initState() {
    _tempSelectedQuestion = widget.selectedquestion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Text(
              'QUESTION',
              style: TextStyle(fontSize: 20.0, color: AppColors.appbarbackgroundColor,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(fontSize: 15.0, color: Colors.black,fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Select',
                    style: TextStyle(fontSize: 15.0, color: Colors.black,fontWeight: FontWeight.w700),
                  ),

                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.question.length,
                  itemBuilder: (BuildContext context, int index) {
                    QnDatum cityName = widget.question[index];
                    return Container(
                      child: CheckboxListTile(
                          title: Text(cityName.question.toString()),
                          value: _tempSelectedQuestion.contains(cityName.question),
                          onChanged: (bool value) {
                            if (value) {
                              if (!_tempSelectedQuestion.contains(cityName.question)) {
                                setState(() {
                                  _tempSelectedQuestion.add(cityName.question.toString());
                                });
                              }
                            } else {
                              if (_tempSelectedQuestion.contains(cityName.question)) {
                                setState(() {
                                  _tempSelectedQuestion.removeWhere(
                                          (String city) => city == cityName.question);
                                });
                              }
                            }
                            widget.onSelectedQuestionListChanged(_tempSelectedQuestion);
                          }),
                    );
                  }),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,bottom: 10.0),
                  child:InkWell(
                    onTap: () async{
                      await SharedPrefManager.savePrefString(AppConstant.QUESTION,_tempSelectedQuestion.toString());
                      String advice = await SharedPrefManager.getPrefrenceString(AppConstant.QUESTION);
                      if(_tempSelectedQuestion.toList().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select then send",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black,
                            textColor: Colors.white);
                      }else{
                        await  Navigator.pop(context);
                        _sendMessage();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                        gradient: LinearGradient(colors: [
                          AppColors.appbarbackgroundColor,
                          AppColors.appbarbackgroundColor,
                        ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Send',
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// tests ////////////////////////////////////////////////////////////////////

class Test extends StatefulWidget {
  Test({
    this.test,
    this.selectedtest,
    this.onSelectedTestListChanged,
  });

  final List<TestDatum> test;
  final List<String> selectedtest;
  final ValueChanged<List<String>> onSelectedTestListChanged;

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> _tempSelectedTest = [];


  void _sendMessage() async {
    String test = await SharedPrefManager.getPrefrenceString(AppConstant.TESTS);
    FocusScope.of(context).unfocus();
    setState(() {
      String replaceString = test.replaceAll(new RegExp(r'[^\w\s]+'),'');
      Provider.of<ChatRepo>(context,listen: false).saveDoctorChatMessageApi( replaceString,'');});
  }

  @override
  void initState() {
    _tempSelectedTest = widget.selectedtest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Text(
              'Tests',
              style: TextStyle(fontSize: 20.0, color: AppColors.appbarbackgroundColor,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(fontSize: 15.0, color: Colors.black,fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Select',
                    style: TextStyle(fontSize: 15.0, color: Colors.black,fontWeight: FontWeight.w700),
                  ),

                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.test.length,
                  itemBuilder: (BuildContext context, int index) {
                    TestDatum cityName = widget.test[index];
                    return Container(
                      child: CheckboxListTile(
                          title: Text(cityName.test.toString()),
                          value: _tempSelectedTest.contains(cityName.test),
                          onChanged: (bool value) {
                            if (value) {
                              if (!_tempSelectedTest.contains(cityName.test)) {
                                setState(() {
                                  _tempSelectedTest.add(cityName.test.toString());
                                });
                              }
                            } else {
                              if (_tempSelectedTest.contains(cityName.test)) {
                                setState(() {
                                  _tempSelectedTest.removeWhere(
                                          (String city) => city == cityName.test);
                                });
                              }
                            }
                            widget.onSelectedTestListChanged(_tempSelectedTest);
                          }),
                    );
                  }),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,bottom: 10.0),
                  child:InkWell(
                    onTap: () async{
                      await SharedPrefManager.savePrefString(AppConstant.TESTS,_tempSelectedTest.toString());
                      String advice = await SharedPrefManager.getPrefrenceString(AppConstant.QUESTION);
                      if(_tempSelectedTest.toList().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select then send",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black,
                            textColor: Colors.white);
                      }else{
                        await  Navigator.pop(context);
                        _sendMessage();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                        gradient: LinearGradient(colors: [
                          AppColors.appbarbackgroundColor,
                          AppColors.appbarbackgroundColor,
                        ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Send',
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}