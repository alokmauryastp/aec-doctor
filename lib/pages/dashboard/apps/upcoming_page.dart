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
import 'package:aec_medical_doctor/pages/dashboard/drawer_page.dart';
import 'package:aec_medical_doctor/pages/newchat/newchatscreen.dart';
import 'package:aec_medical_doctor/pages/newchat/video_call_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../notification_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _index = 0;

  // GetProfileData doctorname = Get.arguments;

  List<GetProfileModel> getProfileModel = [];

  List<UpcomingPatientData> upcomingPatientData = [];

  List<OldPatientsData> oldPatientsData = [];

  List<MessageCountModel> messageCountModel = [];

  late Future future;
  late Timer timer;
  List<String> _time = ['5', '10', '15', '20', '25', '30'];
  String? _selecttime;
  bool isSwitched2 = false;
  bool isOnline = false;


  bool _isLoad = false;

  void _trySubmit() async {
    setState(() {
      _isLoad = true;
    });
    HomeRepo homeRepo = new HomeRepo();
    homeRepo.updateWaitingTimeApi(_selecttime);
    setState(() {
      _isLoad = false;
    });
  }

  bool isChecked = true;
  int endTime = DateTime.now().millisecondsSinceEpoch;

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    print("hii this is the upcoming page");
    HomeRepo homeRepo = new HomeRepo();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
        this.setState(() {
          future = homeRepo.upcomingPatientApi();
          future.then((value) {
            setState(() {
              upcomingPatientData = value;
              // print("kktitle" + upcomingPatientData[0].patientName);
            });
          });
        });
      });
    });
    future = homeRepo.oldPatientApi();
    future.then((value) {
      setState(() {
        oldPatientsData = value;
        print("kktitle" + oldPatientsData[0].patientName);
      });
    });
    ChatRepo chatRepo = new ChatRepo();
    future = chatRepo.checkMesagesCountApi();
    future.then((value) {
      setState(() {
        messageCountModel = value;
        print("kktitle" + messageCountModel[0].data.num.toString());
      });
    });

    ProfileRepo profileRepo = new ProfileRepo();
    future = profileRepo.getproifileApi();
    future.then((value) {
      setState(() {
        getProfileModel = value;
        isOnline = getProfileModel[0].data.is_online == "1" ? true : false;
      });
    });
  }


  Future<void> toggleSwitch2() async {
    // if (!isSwitched2) {
    //   setState(() {
    await updateOnlineStatus();
    //     isSwitched2 = true;
    //   });
    //   print('Switch Button is ON');
    // } else {
    //   setState(() {
    //     isSwitched2 = false;
    //   });
    //   print('Switch Button is OFF');
    // }
  }

  updateOnlineStatus(){
    setState(() {
      _isLoad = true;
    });

    String status = isSwitched2 == true ? "1":"0";
    HomeRepo homeRepo = new HomeRepo();
    future = homeRepo.updateDoctorStatus(status);
    future.then((value) => (){

      print("value");
      print(value);
      setState(() {
        isSwitched2= value;
      });

    setState(() {
      _isLoad = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  InkWell(
                    splashColor: AppColors.appbarbackgroundColor,
                    onTap: _openDrawer,
                    child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(
                          Icons.dehaze,
                          size: 30,
                          color: Colors.white,
                        )),
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 30,
                    width: 30,
                  ),
                  Row(children: [
                    Switch(
                      // onChanged: toggleSwitch2,
                      onChanged: (bool value) {
                        print("Switch Button");
                        print(value);
                        setState(() {
                          isSwitched2 = value;
                        });
                        toggleSwitch2();
                      },
                      value: isSwitched2,
                      activeColor: Colors.green,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.white,
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
                  ],)

                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.lightblueColor,
                ),
                child: Container(
                  // color: AppColors.lightblueColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        splashColor: AppColors.appbarbackgroundColor,
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.clear)),
                      ),
                      if (getProfileModel.isNull)
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          //backgroundImage: NetworkImage(getProfileModel[0].data.profile),
                        )
                      else if (getProfileModel.isEmpty)
                        Center(child: CircularProgressIndicator())
                      else
                        Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    getProfileModel[0].data.profile),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    getProfileModel[0].data.name,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.appbarbackgroundColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    getProfileModel[0].data.address,
                                    style: TextStyle(
                                      color: AppColors.darktextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 2, child: DrawerPage()),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _details(),
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

  _details() {
    return getProfileModel.isEmpty
        ? Text("")
        : SizedBox(
            width: Get.width,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 10, top: 5, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: getProfileModel[0].data.profile.isNull
                                    ? Image.asset("assets/images/logo.png")
                                    : Image.network(
                                        getProfileModel[0].data.profile),
                                //child: Image.asset("assets/images/logo.png"),
                              )
                            ],
                          ),
                          // SizedBox(width: 50,),
                          Container(
                              height: 130,
                              width: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/images/register.png"),
                              ))),
                          // Text("Welcome Doctor",
                          //     style: TextStyle(
                          //         color: AppColors.darktextColor,
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   "Good afternoon",
                    //   style: StringsStyle.title,
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                            getProfileModel.isEmpty
                                ? "Dr. Name"
                                : "Welcome Dr. ${getProfileModel[0].data.name}",
                            style: TextStyle(
                                color: AppColors.darktextColor,
                                fontSize: 20,
                                fontFamily: GoogleFonts.karla().fontFamily,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 3,),
                        Text((isSwitched2 == true ? "(Online)" : "(Offline)"),
                            style: TextStyle(
                                color: isSwitched2 == true ? Colors.green.shade400 : Colors.red.shade400,
                                fontSize: 16,
                                fontFamily: GoogleFonts.karla().fontFamily,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Check your\nupcoming and Summarized Consultation",
                          style: TextStyle(
                              fontFamily: GoogleFonts.karla().fontFamily),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  activeStyle() {
    return TextStyle(
      color: AppColors.whitetextColor,
      fontSize: 15,
      letterSpacing: 0.2,
      fontWeight: FontWeight.bold,
    );
  }

  inactiveStyle() {
    return TextStyle(color: Theme.of(context).primaryColorDark);
  }

  BoxDecoration myBoxinActive() {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  BoxDecoration myBoxActive() {
    return BoxDecoration(
      color: Theme.of(context).primaryColorDark,
      border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  _listview() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            onTap: () {
              setState(() {
                _index = 0;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.2,
              height: 40,
              alignment: Alignment.center,
              decoration: _index == 0 ? myBoxActive() : myBoxinActive(),
              child: _index == 0
                  ? Text("Upcoming", style: activeStyle())
                  : Text("Upcoming", style: inactiveStyle()),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _index = 1;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.2,
              height: 40,
              alignment: Alignment.center,
              decoration: _index == 1 ? myBoxActive() : myBoxinActive(),
              child: _index == 1
                  ? Text("Past", style: activeStyle())
                  : Text("Past", style: inactiveStyle()),
            ),
          ),
        ]),
        SizedBox(height: 10),
        Divider(color: Colors.grey),
        if (upcomingPatientData.isNull)
          Visibility(
            visible: _index == 0,
            child: Center(
                child: Container(
              height: 250,
              alignment: Alignment.center,
              child: EmptyWidget(
                image: null,
                packageImage: PackageImage.Image_3,
                title: 'No Patients',
                subTitle: 'Sorry! No Upcoming Patients\nfound.',
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
            )),
          )
        else if (upcomingPatientData.isEmpty)
          Center(child: CircularProgressIndicator())
        else
          Visibility(
            visible: _index == 0,
            child: Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: upcomingPatientData.length,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: InkWell(
                              onTap: () async {
                                // await SharedPrefManager.savePrefString(AppConstant.CONSULTID, upcomingPatientData[index].consultId);
                                //  Get.to(Meeting(),
                                //    transition: Transition.rightToLeftWithFade,
                                //  );
                              },
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
                                                (upcomingPatientData[index]
                                                            .userProfile)
                                                        .isEmpty
                                                    ? ""
                                                    : upcomingPatientData[index]
                                                        .userProfile
                                                        .replaceAll('uploads',
                                                            'apollo/uploads')),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${upcomingPatientData[index].patientName}",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .darktextColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Container(
                                                width: 150,
                                                child: Text(
                                                    "Disease- ${upcomingPatientData[index].disease}",
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text("WT : "),
                                          CountdownTimer(
                                            endTime: endTime +
                                                1000 *
                                                    60 *
                                                    int.parse(upcomingPatientData[
                                                                index]
                                                            .waitingTime
                                                            .isEmpty
                                                        ? "0"
                                                        : upcomingPatientData[
                                                                index]
                                                            .waitingTime
                                                            .replaceAll(
                                                                " Minutes",
                                                                "")),
                                            endWidget: Text("Time Over"),
                                            onEnd: onEnd,
                                          ),
                                        ],
                                      ),
                                      // Text("WT: ${upcomingPatientData[index].waitingTime.isEmpty?"0":upcomingPatientData[index].waitingTime}",
                                      //     style: TextStyle(
                                      //         color: AppColors.darktextColor,
                                      //         fontSize: 12,
                                      //         fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () async {
                                                String consultstatus =
                                                    await SharedPrefManager
                                                            .getPrefrenceString(
                                                                AppConstant
                                                                    .COMPLETECONSULTATIONSTS)
                                                        .toString();
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant.VIDEOURL,
                                                        upcomingPatientData[
                                                                index]
                                                            .videoUrl);
                                                print("Hkdflsd: " +
                                                    upcomingPatientData[index]
                                                        .videoUrl);
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant.VIDEOSTATUS,
                                                        upcomingPatientData[
                                                                index]
                                                            .videoStatus);
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant.CONSULTID,
                                                        upcomingPatientData[
                                                                index]
                                                            .consultId);
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant.PATIENTNAME,
                                                        upcomingPatientData[
                                                                index]
                                                            .patientName
                                                            .toString());
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant.PATIENTAGE,
                                                        upcomingPatientData[
                                                                index]
                                                            .patientAge
                                                            .toString());
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant
                                                            .PATIENTADDRESS,
                                                        upcomingPatientData[
                                                                index]
                                                            .address
                                                            .toString());
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant.PATIENTPD,
                                                        upcomingPatientData[
                                                                index]
                                                            .userId
                                                            .toString());
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant
                                                            .PATIENTGENDER,
                                                        upcomingPatientData[
                                                                index]
                                                            .gender
                                                            .toString());
                                                print(await SharedPrefManager
                                                        .getPrefrenceString(
                                                            AppConstant
                                                                .CONSULTID) +
                                                    "gefhsjak");
                                                if (upcomingPatientData[index]
                                                        .counselingAttentStatus ==
                                                    1) {
                                                  Get.to(
                                                    ChatScreenNew(),
                                                    arguments:
                                                        upcomingPatientData[
                                                                index]
                                                            .patientName,
                                                    transition: Transition
                                                        .rightToLeftWithFade,
                                                  );
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "Please Complete your First Consultation",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      backgroundColor:
                                                          Colors.black,
                                                      textColor: Colors.white);
                                                }
                                              },
                                              child: Icon(
                                                Icons.chat,
                                                size: 25,
                                              )),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          InkWell(
                                              onTap: () async {
                                                await SharedPrefManager
                                                    .savePrefString(
                                                        AppConstant.ASSIGNID,
                                                        upcomingPatientData[
                                                                index]
                                                            .assignId);
                                                _showDecline();
                                                // Get.to(UpdateWaitingTimePage(),
                                                //   transition: Transition.rightToLeftWithFade,
                                                // );
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                size: 25,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 1.5,
                        //   color: AppColors.lighttextColor,
                        // ),
                      ],
                    );
                  }),
            ),
          ),
        if (oldPatientsData.isNull)
          Visibility(
            visible: _index == 1,
            child: Center(
              child: Container(
                height: 250,
                alignment: Alignment.center,
                child: EmptyWidget(
                  image: null,
                  packageImage: PackageImage.Image_3,
                  title: 'No Patients',
                  subTitle: 'Sorry! No Old Patients\nfound.',
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
            ),
          )
        else if (oldPatientsData.isEmpty)
          Text("")
        else
          Visibility(
            visible: _index == 1,
            child: Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: oldPatientsData.length,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: InkWell(
                              onTap: () async {
                                await SharedPrefManager.savePrefString(
                                    AppConstant.CONSULTID,
                                    oldPatientsData[index].consultId);
                                Get.to(
                                  ChatScreenNew(),
                                  arguments: "Chat",
                                  transition: Transition.rightToLeftWithFade,
                                );
                              },
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
                                                (oldPatientsData[index]
                                                            .userProfile)
                                                        .isEmpty
                                                    ? ""
                                                    : oldPatientsData[index]
                                                        .userProfile),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${oldPatientsData[index].patientName}",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .darktextColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(
                                                  "Disease- ${oldPatientsData[index].disease}",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .darktextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //    crossAxisAlignment: CrossAxisAlignment.end,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         InkWell(
                                  //             // onTap: ()async{
                                  //             //   await SharedPrefManager.savePrefString(AppConstant.CONSULTID, oldPatientsData[index].consultId);
                                  //             //   Get.to(ChatScreenNew(),
                                  //             //     transition: Transition.rightToLeftWithFade,
                                  //             //   );
                                  //             // },
                                  //          //   child: Icon(Icons.chat,size: 25,),
                                  //          ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 1.5,
                        //   color: AppColors.lighttextColor,
                        // ),
                      ],
                    );
                  }),
            ),
          ),
      ])),
    );
  }

  void onEnd() {
    print('onEnd');
  }

  void _showDecline() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: AlertDialog(
                title: Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            color: Colors.white,
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.clear,
                              color: Colors.black,
                              size: 20,
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Update Waiting Time",
                          style: TextStyle(
                              color: AppColors.appbarbackgroundColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                content: Container(
                  width: Get.width,
                  height: 260,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " Waiting Time",
                              style: StringsStyle.normaltextstyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.whitetextColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.appbarbackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(3, 3))
                                ],
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Center(
                                child: new DropdownButton<String>(
                                  underline: SizedBox(),
                                  iconSize: 20.0,
                                  hint: Text(
                                    '${_selecttime.isNull ? "Time" : _selecttime}                                             ',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  // Not necessary for Option 1
                                  value: _selecttime,
                                  onChanged: (newValue) {
                                    print("newValue");
                                    print(newValue);
                                    setState(() {
                                      _selecttime = newValue;
                                    });
                                  },
                                  items: _time.map((type) {
                                    return DropdownMenuItem(
                                      child: new Text(type),
                                      value: type,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Bounce(
                          duration: Duration(milliseconds: 110),
                          onPressed: _trySubmit,
                          child: CustomButton(
                            text2: 'Update Time',
                            width: Get.width,
                            height: 45,
                            text1: '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
