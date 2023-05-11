import 'package:aec_medical_doctor/pages/dashboard/notification_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechIssuepage extends StatefulWidget {
  const TechIssuepage({Key? key}) : super(key: key);

  @override
  _TechIssuepageState createState() => _TechIssuepageState();
}

class _TechIssuepageState extends State<TechIssuepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo.png",
          height: 30,
          width: 30,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                Get.to(
                  NotificationPage(),
                  transition: Transition.rightToLeft,
                );
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: InkWell(
                onTap: () {
                  BottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Unable to send or received SMS"),
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.keyboard_arrow_right_outlined,
                            color: AppColors.darktextColor, size: 30))
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: InkWell(
                onTap: () {
                  BottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Unable to connect call"),
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.keyboard_arrow_right_outlined,
                            color: AppColors.darktextColor, size: 30))
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: InkWell(
                onTap: () {
                  BottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Notification not received"),
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.keyboard_arrow_right_outlined,
                            color: AppColors.darktextColor, size: 30))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> BottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        elevation: 0,
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  child: Wrap(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text("1. Kindly check your network"),
                    SizedBox(height: 5),
                    Text("2. Call from your registered number"),
                    SizedBox(height: 5),
                    Text("3. If problem still exists, try after some time"),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          elevation: 3,
                          color: AppColors.appbarbackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                              child: Wrap(
                                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                Text(
                                                    "We apologize for the inconvenience. We will"),
                                                SizedBox(height: 2),
                                                Text(
                                                    "escalate the same to the relevant team. thank you"),
                                                SizedBox(height: 2),
                                                Text("For reporting"),
                                                SizedBox(height: 30),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Card(
                                                      elevation: 3,
                                                      color: AppColors
                                                          .appbarbackgroundColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 8, 20, 8),
                                                        child: InkWell(
                                                          onTap: () {
                                                            // Get.to(
                                                            //     TechIssuepage());
                                                          },
                                                          child: Center(
                                                            child: Text("OK",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .whitetextColor,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Card(
                                                      elevation: 0,
                                                      color: AppColors
                                                          .whitetextColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .darktextColor,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ])));
                                    });
                              },
                              child: Center(
                                child: Text("OK",
                                    style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Card(
                          elevation: 0,
                          color: AppColors.whitetextColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Center(
                                child: Text("Cancel",
                                    style: TextStyle(
                                        color: AppColors.darktextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ])));
        });
  }
}
