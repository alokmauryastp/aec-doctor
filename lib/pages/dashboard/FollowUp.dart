import 'dart:convert';

import 'package:aec_medical_doctor/api/AppUrlConstant.dart';
import 'package:aec_medical_doctor/api/base/api_response.dart';
import 'package:aec_medical_doctor/api/exception/api_error_handler.dart';
import 'package:aec_medical_doctor/api/repository/counseling_repo.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' as gets;


import 'notification_page.dart';


class FollowUp extends StatefulWidget {
  const FollowUp({Key? key, }) : super(key: key);

  @override
  _FollowUpState createState() => _FollowUpState();
}

class _FollowUpState extends State<FollowUp> {

  late Future future;
  List<GetProfileModel> getProfileModel = [];
  final _reason = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String date="Select Date",time='Select Time';


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
                      );
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
              Text(
                " Add Follow Up",
                style: StringsStyle.heading,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 7,),
                      SizedBox(height: 7,),
                      SizedBox(height: 7,),
                      _reasonfield(),
                      SizedBox(height: 7,),
                      _datefield(),
                      SizedBox(height: 7,),
                      _timefield(),
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
                      Text(getProfileModel.isEmpty?"":getProfileModel[0].data.district+" "+getProfileModel[0].data.state+"-"+getProfileModel[0].data.pincode,
                      )
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



  _reasonfield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Reason",
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
              controller: _reason,
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
                hintText: "Enter Reason",
              ),
              validator: (value) {
                // if (value.trim().isEmpty) {
                //   return "Please, enter the patient PD";
                // }

                return null;
              },
            )),
      ],
    );
  }

  _datefield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Date",
          style: StringsStyle.normaltextstyle,
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(onTap: (){
          _selectDate(context);
        } ,
          child: Container(
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
              child: Center(child: Text(date))),
        ),
      ],
    );
  }

  _timefield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Time",
          style: StringsStyle.normaltextstyle,
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(onTap: (){
          _selectTime(context);
        },
          child: Container(
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
              child: Center(child: Text(time))),
        ),
      ],
    );
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null )
    {
      setState(() {
        selectedTime = timeOfDay;
        time = formatTimeOfDay(timeOfDay);
        // time = time.replaceAll('PM', '').replaceAll('AM', '').trim();
        print("timeghnghnmghngcvbdf "+time);
        print("timeghnghnmghngcvbdf "+time);

      });
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jms();  //"6:00 AM"
    // final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }


  DateTime currentDate =DateTime.now();


  Future<void> _selectDate (BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        // builder: (BuildContext context,Widget child){
        //   return Theme(data: ThemeData.light(), child: child  );
        // }
    );

    // print("4bbdbfgbdfb $selectedTime");
    if (pickedDate  != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        date = pickedDate.year.toString()+'-'+(pickedDate.month<9?'0'+pickedDate.month.toString() : pickedDate.month.toString())+'-'+(pickedDate.day<9?'0'+pickedDate.day.toString() : pickedDate.day.toString());
        print("datttaat $currentDate");
        print("datttaat $date");
      });
  }

  _nextbutton() {
    // ignore: deprecated_member_use
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.center,
        child: FlatButton(
            onPressed: () async {
              CounselingRepo counselingRepo = new CounselingRepo();
              counselingRepo.addFollowUp( _reason.text, date, time);
            },
            child:
            CustomButton(text1: "", text2: "Add Follow Up", width: 150, height: 50)),
      ),
    );
  }


}
