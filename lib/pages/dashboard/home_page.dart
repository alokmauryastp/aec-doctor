// import 'package:aec_medical_doctor/api/AppConstant.dart';
// import 'package:aec_medical_doctor/api/repository/home_repo.dart';
// import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
// import 'package:aec_medical_doctor/api/sharedprefrence.dart';
// import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
// import 'package:aec_medical_doctor/pages/dashboard/apps/patients/all_patients_list_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/apps/calendar_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/apps/help_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/apps/history_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/apps/profile/profile_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/apps/settings/counseling_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/apps/settings/settings_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/apps/upcoming_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/notification_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/prescriptions/addNew_prescription_page.dart';
// import 'package:aec_medical_doctor/pages/dashboard/prescriptions/prescriptionsdetail_page.dart';
// import 'package:aec_medical_doctor/utils/colors.dart';
// import 'package:aec_medical_doctor/utils/strings_style.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:share/share.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'apps/earning_page.dart';
// import 'apps/patients/chatwithpatients_page.dart';
// import 'apps/patients/doctorchat_folder/normalchat_card.dart';
// import 'apps/settings/templatess/templates_page.dart';
// import 'prescriptions/prescriptions_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   getToken() async{
//     String? token = await FirebaseMessaging.instance.getToken();
//     print("tokensssssssss "+token.toString());
//    await SharedPrefManager.savePrefString(AppConstant.FCMTOKEN, token.toString());
//     HomeRepo homeRepo = new HomeRepo();
//     homeRepo.updateTokenApi();
//   }
//
//   late String counsellingStatus;
//
//   void _allDetail()async {
//     String counsellingstatus = await SharedPrefManager.getPrefrenceString(
//         AppConstant.COUNSELINGSTATUS.toString());
//     setState(() {
//       counsellingStatus = counsellingstatus;
//     });
//   }
//
//     // String counsellingStatus = Get.arguments;
//   late List<GetProfileModel> getProfileModel = [];
//
//
//   @override
//   void initState() {
//     _allDetail();
//     getToken();
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//     HomeRepo homeRepo = new HomeRepo();
//     homeRepo.checkDoctorAccountApi();
//     ProfileRepo profileRepo = new ProfileRepo();
//     Future future = profileRepo.getproifileApi();
//     future.then((value){
//       setState(() {
//         getProfileModel = value;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }
//
//   var CategoryName = [
//     "For Relationship",
//     "Kids related issues",
//     "Pregnency",
//     "Psychological",
//     "Motivational",
//     "Loneliness",
//     "Suicidal Thoughts",
//     "Feeligs of anger",
//   ];
//
//   bool isSwitched1 = false;
//   void toggleSwitch1(bool value) {
//     if (isSwitched1 == false) {
//       setState(() {
//         isSwitched1 = true;
//       });
//       print('Switch Button is ON');
//     } else {
//       setState(() {
//         isSwitched1 = false;
//       });
//       print('Switch Button is OFF');
//     }
//   }
//
//
//
//   _sendingMails() async {
//     const url = 'mailto:feedback@geeksforgeeks.org';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: Column(
//         children: [
//           Container(
//             height: 40,
//             color: AppColors.appbarbackgroundColor,
//           ),
//           // ignore: unrelated_type_equality_checks
//           _tabController == 'Prescriptions'
//               ? Container(
//                   color: AppColors.appbarbackgroundColor,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Image.asset(
//                           "assets/images/logo.png",
//                           height: 30,
//                           width: 30,
//                         ),
//                         Text(
//                           "AEC",
//                           style: TextStyle(
//                               letterSpacing: 0.8,
//                               color: Colors.white,
//                               fontSize: 25,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Get.to(NotificationPage(),
//                                 transition: Transition.rightToLeftWithFade,
//                         );
//                           },
//                           child: Icon(
//                             Icons.notifications,
//                             size: 30,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : Container(
//                   color: AppColors.appbarbackgroundColor,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Image.asset(
//                           "assets/images/logo.png",
//                           height: 30,
//                           width: 30,
//                         ),
//                         Text(
//                           "AEC",
//                           style: TextStyle(
//                               letterSpacing: 0.8,
//                               color: Colors.white,
//                               fontSize: 25,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Get.to(NotificationPage(),
//                                 transition: Transition.rightToLeftWithFade,
//                          );
//                           },
//                           child: Icon(
//                             Icons.notifications,
//                             size: 30,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//           Container(
//             color: AppColors.appbarbackgroundColor,
//             child: TabBar(
//               indicatorWeight: 3,
//               indicatorColor: Colors.white,
//               controller: _tabController,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white,
//               tabs: [
//                 Tab(
//                   text: 'Apps',
//                 ),
//                 Tab(
//                   text: 'Prescriptions',
//                 ),
//               ],
//             ),
//           ),
//           // tab bar view here
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 // first tab bar view widget
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Column(
//                       children: [
//                         _notification(),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     _upcoming(),
//                                     _profile(),
//                                     _calendar(),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     _history(),
//                                     _patients(),
//                                     _prescript(),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 40,
//                             ),
//                             Container(
//                               height: 2,
//                               color: AppColors.appbarbackgroundColor,
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     _settings(),
//                                     _earning(),
//                                     _help(),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     _contactus(),
//                                     if(counsellingStatus=="1")
//                                       _counseling()
//                                     else Text(""),
//                                     _shareApp(),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // second tab bar view widget
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       children: [
//                         SingleChildScrollView(
//                           child: ListView.builder(
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: 3,
//                               itemBuilder: (BuildContext context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Get.to(PrescriptionDetailPage());
//                                     },
//                                     child: Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(8.0),
//                                       ),
//                                       color: Colors.white,
//                                       elevation: 5,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(10.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text("NAFLD",
//                                                     style: TextStyle(
//                                                         color: AppColors
//                                                             .darktextColor,
//                                                         fontWeight:
//                                                             FontWeight.bold)),
//                                                 Icon(Icons.more_vert_rounded),
//                                               ],
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 5),
//                                               child: Text("Description",
//                                                   style: TextStyle(
//                                                       color: Colors.grey,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text("Fatty Lever",
//                                                     style: TextStyle(
//                                                         color: Colors.black87,
//                                                         fontWeight:
//                                                             FontWeight.bold)),
//                                                 Text("No additional commments",
//                                                     style: TextStyle(
//                                                         color: Colors.grey,
//                                                         fontWeight:
//                                                             FontWeight.w400)),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 8,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               children: [
//                                                 Container(
//                                                   alignment:
//                                                       Alignment.centerRight,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             0.0),
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                         border: Border.all(
//                                                           color: AppColors
//                                                               .appbarbackgroundColor,
//                                                           width: 1.0,
//                                                         ),
//                                                       ),
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .only(
//                                                                 left: 10.0,
//                                                                 right: 10.0,
//                                                                 top: 5,
//                                                                 bottom: 5),
//                                                         child: Text(
//                                                           "Select",
//                                                           style: StringsStyle
//                                                               .normaltextstyle,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             color: Colors.white,
//                             elevation: 5,
//                             child: InkWell(
//                               onTap: () async{
//                                 Get.to(AddNewPrescriptionPage(),arguments: getProfileModel[0].data,
//                                   transition: Transition.rightToLeftWithFade,
//                                 );
//                               },
//                               child: Container(
//                                   height: 60,
//                                   child: Center(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           Icons.note_add_sharp,
//                                           size: 20,
//                                           color:
//                                               AppColors.appbarbackgroundColor,
//                                         ),
//                                         Center(
//                                           child: Text(" Add New Prescription",
//                                               style: TextStyle(
//                                                 color: AppColors
//                                                     .appbarbackgroundColor,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15,
//                                               )),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _notification() {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Enable Consultation",
//               style: StringsStyle.heading,
//             ),
//             Transform.scale(
//                 scale: 1.1,
//                 child: Switch(
//                   onChanged: toggleSwitch1,
//                   value: isSwitched1,
//                   activeColor: AppColors.appbarbackgroundColor,
//                   activeTrackColor: Colors.greenAccent,
//                   inactiveThumbColor: AppColors.redColor,
//                   inactiveTrackColor: Colors.black54,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _upcoming() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () async{
//            // String doctorname = await SharedPrefManager.getPrefrenceString(AppConstant.NAME);
//             Get.to(UpcomingPage(),arguments: getProfileModel[0].data,
//                 transition: Transition.rightToLeftWithFade,
//               );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Container(
//               height: 70,
//               width: 70,
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Icon(
//                       Icons.announcement,
//                       size: 50,
//                       color: AppColors.redColor,
//                     ),
//                     SizedBox(height: 5),
//                     Text("Upcoming",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 12))
//                   ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _profile() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(ProfilePage(),
//                 transition: Transition.rightToLeftWithFade,
//               );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.person_rounded,
//                     size: 50,
//                     color: AppColors.redColor,
//                   ),
//                   SizedBox(height: 5),
//                   Text("Profile",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _calendar() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(CalendarPage(),
//                 transition: Transition.rightToLeftWithFade,
//                );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(Icons.calendar_today,
//                       size: 50, color: AppColors.redColor),
//                   //Image.asset("assets/images/calendar.png",width: 50,height: 50,),
//                   SizedBox(height: 5),
//                   Text("Calendar",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _history() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(HistoryPage(),
//                 transition: Transition.rightToLeftWithFade,
//                 );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.history,
//                     size: 50,
//                     color: AppColors.redColor,
//                   ),
//                   SizedBox(height: 5),
//                   Text("History",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _patients() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(AllPatientsListPage(),
//                 transition: Transition.rightToLeftWithFade,
//                );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.people_alt_rounded,
//                     size: 50,
//                     color: AppColors.redColor,
//                   ),
//                   SizedBox(height: 5),
//                   Text("Patients",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _prescript() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(PrescriptionsPage(),
//                 transition: Transition.rightToLeftWithFade,
//          );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Image.asset(
//                     "assets/images/prescription.png",
//                     width: 50,
//                     height: 50,
//                     color: AppColors.redColor,
//                   ),
//                   SizedBox(height: 5),
//                   Text("Prescription",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 11))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _counseling() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(CounselingPage(),
//               transition: Transition.rightToLeftWithFade,
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Image.asset(
//                     "assets/images/counselor.png",
//                     width: 50,
//                     height: 50,
//                     color: AppColors.redColor,
//                   ),
//                   SizedBox(height: 5),
//                   Text("Counseling",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _settings() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(SettingsPage(),
//                 transition: Transition.rightToLeftWithFade,
//              );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.settings,
//                     size: 50,
//                     color: AppColors.redColor,
//                   ),
//                   // Image.asset("assets/images/prescription.png",width: 50,height: 50,color: AppColors.redColor,),
//                   SizedBox(height: 5),
//                   Text("Settings",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _earning() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(EarningPage(),
//                 transition: Transition.rightToLeftWithFade,
//            );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Image.asset(
//                     "assets/images/earning.png",
//                     width: 50,
//                     height: 50,
//                     color: AppColors.redColor,
//                   ),
//                   SizedBox(height: 5),
//                   Text("Earning",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   _shareApp() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//              onTap: (){
//              Share.share("hello");
//              },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.share,
//                     size: 50,
//                     color: AppColors.redColor,
//                   ),
//                   //Image.asset("assets/images/earning.png",width: 50,height: 50,color: AppColors.redColor,),
//                   SizedBox(height: 5),
//                   Text("Share app",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _contactus() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.bottomSheet(
//               Container(
//                   height: 200,
//                   color: AppColors.backgroundColor,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             "assets/images/Component.svg",
//                             width: 30,
//                             height: 30,
//                             color: AppColors.redColor,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text("Contact us",
//                               style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                       Text(
//                         "For any Query connect\n with us",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: AppColors.darktextColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           InkWell(
//                             onTap: (){
//                               launch('mailto:rajatrrpalankar@gmail.com?subject=This is Subject Title&body=This is Body of Email');
//                             },
//                             child: Container(
//                               width: 120,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.4),
//                                     spreadRadius: 1,
//                                     blurRadius: 3,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                                 gradient: LinearGradient(colors: [
//                                   AppColors.appbarbackgroundColor,
//                                   AppColors.appbarbackgroundColor,
//                                 ]),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.mail,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   InkWell(
//                                     onTap: () {},
//                                     child: Text(
//                                       "Mail us",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: (){
//                               launch('tel:+91 88888888888');
//                             },
//                             child: Container(
//                               width: 120,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.4),
//                                     spreadRadius: 1,
//                                     blurRadius: 3,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                                 gradient: LinearGradient(colors: [
//                                   AppColors.appbarbackgroundColor,
//                                   AppColors.appbarbackgroundColor,
//                                 ]),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.call,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   InkWell(
//                                     onTap: () {},
//                                     child: Text(
//                                       "Call us",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )),
//               isDismissible: true,
//               enableDrag: true,
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SvgPicture.asset(
//                     "assets/images/Component.svg",
//                     width: 50,
//                     height: 50,
//                     color: AppColors.redColor,
//                   ),
//                   SizedBox(height: 5),
//                   Text("Contact us",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _help() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 5,
//       child: Container(
//         width: 80,
//         height: 80,
//         child: InkWell(
//           splashColor: AppColors.appbarbackgroundColor,
//           onTap: () {
//             Get.to(TemplatesPage(),
//                 transition: Transition.rightToLeftWithFade,
//                );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Icon(
//                   //   Icons.help,
//                   //   size: 50,
//                   //   color: AppColors.redColor,
//                   // ),
//                   Image.asset("assets/images/template.png",width: 50,height: 50,color: AppColors.redColor,),
//                   SizedBox(height: 5),
//                   Text("Templates",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12))
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
