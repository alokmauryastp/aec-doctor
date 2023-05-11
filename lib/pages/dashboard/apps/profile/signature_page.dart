import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:io' as Io;

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  bool _Load = false;

  void _submit() {
    setState(() {
      _Load = true;
    });
    ProfileRepo profileRepo = new ProfileRepo();
    profileRepo.uploadSignatureImageApi();
    setState(() {
      _Load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _image();
  }

  void _image() async {
    String filename =
        await SharedPrefManager.getPrefrenceString(AppConstant.SIGNATUREIMAGE);
    print('_image $filename');
    // filename.to
    // signatureGlobalKey.currentState.toImage(pixelRatio: 30);
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }


  void _handleSaveButtonPressed() async {
    final data = await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await SharedPrefManager.savePrefString(AppConstant.SIGNATUREIMAGE, base64.encode(bytes!.buffer.asUint8List()));
    _submit();
  }

  void _viewSignature() async {
    String image = await SharedPrefManager.getPrefrenceString(AppConstant.SIGNATUREIMAGE);
    image = image.isNull ? "" : image;


    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                color: Colors.white,
                child: Image.memory(base64Decode(image),errorBuilder:(context, error, stackTrace) { return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Upload signature first !"),
                );
                },),
              ),
            ),
          );
        },
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(),
                  // InkWell(
                  //     onTap: (){
                  //       Get.back();
                  //     },
                  //     child: Icon(Icons.arrow_back,size: 30,)),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 30,
                    width: 30,
                  ),
                  Icon(
                    Icons.notifications,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Signature",
                  style: StringsStyle.normaltextstyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Add your signature, this will be used to attach with prescription and to comply legal requirements.",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 40,
                ),
                _doctorsignature(),
                // _patientnamefield(),
                SizedBox(
                  height: 40,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 45),
                //   child: InkWell(
                //     onTap: (){},
                //     child: CustomButton(
                //       text2: 'CREATE SIGNATURE',
                //       width: Get.width,
                //       height: 50, text1: '',),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getImage() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    // _buttons(bytes);
  }

  _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: _handleSaveButtonPressed,
          child: CustomButton(
            text2: 'Save',
            width: 100,
            height: 50,
            text1: '',
          ),
        ),
        InkWell(
          onTap: _viewSignature,
          child: CustomButton(
            text2: 'View',
            width: 100,
            height: 50,
            text1: '',
          ),
        ),
        InkWell(
          onTap: _handleClearButtonPressed,
          child: CustomButton(
            text2: 'Clear',
            width: 100,
            height: 50,
            text1: '',
          ),
        ),
      ],
    );
  }

  _doctorsignature() {
    return Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 350,
                child: SfSignaturePad(
                    key: signatureGlobalKey,
                    // backgroundColor: AppColors.backgroundColor,
                    strokeColor: Colors.black,
                    minimumStrokeWidth: 1.0,
                    maximumStrokeWidth: 4.0),
                decoration: BoxDecoration(
                  color: AppColors.whitetextColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.appbarbackgroundColor),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(3, 3))
                  ],
                ),
              )),
          SizedBox(height: 60),
          if (_Load) CircularProgressIndicator() else _buttons(),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center);
  }

  _patientnamefield() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 400,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.whitetextColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.appbarbackgroundColor),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(3, 3))
              ],
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        new BorderSide(color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.yellow, width: 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter the patient name";
                }

                return null;
              },
            )),
      ],
    );
  }
}
