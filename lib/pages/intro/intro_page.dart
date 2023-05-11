import 'package:aec_medical_doctor/custom/green_custom_button.dart';
import 'package:aec_medical_doctor/pages/authentication/signin_with_mobile_number.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: Get.height / 2.7,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage("assets/images/intro.png"),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Text(Strings.INTROTITLE,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: GoogleFonts.lato().fontFamily,
                              color: AppColors.darktextColor,
                              fontSize: 25,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(Strings.INTRODESC,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: GoogleFonts.lato().fontFamily,
                          color: AppColors.darktextColor,
                          fontSize: 15,
                          letterSpacing: 0.5,
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Bounce(
                          duration: Duration(milliseconds: 110),
                          onPressed: () {
                            Get.to(SignInWithMobileNumberPage(),
                                transition: Transition.rightToLeft);
                          },
                          child: GreenCustomButton(
                            text2: Strings.CONTINUE,
                            width: Get.width,
                            height: 50,
                            text1: '',
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
