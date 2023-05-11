import 'dart:async';

import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/model/allpatients_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/patients/chatwithpatients_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/patients/report_issues/report_issues_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/settings/updatewaitingtime_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/notification_page.dart';
import 'package:aec_medical_doctor/pages/newchat/newchatscreen.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPatientsListPage extends StatefulWidget {
  @override
  _AllPatientsListPageState createState() => _AllPatientsListPageState();
}

class _AllPatientsListPageState extends State<AllPatientsListPage> {

  List<AllPatientsData> allPatientsData = [];
  late Timer timer;

  DateTime selectedDate = DateTime.now();
  var formatDate;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),);

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDate = selectedDate.year.toString() + "/"+selectedDate.month.toString() + "/" +selectedDate.day.toString();
      });
    }
  }

  DateTime toselectedDate = DateTime.now();
  var toformatDate;

  _toselectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toselectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),);

    if (picked != null && picked != toselectedDate) {
      setState(() {
        toselectedDate = picked;
        toformatDate = toselectedDate.year.toString() + "/"+toselectedDate.month.toString() + "/" +toselectedDate.day.toString();
      });
    }
  }

  late Future future;

  bool _isLoad = false;

  void _filterearning(){
    setState(() {
      _isLoad = true;
    });
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
        this.setState(() {
          HomeRepo homeRepo = new HomeRepo();
          Future future = homeRepo.allPatientApi(formatDate, toformatDate);
          future.then((value) {
            setState(() {
              allPatientsData = value;
              print("kktitle" + allPatientsData[0].patientName);
            });
          });
        });
      });
    });
    setState(() {
      _isLoad = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filterearning();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
    //     this.setState(() {
    //       HomeRepo homeRepo = new HomeRepo();
    //       Future future = homeRepo.allPatientApi("","");
    //       future.then((value) {
    //         setState(() {
    //           allPatientsData = value;
    //           print("kktitle" + allPatientsData[0].patientName);
    //         });
    //       });
    //   });
    //   });
    // });
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
            icon: Icon(Icons.apps, size: 30)),
        centerTitle: true,
        title: Text(
          "ACE",
          style: StringsStyle.appbarstyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: (){
                Get.to(NotificationPage(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 600));
              },
              child: Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _heading(),
                SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 20),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       "All Patients list",
                //       style: StringsStyle.title,
                //     ),
                //   ),
                // ),

                if(allPatientsData.isNull)
                  Center(child: Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: Text("Sorry! No Upcoming Patients found.")))
                else  if(allPatientsData.isEmpty)
                  Center(child: CircularProgressIndicator())
                else Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: allPatientsData.length,
                      itemBuilder: (BuildContext context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: ()async{
                                  // await SharedPrefManager.savePrefString(AppConstant.CONSULTID, upcomingPatientData[index].consultId);
                                  // Get.to(ChatScreenNew(),arguments: upcomingPatientData[index],
                                  //   transition: Transition.rightToLeftWithFade,
                                  // );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Colors.redAccent,
                                              backgroundImage: NetworkImage((allPatientsData[index].userProfile).isEmpty?"":allPatientsData[index].userProfile),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${allPatientsData[index].patientName}",
                                                    style: TextStyle(
                                                        color: AppColors.darktextColor,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500)),
                                                Text("Disease- ${allPatientsData[index].disease}",
                                                    style: TextStyle(
                                                        color: AppColors.darktextColor,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500)),

                                              ],
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        allPatientsData[index].consultStatus==false?SizedBox():Text("Waiting time: ${allPatientsData[index].waitingTime.isEmpty?"0":allPatientsData[index].waitingTime}",
                                            style: TextStyle(
                                                color: AppColors.darktextColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            allPatientsData[index].consultStatus==false?
                                            InkWell(
                                               onTap: ()async{
                                                await SharedPrefManager.savePrefString(AppConstant.CONSULTID, allPatientsData[index].consultId);
                                               Get.to(ChatScreenNew(),arguments: "Chat",
                                               transition: Transition.rightToLeftWithFade,
                                                );
                                                  },
                                            child: Icon(Icons.chat,size: 25,))
                                                :InkWell(
                                                onTap: ()async{
                                                  await SharedPrefManager.savePrefString(AppConstant.CONSULTID, allPatientsData[index].consultId);
                                                  Get.to(ChatScreenNew(),arguments: allPatientsData[index].patientName,
                                                    transition: Transition.rightToLeftWithFade,
                                                  );
                                                },
                                                child: Icon(Icons.chat,size: 25,)),
                                            SizedBox(width: 30,),
                                            InkWell(
                                                onTap: ()async{
                                                  await SharedPrefManager.savePrefString(AppConstant.ASSIGNID, allPatientsData[index].assignId);
                                                  // Get.to(UpdateWaitingTimePage(),
                                                  //   transition: Transition.rightToLeftWithFade,
                                                  // );
                                                },
                                                child: allPatientsData[index].consultStatus==false?SizedBox():Icon(Icons.edit,size: 25,)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              height: 1.5,
                              color: AppColors.lighttextColor,
                            ),
                          ],
                        );
                      }),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(""),
                //       Text("View all",
                //           style: TextStyle(
                //               color: AppColors.lighttextColor,
                //               fontSize: 13,
                //               fontWeight: FontWeight.w500,
                //               decoration: TextDecoration.underline))
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "All Patients list",
            style: StringsStyle.title,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "From",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                _fromdate(),
                SizedBox(
                  width: 5,
                ),
                Text("To"),
                SizedBox(
                  width: 5,
                ),
                _todate(),
              ],
            ),
            InkWell(
                onTap: () {
                  _filterearning();
                },
                child: Center(
                  child: Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.black26,
                            Colors.black87,
                            // Colors.red.shade500,
                            // AppColors.redColor,
                          ]),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ))),
                )),
          ],
        ),

      ],
    );
  }

  _fromdate() {
    return Container(
      height: 35,
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.whitetextColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(3, 3))
        ],
      ),
      child: GestureDetector(
        onTap:()=> _selectDate(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(formatDate ?? "Date",
                style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xffd3d3d3)
                ),),
            ),
            const Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
      ),);
  }

  _todate() {
    return Container(
      height: 35,
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.whitetextColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(3, 3))
        ],
      ),
      child: GestureDetector(
        onTap:()=> _toselectDate(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(toformatDate ?? "Date",
                style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xffd3d3d3)
                ),),
            ),
            const Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
      ),);
  }
}
