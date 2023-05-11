import 'dart:async';
import 'dart:convert';

import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/custom/green_custom_button.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/profile/profile_details_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/profile/signature_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/profile/update_profile_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../notification_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
//  late Timer timer;
  late Future future;

  var current_index = 3;
  late List<GetProfileModel> getProfileModel = [];

  @override
  void initState() {
    super.initState();
    print("api call init");

    this.setState(() {
      ProfileRepo profileRepo = new ProfileRepo();
      future = profileRepo.getproifileApi();
      future.then((value) {
        setState(() {
          getProfileModel = value;
        });
      });
    });
    HomeRepo homeRepo = new HomeRepo();
    homeRepo.checkDoctorAccountApi();
  }

  @override
  void didUpdateWidget(covariant ProfilePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("api call");
    ProfileRepo profileRepo = new ProfileRepo();
    future = profileRepo.getproifileApi();
    future.then((value) {
      setState(() {
        getProfileModel = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
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
                // crossAxisAlignment: CrossAxisAlignment.start,
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
        child: getProfileModel.isNull
            ? Text("")
            : Center(
                child: getProfileModel.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Stack(children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    color: AppColors.profileBg,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(Strings.PROFILEDETAILS,
                                            style:
                                                StringsStyle.profiletitlestyle),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 0,
                                            ),
                                            _profileName(),
                                            _profileimage(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(UpdateProfilePage(),
                                          arguments: getProfileModel[0].data);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      elevation: 5,
                                      // color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.edit_rounded,
                                          size: 20,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              _personaldetailbanner(),
                              SizedBox(
                                height: 10,
                              ),
                              _qualificationdetails(),
                              SizedBox(
                                height: 30,
                              ),
                              _botton(),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
      ),
    );
  }

  _personaldetailbanner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
            gradient: LinearGradient(colors: [
              Color(0xffED816E),
              Color(0xffB93342),
            ]),
          ),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.PERSONALDETAILBANNERTEXT,
                    style: StringsStyle.personaldetailbannerstyle),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      getProfileModel[0].data.email,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.2,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      getProfileModel[0].data.mobile,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                          fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  _profileimage() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage:
                NetworkImage(getProfileModel[0].data.profile, scale: 1),
          ),
        ),
        Positioned(
          left: 115,
          //right: 10,
          top: 20,
          bottom: 20,
          child: Row(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_user,
                        size: 15,
                        color: Colors.lightGreen,
                      ),
                      Text(
                        "Verified",
                        style: TextStyle(
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Image.asset("assets/images/logo.png"),
            ],
          ),
        ),
      ],
    );
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

  _profileName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Dr. ${getProfileModel[0].data.name}",
            style: TextStyle(
                fontFamily: GoogleFonts.montserrat().fontFamily,
                color: AppColors.darktextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        Text(
          getProfileModel[0].data.highestQualification,
          style: TextStyle(
              fontFamily: GoogleFonts.montserrat().fontFamily,
              color: AppColors.lighttextColor,
              fontSize: 14),
        ),
      ],
    );
  }

  _qualificationdetails() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/ribbon.png",
                      height: 25,
                      width: 25,
                      color: AppColors.lighttextColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Specialization",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.topRight,
                child: Text(
                  getProfileModel[0].data.speciality,
                  style: profileStyle,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/graduate.png",
                      height: 25,
                      width: 25,
                      color: AppColors.lighttextColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Qualification",
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.topRight,
                child: Text(
                  getProfileModel[0].data.qualification,
                  style: profileStyle,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/ribbon.png",
                      height: 25,
                      width: 25,
                      color: AppColors.lighttextColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Experience", style: textStyle),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.topRight,
                child: Text(
                  getProfileModel[0].data.experiance + ' years',
                  style: profileStyle,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/hospital.png",
                      height: 20,
                      width: 20,
                      color: AppColors.lighttextColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Practicing", style: textStyle),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.topRight,
                child: Text(
                  getProfileModel[0].data.experiance,
                  style: profileStyle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/gender.png",
                      height: 20,
                      width: 20,
                      color: AppColors.lighttextColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Gender", style: textStyle),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.topRight,
                child: Text(
                  getProfileModel[0].data.gender,
                  style: profileStyle,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/birthday.png",
                      height: 20,
                      width: 20,
                      color: AppColors.lighttextColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("DOB", style: textStyle),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.topRight,
                child: Text(
                  getProfileModel[0].data.dOB,
                  textAlign: TextAlign.end,
                  style: profileStyle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(onTap:(){
            Get.to(ProfileDetailsPage(),
                arguments: getProfileModel[0].data);
          } ,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5.0, vertical: 5),
                child: Text(
                  "View as User",
                  style: TextStyle(
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  _botton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Get.to(SignaturePage());
              },
              child: GreenCustomButton(
                text2: 'Add Signature',
                width: 150,
                height: 40,
                text1: '',
              ),
            ),
            InkWell(
              onTap: () async {
                _viewSignature();
              },
              child: GreenCustomButton(
                text2: 'View Signature',
                width: 150,
                height: 40,
                text1: '',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void _viewSignature() async {
    String image =
        await SharedPrefManager.getPrefrenceString(AppConstant.SIGNATUREIMAGE);

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                color: Colors.white,
                child: Image.network(
                  getProfileModel[0].data.signature,
                  errorBuilder: (context, error, stackTrace) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Upload signature first !"),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
