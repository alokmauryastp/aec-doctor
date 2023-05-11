import 'dart:async';
import 'dart:io';
import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/model/allpatientcomplete_model.dart';
import 'package:aec_medical_doctor/model/cancelledpatient_model.dart';
import 'package:aec_medical_doctor/model/completepatient_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/notification_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCompletePatientPage extends StatefulWidget {
  const AllCompletePatientPage({Key? key}) : super(key: key);

  @override
  _AllCompletePatientPageState createState() => _AllCompletePatientPageState();
}

class _AllCompletePatientPageState extends State<AllCompletePatientPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _index = 0;

  List<AllPatientCompleteData> allPatientCompleteData = [];

  List<CancelledPatientData> cancelledPatientData = [];

  late Future future;
  late Timer timer;

  bool _isLoad = false;

  bool isChecked = true;

  @override
  void initState() {
    super.initState();
    print("hii this is the page");
    HomeRepo homeRepo = new HomeRepo();
    future = homeRepo.completePatientApi();
    future.then((value) {
      setState(() {
        allPatientCompleteData = value;
      });
    });
    future = homeRepo.filterPatientCancelledApi();
    future.then((value) {
      setState(() {
        cancelledPatientData = value;
        print("kktitlhjkje" + cancelledPatientData[0].patientName);
        print("kktitleghj" + cancelledPatientData[0].consultId);
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
                    onTap: () {
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
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                        width: Get.width,
                        child: Text("Completed Patients",
                            style: TextStyle(
                                color: AppColors.appbarbackgroundColor,
                                fontSize: 20,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _listview(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _listview() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Column(
        children: [
          if (allPatientCompleteData.isNull)
            Center(
              child: Container(
                height: 250,
                alignment: Alignment.center,
                child: EmptyWidget(
                  image: null,
                  packageImage: PackageImage.Image_2,
                  title: 'No Patients',
                  subTitle: 'Sorry! No Complete Patients\nfound.',
                  titleTextStyle: TextStyle(
                    fontSize: 22,
                    color: Color(0xff9da9c7),
                    fontWeight: FontWeight.w500,
                  ),
                  subtitleTextStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffabb8d6),
                  ),
                ),
              ),
            )
          else if (allPatientCompleteData.isEmpty)
            Center(child: CircularProgressIndicator())
          else
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allPatientCompleteData.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.redAccent,
                                            backgroundImage: NetworkImage(
                                                (allPatientCompleteData[index]
                                                            .userProfile)
                                                        .isEmpty
                                                    ? ""
                                                    : allPatientCompleteData[
                                                            index]
                                                        .userProfile
                                                        .replaceAll('uploads',
                                                            '/apollo/uploads')),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${allPatientCompleteData[index].patientName}",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .darktextColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Container(
                                                width: 150,
                                                child: Text(
                                                    "Disease- ${allPatientCompleteData[index].disease}",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .darktextColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(
                                                    "Date- ${allPatientCompleteData[index].date}",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .darktextColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
        ],
      ),
    );
  }
}
