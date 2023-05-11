import 'package:aec_medical_doctor/pages/authentication/signin_with_mobile_number.dart';
import 'package:aec_medical_doctor/pages/authentication/update_profile_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/home_page.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/profile/update_profile_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: AnimatedSplashScreen(
        splashIconSize: 200,
        splash: Stack(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
            ),
            Positioned(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
              child: CircleAvatar(
                radius: 100,
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                AssetImage("assets/fonts/otpverification.png"),
                            colorFilter: ColorFilter.mode(
                                Colors.teal, BlendMode.color),
                        ),
                    ),
                ),
              ),
            )
          ],
        ),
        //nextScreen: UpdateProfilePage(),
          nextScreen: SigninUpdateProfilePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.backgroundColor,
        duration: 500,
      ),
    );
  }
}
