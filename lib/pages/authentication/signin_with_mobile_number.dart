import 'package:aec_medical_doctor/api/repository/auth_repo.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/custom/green_custom_button.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class SignInWithMobileNumberPage extends StatefulWidget {
  @override
  _SignInWithMobileNumberPageState createState() =>
      _SignInWithMobileNumberPageState();
}

class _SignInWithMobileNumberPageState
    extends State<SignInWithMobileNumberPage> {
  final _formKey = GlobalKey<FormState>();
  final _mobile = TextEditingController();

  bool _isLoad = false;

  void _trySubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoad = true;
      });
      AuthRepo authRepo = new AuthRepo();
      await authRepo.doctorloginwithotp(_mobile.text);
      setState(() {
        _isLoad = false;
      });
    }
  }

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          title: Text(
            Strings.SIGNIN_APPBAR,
            style: StringsStyle.pagetitlestyle,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              _numberfield(),
              SizedBox(
                height: 50,
              ),
              if (_isLoad) _proccesbutton() else _button(),
              SizedBox(
                height: 30,
              ),
              _hinttext()
            ]),
          )),
        ));
  }

  _hinttext() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Click on the ',
            style: TextStyle(
                color: AppColors.lighttextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            children: const <TextSpan>[
              TextSpan(
                text: 'verify button',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' an',
                style: TextStyle(
                    color: AppColors.lighttextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: ' SMS',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' will',
                style: TextStyle(
                    color: AppColors.lighttextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Text(
          "be sent to your Mobile. SMS & data rates",
          style: TextStyle(
              color: AppColors.lighttextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          "will be applied.",
          style: TextStyle(
              color: AppColors.lighttextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  _numberfield() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 1),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 45,
                    width: 120,
                    child: CountryCodePicker(
                      showDropDownButton: true,
                      onChanged: print,
                      initialSelection: 'IN',
                      favorite: ['+19', 'IN'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    height: 1.2,
                    width: 85,
                    color: Colors.grey,
                  )
                ],
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  controller: _mobile,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mobile number can't be empty";
                    } else if (value.length < 10) {
                      return "Length should be atleast 10!";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    labelStyle: new TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _proccesbutton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Bounce(
          duration: Duration(milliseconds: 110),
          onPressed: _trySubmit,
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
          text2: Strings.SIGNIN_WITH_MOBILE,
          width: Get.width,
          height: 45,
          text1: '',
        ),
      ),
    );
  }
}
