import 'package:aec_medical_doctor/pages/dashboard/apps/patients/report_issues/detailed_issue_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/patients/report_issues/tech_issue_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/notification_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportIssuesPage extends StatefulWidget {
  const ReportIssuesPage({Key? key}) : super(key: key);

  @override
  _ReportIssuesPageState createState() => _ReportIssuesPageState();
}

class _ReportIssuesPageState extends State<ReportIssuesPage> {
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
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: InkWell(
                onTap: () {
                  // Get.to(
                  //   FaqPage(),
                  //   transition: Transition.rightToLeft,
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: null,
                            icon: Icon(Icons.headphones,
                                color: AppColors.darktextColor, size: 30)),
                        Text("Talk to support"),
                      ],
                    ),
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
                  Get.to(
                    TechIssuepage(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tech issue"),
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
                  Get.to(
                    DetailedIssuePage(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Other issue"),
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
}
