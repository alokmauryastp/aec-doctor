import 'dart:async';
import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/pages/authentication/update_profile_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/Calculator.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/allcompletepatients_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/earning_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/history_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/payment_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/profile/profile_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/settings/faq_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/settings/templatess/templates_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/prescriptions/prescriptions_page.dart';
import 'package:aec_medical_doctor/pages/intro/intro_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';



class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {


  late Timer timer;
  late Future future;
  var current_index = 3;

  late List<GetProfileModel> getProfileModel = [];
  late String counsellingStatus="";

  void _allDetail()async {
    String counsellingstatus = await SharedPrefManager.getPrefrenceString(
        AppConstant.COUNSELINGSTATUS.toString());
    setState(() {
      counsellingStatus = counsellingstatus;
    });
  }


  @override
  void initState() {
    super.initState();
    _allDetail();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
        this.setState(() {
          ProfileRepo profileRepo = new ProfileRepo();
          future = profileRepo.getproifileApi();
          future.then((value){
            setState(() {
              getProfileModel = value;
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: [
                InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () async {
                      await Get.to(
                          // Calculator(),
                        PrescriptionsPage(),
                      );
                      Get.back();
                    },
                    child: ListTile(
                      title: Text("Prescription"),
                      horizontalTitleGap: 0,
                      leading: SizedBox(
                          height: 20,
                          width: 20,
                          child: Icon(Icons.receipt_long,size: 20,)),
                    )),
                if(counsellingStatus=="1")
                  // InkWell(
                  //   splashColor: AppColors.appbarbackgroundColor,
                  //   onTap: () async{
                  //    await Get.to(CounselingPage(),
                  //        );
                  //    Get.back();
                  //   },
                  //   child: ListTile(
                  //     title: Text("Counselling"),
                  //     horizontalTitleGap: 0,
                  //     leading: SizedBox(
                  //         height: 20,
                  //         width: 20,
                  //         child: Image.asset("assets/images/counselor.png",
                  //           color: AppColors.appbarbackgroundColor,)),
                  //   ))
                  SizedBox()
                else SizedBox(),
                // InkWell(
                //     splashColor: AppColors.appbarbackgroundColor,
                //     onTap: () async{
                //       await Get.to(AllBookCounsellingPage(),
                //       );
                //       Get.back();
                //     },
                //     child: ListTile(
                //       title: Text("Assign Counselling"),
                //       horizontalTitleGap: 0,
                //       leading: SizedBox(
                //           height: 20,
                //           width: 20,
                //           child: Image.asset("assets/images/bookcounseling.png",)),
                //     )),
                InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () async{
                      await Get.to(TemplatesPage(),
                      );
                      Get.back();
                    },
                    child: ListTile(
                      title: Text("Templates"),
                      horizontalTitleGap: 0,
                      leading: SizedBox(
                          height: 20,
                          width: 20,
                          child: Icon(Icons.dashboard,size: 20,)
                          // Image.asset("assets/images/template.png",
                            // color: AppColors.appbarbackgroundColor,

                          // )
                      ),
                    )),
                InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () async {
                      await Get.to(AllCompletePatientPage(),
                      );
                      Get.back();
                    },
                    child: ListTile(
                      title: Text("Complete Patients"),
                      horizontalTitleGap: 0,
                      leading: Icon(Icons.groups,size: 20,),
                    )),
                InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () async{
                      await Get.to(EarningPage(),
                      );
                      Get.back();
                    },
                    child: ListTile(
                      title: Text("Earning"),
                      horizontalTitleGap: 0,
                      leading: Icon(Icons.account_balance_wallet,size: 20,)),
                    ),
                InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () async {
                      await Get.to(PaymentPage(),
                      );
                      Get.back();
                    },
                    child: ListTile(
                      title: Text("Payment"),
                      horizontalTitleGap: 0,
                      leading: Icon(Icons.monetization_on_outlined,size: 20,),
                    )),
                InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () async{
                      await Get.to(HistoryPage(),
                      );
                      Get.back();
                    },
                    child: ListTile(
                      title: Text("History"),
                      horizontalTitleGap: 0,
                      leading: Icon(
                        Icons.history,size: 20,
                        // color: AppColors.appbarbackgroundColor,
                      ),
                    )),
                ListTile(
                  onTap: () async{
                    await Get.to(ProfilePage(),
                    );
                    Get.back();
                  },
                  title: Text("My Account"),
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.account_circle_outlined,size: 20,
                    // color: AppColors.appbarbackgroundColor,
                  ),
                ),
                // InkWell(
                //     splashColor: AppColors.appbarbackgroundColor,
                //     onTap: () async{
                //       await Get.to(CalendarPage(),
                //       );
                //       Get.back();
                //     },
                //     child: ListTile(
                //       title: Text("Calendar"),
                //       horizontalTitleGap: 0,
                //       leading: SizedBox(
                //           height: 20,
                //           width: 20,
                //           child: Icon(Icons.calendar_today,
                //             color: AppColors.appbarbackgroundColor,),),
                //     )),
                InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () async{
                      await Get.to(FaqPage(),
                      );
                      Get.back();
                    },
                    child: ListTile(
                      title: Text("FAQ"),
                      horizontalTitleGap: 0,
                      leading: Icon(
                        Icons.info_outlined,
                        size: 20,
                        // color: AppColors.appbarbackgroundColor,
                      ),
                    )),
                InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                            height: 200,
                            color: AppColors.backgroundColor,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.contact_support_outlined,
                                      size: 20,
                                      color: AppColors.appbarbackgroundColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Contact us",
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                                Text(
                                  "For any Query connect\n with us",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.darktextColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        launch('mailto:rajatrrpalankar@gmail.com?subject=This is Subject Title&body=This is Body of Email');
                                      },
                                      child: Container(
                                        width: 120,
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.mail,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "Mail us",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        launch('tel:+91 88888888888');
                                      },
                                      child: Container(
                                        width: 120,
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
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.call,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "Call us",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        isDismissible: true,
                        enableDrag: true,
                      );
                    },
                    child: ListTile(
                      title: Text("Contact us"),
                      horizontalTitleGap: 0,
                      leading: Icon(
                        Icons.call,
                        size: 20,
                        // color: AppColors.appbarbackgroundColor,
                      ),
                    )),
                ListTile(
                  onTap: (){
                    Share.share("We are committed to improve world's health with affordable care \n\n Apollo-E-Clinic(Doctor) - Apps on Google Play \n\n https://play.google.com/store/apps/details?id=com.aaragroups.doctorsapp");
                  },
                  title: Text("Share"),
                  horizontalTitleGap: 0,
                  leading: Icon(
                    Icons.share,
                    size: 20,
                    // color: AppColors.appbarbackgroundColor,
                  ),
                ),
                InkWell(
                  splashColor: AppColors.appbarbackgroundColor,
                  onTap: () {
                    Get.defaultDialog(
                      radius: 5,
                      backgroundColor: Colors.white,
                      title: 'Are you sure you want to logout?',
                      titleStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      content: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () async{
                                setState(() async{
                                  await SharedPrefManager.clearPrefs();
                                });
                                Get.back();
                                Get.snackbar("Logout",
                                    "Successfully");
                              },
                              child: Center(
                                child: Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.black26,
                                          Colors.black87,
                                          // Colors.red.shade500,
                                          // AppColors.redColor,
                                        ]),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            20)),
                                    child: Center(
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ))),
                              )),
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Center(
                                child: Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.black26,
                                          Colors.black87,
                                          // Colors.red.shade500,
                                          // AppColors.redColor,
                                        ]),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            20)),
                                    child: Center(
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ))),
                              )),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(Strings.LOGOUT),
                    horizontalTitleGap: 0,
                    leading: Icon(
                      Icons.logout,size: 20,
                      // color: AppColors.appbarbackgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
