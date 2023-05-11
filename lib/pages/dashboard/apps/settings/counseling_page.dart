import 'dart:async';

import 'package:aec_medical_doctor/api/repository/counseling_repo.dart';
import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/model/allpatients_model.dart';
import 'package:aec_medical_doctor/model/show_counseling_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../addCounceling_page.dart';
import '../../notification_page.dart';
import 'editcounseling_page.dart';


class CounselingPage extends StatefulWidget {
  const CounselingPage({Key? key}) : super(key: key);

  @override
  _CounselingPageState createState() => _CounselingPageState();
}

class _CounselingPageState extends State<CounselingPage> {

  late Timer timer;
  late Future future;



  List<ShowCounselingData> showCounselingData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
        this.setState(() {
          CounselingRepo counselingRepo = new CounselingRepo();
          future = counselingRepo.showCounselingApi();
          future.then((value) {
            setState(() {
              showCounselingData = value;
              print("kktitle" + showCounselingData[0].name);
            });
          });
        });
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
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _details(),
                SizedBox(
                  height: 10,
                ),
                _addCounseling(),
                SizedBox(
                  height: 20,
                ),
                showCounselingData.isNull?
                Container(child: Center(child: Text("Sorry! Counselling not available.")))
                    :showCounselingData.isEmpty?
                Center(child: CircularProgressIndicator())
                    : _patientList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addCounseling(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
          onTap: () {
           Get.to(AddCouncelingPage());
          },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 30,
          child: Container(
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
                  Colors.black26,
                  Colors.black54,
                ]),
                borderRadius: BorderRadius.circular(15),
              ),
              width: Get.width,
              height: 50,
              alignment: Alignment.center,
              child: Text("Add Counselling",style: TextStyle(fontSize: 15),)),
        ),
          ),
    );
  }

  _details() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text("All Counselling",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: AppColors.appbarbackgroundColor,
                letterSpacing: 0.5,
              )),
        ],
      ),
    );
  }

  _patientList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: showCounselingData.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${showCounselingData[index].name}",
                              style: TextStyle(
                                  color: AppColors.darktextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5,),
                          Text("Date: ${showCounselingData[index].startDate}",
                              style: TextStyle(
                                  color: AppColors.darktextColor,
                                 )),
                          SizedBox(height: 5,),
                          Text("Time: ${showCounselingData[index].time}",
                              style: TextStyle(
                                color: AppColors.darktextColor,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        // child: Image.network(myCoursesData[index].image),
                        child: GestureDetector(
                          onTap: () async {
                            String  url = showCounselingData[index].link.toString();
                            if (await canLaunch(url)) {
                              await launch(url, forceWebView: true,enableJavaScript: true);
                            } else {
                              throw 'Could not launch $url';
                            }
                            //Get.to(VideoPlayerPage(),arguments: newCounselingData[index].video);
                          },
                          child: Card(
                            color: Colors.blue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Video Call",style: TextStyle(fontSize: 10,
                                      fontWeight: FontWeight.w600,color: Colors.white),),
                                  Icon(Icons.video_call,color: Colors.white,size: 15,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: (){
                            Get.to(EditCounselingPage(),arguments: showCounselingData[index]

                            );
                          },
                          child: Icon(Icons.edit,size: 25,color: Colors.black,)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

}
