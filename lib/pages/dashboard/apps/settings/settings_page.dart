import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/settings/faq_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/notification_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched1 = false;
  void toggleSwitch1(bool value) {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched1 = false;
      });
      print('Switch Button is OFF');
    }
  }

  bool isSwitched2 = false;
  void toggleSwitch2(bool value) {
    if (isSwitched2 == false) {
      setState(() {
        isSwitched2 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched2 = false;
      });
      print('Switch Button is OFF');
    }
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
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            _notification(),
            _faq(),
            SizedBox(
              height: 0,
            ),
            _templates(),
            //_patientsreview(),
            _notification_sound(),
            //_clearHistory(),
            //_logout(),
          ],
        ),
      ),
    );
  }

  _notification() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.NOTIFICATIONS_TEXT,
            ),
            Transform.scale(
                scale: 1,
                child: Switch(
                  onChanged: toggleSwitch1,
                  value: isSwitched1,
                  activeColor: AppColors.appbarbackgroundColor,
                  activeTrackColor: Colors.greenAccent,
                  inactiveThumbColor: AppColors.redColor,
                  inactiveTrackColor: Colors.redAccent,
                )),
          ],
        ),
      ),
    );
  }

  _faq() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: InkWell(
          onTap: () {
            Get.to(
              FaqPage(),
              transition: Transition.rightToLeft,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.FAQ_TEXT),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.keyboard_arrow_right_outlined,
                      color: AppColors.darktextColor, size: 30))
            ],
          ),
        ),
      ),
    );
  }

  _templates() {
    return SizedBox(
      width: Get.width / 1,
      child: InkWell(
          onTap: () {
            // Get.to(HelpPage(),
            //     transition: Transition.rightToLeftWithFade,
            //     duration: Duration(milliseconds: 600));
            },
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 15),
              child: Text("Help"),
            ),
          )),
    );
  }

  _patientsreview() {
    return InkWell(
      onTap: (){

      },
      child: SizedBox(
        width: Get.width / 1,
        child: Card(
          elevation: 2,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            child: Text(Strings.PATIENTSREVUEW_TEXT),
          ),
        ),
      ),
    );
  }
  // _counseling() {
  //   return InkWell(
  //     onTap: (){
  //       Get.to(CounselingPage());
  //     },
  //     child: SizedBox(
  //       width: Get.width / 1,
  //       child: Card(
  //         elevation: 2,
  //         child: Padding(
  //           padding:
  //           const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
  //           child: Text("Counseling"),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // ignore: non_constant_identifier_names
  _notification_sound() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Strings.NOTIFICATIONSOUND_TEXT),
            Transform.scale(
                scale: 1,
                child: Switch(
                  onChanged: toggleSwitch2,
                  value: isSwitched2,
                  activeColor: AppColors.appbarbackgroundColor,
                  activeTrackColor: Colors.greenAccent,
                  inactiveThumbColor: AppColors.redColor,
                  inactiveTrackColor: Colors.redAccent,
                )),
          ],
        ),
      ),
    );
  }

  _clearHistory() {
    return SizedBox(
      width: Get.width / 1,
      child: Card(
        elevation: 2,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          child: Text(Strings.CLEARHISTORY_TEXT),
        ),
      ),
    );
  }

  _logout() {
    return SizedBox(
      width: Get.width / 1,
      child: InkWell(
        onTap: () async {
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
          // setState(() async {
          //   await SharedPrefManager.clearPrefs();
          // });
          // Get.back();
          // Get.snackbar("Logout",
          //     "Successfully");
        },
        child: Card(
          elevation: 2,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            child: Text(Strings.LOGOUT),
          ),
        ),
      ),
    );
  }
}
