import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/prescription_repo.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/model/prescriptionModel/allprescription_model.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/prescriptions/prescriptionsdetail_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../notification_page.dart';
import 'addNew_prescription_page.dart';

class PrescriptionsPage extends StatefulWidget {
  const PrescriptionsPage({Key? key}) : super(key: key);

  @override
  _PrescriptionsPageState createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  late List<GetProfileModel> getProfileModel = [];

  late List<AllPrescriptionData> allPrescriptionData = [];

  late Future future;

  @override
  void initState() {
    ProfileRepo profileRepo = new ProfileRepo();
    future = profileRepo.getproifileApi();
    future.then((value) {
      setState(() {
        getProfileModel = value;
      });
    });
    PrescriptionRepo prescriptionRepo = new PrescriptionRepo();
    future = prescriptionRepo.showPrescriptionApi();
    future.then((value) {
      setState(() {
        allPrescriptionData = value;
      });
    });
  }

  TextStyle profileStyle = TextStyle(
      color: Color(0xff366997),
      fontWeight: FontWeight.bold,
      fontSize: 15,
      fontFamily: GoogleFonts.lato().fontFamily,
      letterSpacing: 0.5);

  TextStyle textStyle = TextStyle(
    color: AppColors.lighttextColor,
    fontSize: 14,
    letterSpacing: 0.5,
    fontFamily: GoogleFonts.lato().fontFamily,
    fontWeight: FontWeight.w500,
  );

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
                      Get.to(
                        NotificationPage(),
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
        child: allPrescriptionData.isNull
            ? Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/noprescription.jpg",
                      width: Get.width,
                    ),
                    Text(
                      "Sorry! Prescription not available .",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.appbarbackgroundColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("All Prescription",
                            style: TextStyle(
                                fontSize: 22,
                                color: AppColors.appbarbackgroundColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allPrescriptionData.length,
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  index == 0
                                      ? Text(allPrescriptionData[index].date)
                                      : allPrescriptionData[index].date ==
                                              allPrescriptionData[index - 1]
                                                  .date
                                          ? SizedBox()
                                          : Text(
                                              allPrescriptionData[index].date),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      onTap: () async {
                                        await SharedPrefManager.savePrefString(
                                            AppConstant.PRESCRIPTIONID,
                                            allPrescriptionData[index]
                                                .prescriptionId);
                                        Get.to(PrescriptionDetailPage(),
                                            transition:
                                                Transition.rightToLeftWithFade,
                                            duration:
                                                Duration(milliseconds: 600));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        color: Colors.white,
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Patient Name : ",
                                                      style: textStyle),
                                                  Text(
                                                      allPrescriptionData[index]
                                                          .patientName,
                                                      style: profileStyle),
                                                  // Icon(Icons.more_vert_rounded),
                                                ],
                                              ),
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Patient Age : ",
                                                      style: textStyle),
                                                  Text(
                                                      allPrescriptionData[index]
                                                          .patientAge,
                                                      style: profileStyle),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Address : ",
                                                        style: textStyle),
                                                    Expanded(
                                                      child: Text(
                                                          allPrescriptionData[
                                                                  index]
                                                              .address,
                                                          style: profileStyle),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Note : ",
                                                      style: textStyle),
                                                  Text(
                                                      allPrescriptionData[index]
                                                          .comment,
                                                      style: profileStyle),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 5),
                      //   child: Card(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //     color: Colors.white,
                      //     elevation: 5,
                      //     child: InkWell(
                      //       onTap: () {
                      //         Get.to(AddNewPrescriptionPage(),arguments: getProfileModel[0].data,
                      //             transition: Transition.rightToLeftWithFade,
                      //             duration: Duration(milliseconds: 600));
                      //       },
                      //       child: Container(
                      //           height: 60,
                      //           child: Center(
                      //             child: Row(
                      //               mainAxisAlignment:
                      //               MainAxisAlignment.center,
                      //               children: [
                      //                 Icon(
                      //                   Icons.note_add_sharp,
                      //                   size: 20,
                      //                   color:
                      //                   AppColors.appbarbackgroundColor,
                      //                 ),
                      //                 Center(
                      //                   child: Text(" Add New Prescription",
                      //                       style: TextStyle(
                      //                         color: AppColors
                      //                             .appbarbackgroundColor,
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 15,
                      //                       )),
                      //                 ),
                      //               ],
                      //             ),
                      //           )),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
