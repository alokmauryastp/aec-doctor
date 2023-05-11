import 'dart:async';
import 'package:aec_medical_doctor/pages/intro/intro_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  dynamic data = [];

  // NetworkUtil _netUtil = new NetworkUtil();
  // SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => IntroPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appbarbackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DelayedDisplay(
                delay: Duration(seconds: 1),
                child: _logo(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _logo() {
    return Column(
      children: [
        Container(
            height: 190,
            width: 190,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png")))),
        SizedBox(
          height: 10,
        ),
        Text(
          Strings.LOGO_TITLE,
          style: StringsStyle.whitelogotitlestyle,
        ),
      ],
    );
  }
}
