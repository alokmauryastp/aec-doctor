import 'dart:io';

import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
                    SizedBox(height: 30,width: 30,),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _heading(),
            SizedBox(height: 10),
            //_chatSupportCard(),
            _onCallSupportCard(),
            _visitLinkCard(),
          ]),
        ));
  }

  _heading() {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline,
                    color: AppColors.appbarbackgroundColor, size: 30),
                SizedBox(width: 10),
                Text(Strings.HELPPAGE_HEADING, style: StringsStyle.heading)
              ],
            ),
          ),
        ),
        Container(
            height: Get.height / 2.5,
            width: Get.width / 1,
            color: Colors.red[50])
      ],
    );
  }

  _chatSupportCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.chat_bubble_rounded,
                    color: AppColors.appbarbackgroundColor),
                SizedBox(width: 10),
                Text(Strings.CHAT_SUPPORT),
              ],
            ),
            Icon(Icons.keyboard_arrow_right_outlined,
                size: 30, color: AppColors.darktextColor)
          ],
        ),
      ),
    );
  }

  _onCallSupportCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline,
                    color: AppColors.appbarbackgroundColor),
                SizedBox(width: 10),
                Text(Strings.CALL_SUPPORT),
              ],
            ),
            Icon(Icons.keyboard_arrow_right_outlined,
                size: 30, color: AppColors.darktextColor)
          ],
        ),
      ),
    );
  }

  _visitLinkCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.web, color: AppColors.appbarbackgroundColor),
                SizedBox(width: 10),
                Text(Strings.CALL_SUPPORT),
              ],
            ),
            Icon(Icons.keyboard_arrow_right_outlined,
                size: 30, color: AppColors.darktextColor)
          ],
        ),
      ),
    );
  }
}
