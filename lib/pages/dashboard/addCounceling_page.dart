// @dart=2.9
import 'dart:io';
import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/auth_repo.dart';
import 'package:aec_medical_doctor/api/repository/counseling_repo.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/controller/profile_controller.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/model/profile/symptoms_model.dart';
import 'package:aec_medical_doctor/model/speciality_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class AddCouncelingPage extends StatefulWidget {
  const AddCouncelingPage({Key key}) : super(key: key);

  @override
  _AddCouncelingPageState createState() => _AddCouncelingPageState();
}

class _AddCouncelingPageState extends State<AddCouncelingPage> {
  final _formKey = GlobalKey<FormState>();



  List<String> _genders = ['10','20','30','40','50','60'];


  DateTime selectedDate = DateTime.now();
  var formatDate;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),);

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDate = selectedDate.year.toString() + "/"+selectedDate.month.toString() + "/" +selectedDate.day.toString();
      });
    }
  }

  String _selectgen;








  final _name = TextEditingController();
  final _price = TextEditingController();
  final _offerprice = TextEditingController();
  final _title = TextEditingController();
  final _dob = TextEditingController();
  final _duration = TextEditingController();
  final _subject = TextEditingController();
  final _link = TextEditingController();
  final _description = TextEditingController();
  final _hour = TextEditingController();
  final _minutes = TextEditingController();



  bool _isLoad = false;

  void _submit()async{
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoad = true;
      });
      CounselingRepo counselingRepo = new CounselingRepo();
      await counselingRepo.addCouncelingApi(_name.text,_title.text, _price.text,_offerprice.text,formatDate,_hour.text,_minutes.text,_duration.text,_link.text,_subject.text,_description.text);
      setState(() {
        _isLoad = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, size: 25)),
          title: Text(
            "Add Counseling",
            style: StringsStyle.pagetitlestyle,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(children: [
                      SizedBox(height: 2),
                      _editprofilebody(),
                    ])))));
  }



  _editprofilebody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
          key: _formKey,
          child: Column(children: [
            Container(
                // height: 50,
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
                    Colors.white,
                    Colors.white70,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Counseling Name",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) => value.isEmpty
                      ? 'Enter Your Counseling Name'
                      :RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
                      ? 'Enter a Valid Counseling Name'
                      : null,
                )),
            SizedBox(height: 15),
            Container(
                // height: 50,
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
                    Colors.white,
                    Colors.white70,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: _title,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Title",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your Title";
                    }

                    return null;
                  },
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                // height: 50,
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
                    Colors.white,
                    Colors.white70,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Price",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your price";
                    }
                    return null;
                  },
                )),
            SizedBox(height: 15,),
            Container(
                // height: 50,
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
                    Colors.white,
                    Colors.white70,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: _offerprice,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Offer Price",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your offer price";
                    }
                    return null;
                  },
                )),
            SizedBox(height: 15),
            Container(
              height: 50,
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
                  Colors.white,
                  Colors.white70,
                ]),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  onTap:()=> _selectDate(context),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(formatDate ?? "Date",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black
                            ),),
                        ),
                        const Icon(Icons.keyboard_arrow_down_sharp)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    // height: 50,
                    width: 150,
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
                        Colors.white,
                        Colors.white70,
                      ]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.bottomLeft,
                    child: TextFormField(
                      controller: _hour,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                        labelText: "hour",
                        labelStyle: TextStyle(
                          color: AppColors.lighttextColor,
                          fontSize: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Please, enter your hour ";
                        }

                        return null;
                      },
                    )),
                Container(
                    // height: 50,
                    width: 150,
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
                        Colors.white,
                        Colors.white70,
                      ]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.bottomLeft,
                    child: TextFormField(
                      controller: _minutes,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                        labelText: "Minutes",
                        labelStyle: TextStyle(
                          color: AppColors.lighttextColor,
                          fontSize: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return "Please, enter your Minutes ";
                        }

                        return null;
                      },
                    )),
              ],
            ),
            SizedBox(height: 15),
            Container(
                // height: 50,
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
                    Colors.white,
                    Colors.white70,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: _duration,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Duration(In Hours)",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your Duration ";
                    }

                    return null;
                  },
                )),
            SizedBox(height: 15),
            Container(
                // height: 50,
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
                    Colors.white,
                    Colors.white70,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: _subject,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Counseling Subject",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your Counseling Subject";
                    }

                    return null;
                  },
                )),
            SizedBox(height: 15),
            Container(
                // height: 50,
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
                    Colors.white,
                    Colors.white70,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: _link,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Link",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your Link ";
                    }

                    return null;
                  },
                )),


            SizedBox(height: 15),
            Container(
                // height: 80,
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
                    Colors.white,
                    Colors.white70,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: _description,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                    new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Description",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please, enter your description";
                    }
                    return null;
                  },
                )),

            SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: InkWell(
                    onTap: () {
                     _submit();
                    },
                    child: CustomButton(
                        text1: "",
                        text2: "Submit",
                        width: Get.width,
                        height: 50)),
              ),
          ])),
    );
  }
}


