import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/pages/dashboard/notification_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailedIssuePage extends StatefulWidget {
  const DetailedIssuePage({Key? key}) : super(key: key);

  @override
  _DetailedIssuePageState createState() => _DetailedIssuePageState();
}

class _DetailedIssuePageState extends State<DetailedIssuePage> {
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
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      // Get.to(
                      //   FaqPage(),
                      //   transition: Transition.rightToLeft,
                      // );
                    },
                    child: Text("Please explain your issue in detail"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "your issue"),
                style: TextStyle(color: AppColors.lighttextColor, fontSize: 13),
              ),
            ),
            SizedBox(height: 40),
            CustomButton(
                text1: "", text2: "SUBMIT ISSUE", width: 250, height: 45)
          ],
        ),
      )),
    );
  }
}
