import 'package:aec_medical_doctor/api/repository/auth_repo.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/pages/authentication/otp_verify_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  var mobileno = Get.arguments;
  var pincode;
  bool _isLoad = false;
  void _trySubmit() async {
    if (pincode != null) {
      setState(() {
        _isLoad = true;
      });
      AuthRepo authRepo = new AuthRepo();
      await authRepo.verifyOtpApi(mobileno, pincode);
      setState(() {
        _isLoad = false;
      });
    }
  }

  void _resendOtp() async {
    setState(() {
      _isLoad = true;
    });
    AuthRepo authRepo = new AuthRepo();
    authRepo.resendOtpApi(mobileno);
    setState(() {
      _isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.clear, color: AppColors.darktextColor))
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _heading(),
                    SizedBox(height: 60),
                    _otpfield(),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        // SizedBox(height:50),
                        Text(
                          "Didn't receive the SMS?",
                          style: TextStyle(
                            color: AppColors.lighttextColor,
                          ),
                        ),
                        _resendoption(),
                        SizedBox(
                          height: 10,
                        ),

                        if (_isLoad) CircularProgressIndicator() else _button(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _heading() {
    return Column(children: [
      Text(
        "Enter the 6 digit code sent to:",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        mobileno,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Column(
        children: [
          Text(
            "We've sent a 6 digit code to your phone number.",
            textAlign: TextAlign.center,
          ),
          Text(
            "Please enter the verification code.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ]);
  }

  _otpfield() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width,
        fieldWidth: 30,
        obscureText: true,
        style: TextStyle(fontSize: 17),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onChanged: (pin) {
          print("Changed: " + pin);
        },
        onCompleted: (pin) {
          pincode = pin;
          print("Completed: " + pin);
          print("pincode" + pincode);
        },
      ),
    );
  }

  _proccesbutton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Bounce(
          duration: Duration(milliseconds: 110),
          onPressed: (){},
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
                  Colors.black87,
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 45,
              width: Get.width,
              child: Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.whitetextColor,
                    ),
                  )))),
    );
  }

  _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Bounce(
        duration: Duration(milliseconds: 110),
        onPressed: _trySubmit,
        child: CustomButton(
          text2: 'VERIFY & PROCEED',
          width: Get.width,
          height: 45,
          text1: '',
        ),
      ),
    );
  }

  _resendoption() {
    return Center(
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: _resendOtp,
        child: Text(
          "Resend new code",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.appbarbackgroundColor,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
