import 'package:aec_medical_doctor/custom/green_custom_button.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/profile/update_profile_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../notification_page.dart';

class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {

  late GetProfileData getProfileModel  = Get.arguments;

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
                      Icons.arrow_back,
                      size: 25,
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xffED816E),
                      Color(0xffB93342),
                    ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              _profileimage(),
                              SizedBox(height: 10,),
                              _profileName(),
                              SizedBox(height: 10,),
                              Text(getProfileModel.clinicName+', '+getProfileModel.address + getProfileModel.pincode,style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.whitetextColor,
                                  letterSpacing: 0.2,
                                  fontSize: 15
                              )),


                            ],
                          ),
                        ),
                      // _qualificationdetails(),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 15,),
                      _allDetails(),
                    ],
                  ),
                ),

                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _profileimage(){
    return Stack(
      children: [
        Container(
          width: 200,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(getProfileModel.profile),
          ),
        ),
        Positioned(
          left: 125,
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
                      Icon(Icons.verified_user,size: 20,color: Colors.lightGreen,),
                      Text("Verified",
                        style: TextStyle(
                          fontSize: 10,
                        ),),
                    ],
                  ),
                ),
              ),
              //Image.asset("assets/images/logo.png"),
            ],
          ),
        )
      ],
    );
  }

  _profileName(){
    return Column(
      children: [
        Text("Dr. ${getProfileModel.name}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.whitetextColor,
                letterSpacing: 0.2,
                fontSize: 15
            )
        ),
        Text(getProfileModel.highestQualification,
          style: TextStyle(
              color: AppColors.whitetextColor,
              letterSpacing: 0.2,
              fontSize: 15        ),),
        // Text("Paediatric and neonatal intensive care",
        //   style: TextStyle(
        //     color: AppColors.whitetextColor,
        //     fontSize: 12,
        //     letterSpacing: 0.2,
        //   ),
        // ),
      ],
    );
  }

  _qualificationdetails(){
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Image.asset("assets/images/graduate.png",
            //       height: 25,
            //       width: 25,
            //     color: Colors.white,),
            //     SizedBox(width: 5,),
            //     Text("Qualification :",
            //       style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           color: AppColors.whitetextColor,
            //           letterSpacing: 0.2,
            //           fontSize: 15
            //       ),
            //     ),
            //     SizedBox(width: 25,),
            //     Column(
            //       children: [
            //         Container(
            //           width: 160,
            //           child: Text(getProfileModel.qualification,
            //             style: TextStyle(
            //                 color: AppColors.whitetextColor,
            //                 letterSpacing: 0.2,
            //                 fontSize: 15),
            //             overflow: TextOverflow.ellipsis,
            //             softWrap: false,
            //           ),
            //         ),
            //         // SizedBox(width: 5,),
            //         // Container(
            //         //   width: 160,
            //         //   child: Text("Paediatric and neonatal intensive care",
            //         //     style: TextStyle(
            //         //         color: AppColors.whitetextColor,
            //         //         letterSpacing: 0.2,
            //         //         fontSize: 15),
            //         //     overflow: TextOverflow.ellipsis,
            //         //     softWrap: false,
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ],
            // ),
            SizedBox(height: 20,),
            Row(
              children: [
                Image.asset("assets/images/ribbon.png",
                  color: AppColors.whitetextColor,
                  height: 25,
                  width: 25,),
                SizedBox(width: 5,),
                Text("Experiencee :  ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.whitetextColor,
                        letterSpacing: 0.2,
                        fontSize: 15
                    )
                ),
                SizedBox(width: 25,),
                Text("${getProfileModel.experiance}  Years",
                  style: TextStyle(
                      color: AppColors.whitetextColor,
                      letterSpacing: 0.2,
                      fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Image.asset("assets/images/hospital.png",
                  height: 20,
                  width: 20,
                  color: AppColors.whitetextColor,),
                SizedBox(width: 5,),
                Text(" Practicing :    ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.whitetextColor,
                        letterSpacing: 0.2,
                        fontSize: 15
                    )
                ),
                SizedBox(width: 25,),
                Text(getProfileModel.experiance,
                  style: TextStyle(
                      color: AppColors.whitetextColor,
                      letterSpacing: 0.2,
                      fontSize: 15),),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _allDetails(){
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Image.asset("assets/images/money.png",
            //       height: 20,
            //       width: 20,),
            //
            //     Text("  Consultation Fees :",
            //         style: TextStyle(
            //             fontWeight: FontWeight.w600,
            //             color: AppColors.darktextColor,
            //             letterSpacing: 0.2,
            //             fontSize: 15
            //         )
            //     ),
            //     SizedBox(width: 25,),
            //     Row(
            //       children: [
            //         Image.asset("assets/images/rupee.png",
            //         height: 15,width: 15,),
            //         Text(" 200",
            //           style: TextStyle(
            //               letterSpacing: 0.2,
            //               color: AppColors.darktextColor,
            //               fontSize: 15),),
            //       ],
            //     ),
            //   ],
            // ),
            // SizedBox(height: 20,),
            Row(
              children: [

                Image.asset("assets/images/gender.png",
                  height: 25,
                  width: 25,),

                Text("  Gender :",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darktextColor,
                        letterSpacing: 0.2,
                        fontSize: 15
                    )
                ),
                SizedBox(width: 25,),
                Container(
                  width: 150,
                  child: Text(getProfileModel.gender,
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [

                Image.asset("assets/images/birthday.png",
                  height: 25,
                  width: 25,),

                Text("  DOB :",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darktextColor,
                        letterSpacing: 0.2,
                        fontSize: 15
                    )
                ),
                SizedBox(width: 25,),
                Container(
                  width: 150,
                  child: Text(getProfileModel.dOB,
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Image.asset("assets/images/ribbon.png",
                  height: 25,
                  width: 25,),

                Text(" Experience :",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darktextColor,
                        letterSpacing: 0.2,
                        fontSize: 15
                    )
                ),
                SizedBox(width: 25,),
                Container(
                  width: 150,
                  child: Text(getProfileModel.experiance +' years',
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.folder_special,size: 25,),
                Text(" Specialization :",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darktextColor,
                        letterSpacing: 0.2,
                        fontSize: 15
                    )
                ),
                SizedBox(width: 25,),
                Container(
                  width: 150,
                  child: Text(getProfileModel.speciality,
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.folder_special,size: 25,),
                Text(" Symptoms :",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darktextColor,
                        letterSpacing: 0.2,
                        fontSize: 15
                    )
                ),
                SizedBox(width: 25,),
                Container(
                  width: 150,
                  child: Text(getProfileModel.symptoms,
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),
            Row(
              children: [
                Image.asset("assets/images/graduate.png",
                  height: 25,
                  width: 25,
                  color: AppColors.darktextColor,),

                Text(" Education :",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darktextColor,
                      letterSpacing: 0.2,
                      fontSize: 15
                  ),
                ),
                SizedBox(width: 25,),
                Container(
                  width: 150,
                  child: Text(getProfileModel.qualification,
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),
            // SizedBox(height: 20,),
            // Row(
            //   children: [
            //     Image.asset("assets/images/translate.png",
            //       height: 25,
            //       width: 25,
            //       color: AppColors.darktextColor,),
            //
            //     Text(" Language :",
            //         style: TextStyle(
            //             fontWeight: FontWeight.w600,
            //             color: AppColors.darktextColor,
            //             letterSpacing: 0.2,
            //             fontSize: 15
            //         )
            //     ),
            //     SizedBox(width: 25,),
            //     Text("Hindi, English",
            //       style: TextStyle(
            //           letterSpacing: 0.2,
            //           color: AppColors.darktextColor,
            //           fontSize: 15),),
            //   ],
            // ),

            SizedBox(height: 20,),
            Row(
              children: [
                Image.asset("assets/images/award.png",
                  height: 25,
                  width: 25,
                  color: AppColors.darktextColor,),

                Text(" Awards :",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darktextColor,
                      letterSpacing: 0.2,
                      fontSize: 15
                  ),
                ),
                SizedBox(width: 25,),
                Container(
                  width: 150,
                  child: Text(getProfileModel.award,
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }


}
