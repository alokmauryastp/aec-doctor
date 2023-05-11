// @dart=2.9
import 'dart:async';

import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/chat_repo.dart';
import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/model/chatModel/messagecount_model.dart';
import 'package:aec_medical_doctor/model/oldpatients_model.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/model/upcomingpatient_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/settings/updatewaitingtime_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/prescriptions/submit_prescription_page.dart';
import 'package:aec_medical_doctor/pages/newchat/newchatscreen.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../notification_page.dart';

class AddNewPrescriptionPage extends StatefulWidget {
  String patientName;
  String patientgender;
  String patientage;
  AddNewPrescriptionPage(this.patientName,this.patientgender,this.patientage);

  @override
  _AddNewPrescriptionPageState createState() => _AddNewPrescriptionPageState(this.patientName,this.patientgender,this.patientage);
}

class _AddNewPrescriptionPageState extends State<AddNewPrescriptionPage> {


  String patientName;
  String patientgender;
  String patientage;
  _AddNewPrescriptionPageState(this.patientName,this.patientgender,this.patientage);

  var _index = 0;

  // String pdata = Get.arguments;
  //   patientname = pdata[0];
  // String patientgender = pdata[1];
  // String patientage = pdata[2];

  List<GetProfileModel> getProfileModel = [];


  List<String> _gender = ['Male','Female'];
  String _selectgen;

  final _formKey = GlobalKey<FormState>();
  final _patientname = TextEditingController();
  final _patientage = TextEditingController();
  final _patientgender = TextEditingController();
  final _patientaddress = TextEditingController();
  final _patientOex = TextEditingController();
  final _patientPd = TextEditingController();

   Future future;
   Timer timer;





  @override
  void initState() {
    super.initState();
    ProfileRepo profileRepo = new ProfileRepo();
    future = profileRepo.getproifileApi();
    future.then((value){
      setState(() {
        getProfileModel = value;
      });
    });
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
                      Icons.apps,
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
        child: getProfileModel.isNull?Center(child: Text("Internal Server Error",style: TextStyle(fontSize: 20),)):SingleChildScrollView(
          child: Column(
            children: [
              _details(),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _patientnamefield(),
                      SizedBox(height: 7,),
                      _patientageandgenderfield(),
                      // SizedBox(height: 7,),
                      // _patientlocation(),
                      SizedBox(height: 7,),
                      _Oexfield(),
                      SizedBox(height: 7,),
                      _pdfield(),
                      SizedBox(height: 20,),
                      _nextbutton(),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _details() {
    return Container(
      width: Get.width,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 3))
                            ]),
                      ),
                      Positioned(
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: 10,
                        child: getProfileModel.isEmpty? Image.asset("assets/images/logo.png")
                            : Image.network(getProfileModel[0].data.profile),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 5,
                  ),
                  Text(getProfileModel.isEmpty?"Dr. Name":"Dr. ${getProfileModel[0].data.name}",
                      style: TextStyle(
                          color: AppColors.darktextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getProfileModel.isEmpty?"":getProfileModel[0].data.qualification),
                      Text(getProfileModel.isEmpty?"":getProfileModel[0].data.address+"-"+getProfileModel[0].data.pincode),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                    height: 150,
                    width: 148,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                            AssetImage("assets/images/register.png"),
                            ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _patientnamefield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Patient Name",
          style: StringsStyle.normaltextstyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 50,
            width: Get.width,
            alignment: Alignment.centerLeft,
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
            child:Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(patientName,
                style: TextStyle(color: Colors.black,fontSize: 15),),
            ),
            // child: TextFormField(
            //   controller: _patientname,
            //   textInputAction: TextInputAction.next,
            //   keyboardType: TextInputType.text,
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   textAlignVertical: TextAlignVertical.bottom,
            //   decoration: InputDecoration(
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(color: Colors.white, width: 1),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(color: Colors.white, width: 1),
            //     ),
            //     errorBorder: OutlineInputBorder(
            //         borderSide:
            //         new BorderSide(color: Colors.transparent, width: 1),
            //         borderRadius: BorderRadius.circular(10)),
            //     focusedErrorBorder: OutlineInputBorder(
            //         borderSide:
            //         new BorderSide(color: Colors.transparent, width: 1),
            //         borderRadius: BorderRadius.circular(10)),
            //     border: OutlineInputBorder(
            //         borderSide:
            //         new BorderSide(color: Colors.yellow, width: 1),
            //         borderRadius: BorderRadius.circular(10)),
            //     hintText: "  Patient Name",
            //   ),
            //   validator: (value) {
            //     if (value.trim().isEmpty) {
            //       return "Please, enter the patient name";
            //     }
            //
            //     return null;
            //   },
            // )
        ),
      ],
    );
  }

  _patientageandgenderfield() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Patient DOB",
              style: StringsStyle.normaltextstyle,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 50,
                width: Get.width / 2.5,
                alignment: Alignment.centerLeft,
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
              child:Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(patientage,
                  style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
                // child: TextFormField(
                //   controller: _patientage,
                //   keyboardType: TextInputType.number,
                //   textInputAction: TextInputAction.done,
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   textAlignVertical: TextAlignVertical.bottom,
                //   decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(color: Colors.white, width: 1),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(color: Colors.white, width: 1),
                //     ),
                //     errorBorder: OutlineInputBorder(
                //         borderSide: new BorderSide(
                //             color: Colors.transparent, width: 1),
                //         borderRadius: BorderRadius.circular(10)),
                //     focusedErrorBorder: OutlineInputBorder(
                //         borderSide: new BorderSide(
                //             color: Colors.transparent, width: 1),
                //         borderRadius: BorderRadius.circular(10)),
                //     border: OutlineInputBorder(
                //         borderSide:
                //         new BorderSide(color: Colors.yellow, width: 1),
                //         borderRadius: BorderRadius.circular(10)),
                //     hintText: "  0 years",
                //     // suffixIcon: PopupMenuButton<String>(
                //     //     onSelected: (value) {
                //     //       // Get.snackbar(
                //     //       //   "Changes saved with success",
                //     //       //   "just now",
                //     //       //   snackPosition: SnackPosition.BOTTOM,
                //     //       //   colorText: AppColors.lighttextColor,
                //     //       //   backgroundColor: AppColors.backgroundColor,
                //     //       //   boxShadows: [
                //     //       //     BoxShadow(
                //     //       //       blurRadius: 1,
                //     //       //       color: Colors.grey.shade200,
                //     //       //       offset: Offset(0, 2),
                //     //       //       spreadRadius: 2,
                //     //       //     ),
                //     //       //   ],
                //     //       //   margin: EdgeInsets.all(15),
                //     //       // );
                //     //     },
                //     //     icon: Icon(
                //     //       Icons.keyboard_arrow_down_outlined,
                //     //       color: AppColors.appbarbackgroundColor,
                //     //     ),
                //     //     itemBuilder: (BuildContext context) {
                //     //       return [
                //     //         PopupMenuItem(
                //     //           child: Text("0-3 month"),
                //     //           value: "",
                //     //         ),
                //     //         PopupMenuItem(
                //     //           child: Text(
                //     //             "3-6 month",
                //     //           ),
                //     //           value: "",
                //     //         ),
                //     //         PopupMenuItem(
                //     //           child: Text(
                //     //             "6-9 month",
                //     //           ),
                //     //           value: "",
                //     //         ),
                //     //         PopupMenuItem(
                //     //           child: Text(
                //     //             "9-12 month",
                //     //           ),
                //     //           value: "",
                //     //         ),
                //     //         PopupMenuItem(
                //     //           child: Text(
                //     //             "1-2 month",
                //     //           ),
                //     //           value: "",
                //     //         ),
                //     //         PopupMenuItem(
                //     //           child: Text(
                //     //             "2-3 month",
                //     //           ),
                //     //           value: "",
                //     //         ),
                //     //       ];
                //     //     }),
                //     hintStyle: TextStyle(
                //       color: AppColors.lighttextColor,
                //       fontSize: 14,
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value.trim().isEmpty) {
                //       return "Please, fill this!";
                //     }
                //     return null;
                //   },
                // ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Patient Gender",
              style: StringsStyle.normaltextstyle,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: Get.width / 2.5,
              alignment: Alignment.centerLeft,
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
              child:Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(patientgender,
                  style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              // child: Center(
              //   child: DropdownButton(
              //     underline: SizedBox(),
              //     iconSize: 20.0,
              //     hint: Text('Gender          '), // Not necessary for Option 1
              //     value: _selectgen,
              //     onChanged: (newValue) {
              //       setState(() {
              //         _selectgen = newValue;
              //       });
              //     },
              //     items: _gender.map((gender) {
              //       return DropdownMenuItem(
              //
              //         child: new Text(gender),
              //
              //         value: gender,
              //       );
              //     }).toList(),
              //   ),
              // ),

            ),
          ],
        ),
      ],
    );
  }

  _patientlocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Patient Address",
          style: StringsStyle.normaltextstyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 50,
            width: Get.width,
            alignment: Alignment.centerLeft,
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
          child:Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(getProfileModel[0].data.address,
              style: TextStyle(color: Colors.black,fontSize: 15),),
          ),
            // child: TextFormField(
            //   controller: _patientaddress,
            //   keyboardType: TextInputType.text,
            //   textInputAction: TextInputAction.done,
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   textAlignVertical: TextAlignVertical.bottom,
            //   decoration: InputDecoration(
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(color: Colors.white, width: 1),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(color: Colors.white, width: 1),
            //     ),
            //     errorBorder: OutlineInputBorder(
            //         borderSide:
            //         new BorderSide(color: Colors.transparent, width: 1),
            //         borderRadius: BorderRadius.circular(10)),
            //     focusedErrorBorder: OutlineInputBorder(
            //         borderSide:
            //         new BorderSide(color: Colors.transparent, width: 1),
            //         borderRadius: BorderRadius.circular(10)),
            //     border: OutlineInputBorder(
            //         borderSide:
            //         new BorderSide(color: Colors.yellow, width: 1),
            //         borderRadius: BorderRadius.circular(10)),
            //     hintText: "  Patient Location",
            //   ),
            //   validator: (value) {
            //     if (value.trim().isEmpty) {
            //       return "Please, enter the patient location";
            //     }
            //
            //     return null;
            //   },
            // ),
        ),
      ],
    );
  }

  _Oexfield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Patient O/Ex",
          style: StringsStyle.normaltextstyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 50,
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
              controller: _patientOex,
              keyboardType: TextInputType.text,
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
                hintText: "  Patient O/Ex",
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter the patient O/Ex";
                }

                return null;
              },
            )),
      ],
    );
  }

  _pdfield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Patient PD",
          style: StringsStyle.normaltextstyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 50,
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
              controller: _patientPd,
              keyboardType: TextInputType.text,
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
                hintText: "  Patient PD",
              ),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please, enter the patient PD";
                }

                return null;
              },
            )),
      ],
    );
  }

  _nextbutton() {
    // ignore: deprecated_member_use
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FlatButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await SharedPrefManager.savePrefString(AppConstant.PATIENTOEX, _patientOex.text);
                await SharedPrefManager.savePrefString(AppConstant.PATIENTPD, _patientPd.text);
                Get.off(SubmitPrescriptionPage(),
                  transition: Transition.rightToLeftWithFade,
                );
              }
            },
            child:
            CustomButton(text1: "", text2: "Next", width: 150, height: 50)),
      ),
    );
  }


}
