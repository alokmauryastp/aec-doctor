import 'dart:io';
import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/controller/backphotoid_controller.dart';
import 'package:aec_medical_doctor/controller/profile_controller.dart';
import 'package:aec_medical_doctor/controller/uploadIndemnityCertificate_controller.dart';
import 'package:aec_medical_doctor/controller/uploadMedicalRegistration_controller.dart';
import 'package:aec_medical_doctor/controller/uploadSignature_controller.dart';
import 'package:aec_medical_doctor/controller/uploadphotofront.dart';
import 'package:aec_medical_doctor/controller/uploadqualification_controller.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SigninUpdateDocumentPage extends StatefulWidget {
  const SigninUpdateDocumentPage({Key? key}) : super(key: key);

  @override
  _SigninUpdateDocumentPageState createState() => _SigninUpdateDocumentPageState();
}

class _SigninUpdateDocumentPageState extends State<SigninUpdateDocumentPage> {
  final _formKey = GlobalKey<FormState>();
  final profileController = Get.put(UploadPhotoIdFrontController());
  int _radioSelected = 0;
  late String _radioVal;
  late String files;
  late File filename;
  late File newFile;
  // GetProfileData getProfileData = Get.arguments;
  // late String clinicname;
  // late String pincode;
  // late String state;
  // late String district;
  // late String address;
  // late String image;
  //
  // late String accountholder;
  // late String accountnumber;
  // late String ifsc;
  // late String bankname;
  // late String branchname;
  //
  // void _allDetail()async{
  //   String images = await SharedPrefManager.getPrefrenceString(AppConstant.IMAGE);
  //   String clinicnames = await SharedPrefManager.getPrefrenceString(AppConstant.CLINICNAME);
  //   String addresses = await SharedPrefManager.getPrefrenceString(AppConstant.ADDRESS);
  //   String pincodes = await SharedPrefManager.getPrefrenceString(AppConstant.PINCODE);
  //   String states = await SharedPrefManager.getPrefrenceString(AppConstant.STATE);
  //   String districts = await SharedPrefManager.getPrefrenceString(AppConstant.DISTRICT);
  //   String accountholders =  await SharedPrefManager.getPrefrenceString(AppConstant.ACCOUNTHOLDER);
  //   String accountnumbers =  await SharedPrefManager.getPrefrenceString(AppConstant.ACCOUNTNUMBER);
  //   String ifscs =  await SharedPrefManager.getPrefrenceString(AppConstant.IFSC);
  //   String banknames =  await SharedPrefManager.getPrefrenceString(AppConstant.BANKNAME);
  //   String branchnames = await SharedPrefManager.getPrefrenceString(AppConstant.BRANCHNAME);
  //
  //   setState(() {
  //     clinicname = clinicnames;
  //     address = addresses;
  //     pincode=pincodes;
  //     state = states;
  //     district = districts;
  //     image= images;
  //
  //     accountholder = accountholders;
  //     accountnumber = accountnumbers;
  //     ifsc = ifscs;
  //     bankname = banknames;
  //     branchname = branchnames;
  //
  //
  //   });
  //   _clinicname.text = clinicnames;
  //   _pincode.text = pincodes;
  //   _state.text=states;
  //   _district.text = districts;
  //   _address.text = addresses;
  //   _image.text = image;
  //
  //   _accountholder.text = accountholders;
  //   _accountnumber.text = accountnumbers;
  //   _ifsc.text = ifscs;
  //   _bankname.text = banknames;
  //   _branchname.text = branchnames;
  // }

  final _clinicname = TextEditingController();
  final _pincode = TextEditingController();
  final _state = TextEditingController();
  final _district = TextEditingController();
  final _address = TextEditingController();
  final _image = TextEditingController();

  final _accountholder = TextEditingController();
  final _accountnumber = TextEditingController();
  final _ifsc = TextEditingController();
  final _bankname = TextEditingController();
  final _branchname = TextEditingController();

  bool _isLoad = false;

  @override
  void initState() {
    super.initState();
  }


  void _updateclinicAddress()async{
    setState(() {
      _isLoad = true;
    });
    ProfileRepo profileRepo = new ProfileRepo();
    await profileRepo.clinicUpdateApi(_clinicname.text,_address.text, _pincode.text, _state.text, "204");
    setState(() {
      _isLoad = false;
    });

  }

  void _bankUpdate()async{
    setState(() {
      _isLoad = true;
    });
    ProfileRepo profileRepo = new ProfileRepo();
    await profileRepo.bankUpdateApi(_accountnumber.text, _accountholder.text, _ifsc.text, _branchname.text, _bankname.text);
    setState(() {
      _accountnumber.clear();
      _accountholder.clear();
      _ifsc.clear();
      _branchname.clear();
      _bankname.clear();
      _isLoad = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, size: 25)),
          title: Text("Update Documents",
            style: StringsStyle.pagetitlestyle,),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          SizedBox(height: 2),
                          _clinicbody(),
                          _editprofilebody(),
                        ]),
                      ),
                    )))));

  }
  _clinicbody() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Clinic / Hospital Address",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                    fontSize: 15)),
          ),
          SizedBox(height: 10,),
          Container(
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
                  Colors.white,
                  Colors.white70,
                ]),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.bottomLeft,
              child: TextFormField(
                controller: _clinicname,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  errorBorder:
                  new OutlineInputBorder(borderSide: BorderSide.none),
                  labelText: "Clinic name",
                  labelStyle: TextStyle(
                    color: AppColors.lighttextColor,
                    fontSize: 14,
                  ),
                ),
                validator: (value) => value!.isEmpty
                    ? 'Enter Your Client Name'
                    :RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
                    ? 'Enter a Valid Client Name'
                    : null,
              )),
          SizedBox(height: 10,),
          Container(
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
                  Colors.white,
                  Colors.white70,
                ]),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.bottomLeft,
              child: TextFormField(
                controller: _address,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  errorBorder:
                  new OutlineInputBorder(borderSide: BorderSide.none),
                  labelText: "Address",
                  labelStyle: TextStyle(
                    color: AppColors.lighttextColor,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, enter your Address.";
                  }

                  return null;
                },
              )),

          SizedBox(height: 15),
          Container(

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
                  Colors.white,
                  Colors.white70,
                ]),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.bottomLeft,
              child: TextFormField(
                controller: _pincode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  errorBorder:
                  new OutlineInputBorder(borderSide: BorderSide.none),
                  labelText: "Pin",
                  labelStyle: TextStyle(
                    color: AppColors.lighttextColor,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, enter your pin";
                  }

                  return null;
                },
              )),
          SizedBox(
            height: 15,
          ),
          // Container(
          //
          //     decoration: BoxDecoration(
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.4),
          //           spreadRadius: 1,
          //           blurRadius: 3,
          //           offset: Offset(0, 3),
          //         ),
          //       ],
          //       gradient: LinearGradient(colors: [
          //         Colors.white,
          //         Colors.white70,
          //       ]),
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     alignment: Alignment.bottomLeft,
          //     child: TextFormField(
          //       controller: _district,
          //       keyboardType: TextInputType.text,
          //       textInputAction: TextInputAction.next,
          //       autovalidateMode: AutovalidateMode.onUserInteraction,
          //       textAlignVertical: TextAlignVertical.bottom,
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //         contentPadding:
          //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          //         errorBorder:
          //         new OutlineInputBorder(borderSide: BorderSide.none),
          //         labelText: "District",
          //         labelStyle: TextStyle(
          //           color: AppColors.lighttextColor,
          //           fontSize: 14,
          //         ),
          //       ),
          //       validator: (value) {
          //         if (value!.trim().isEmpty) {
          //           return "Please, enter your District";
          //         }
          //         return null;
          //       },
          //     )),
          SizedBox(height: 15),
          Container(
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
                  Colors.white,
                  Colors.white70,
                ]),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.bottomLeft,
              child: TextFormField(
                controller: _state,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  errorBorder:
                  new OutlineInputBorder(borderSide: BorderSide.none),
                  labelText: "State",
                  labelStyle: TextStyle(
                    color: AppColors.lighttextColor,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please, enter your State";
                  }

                  return null;
                },
              )),
        ]);
  }

  _editprofilebody() {
    return Column(children: [
      SizedBox(height: 20),
      Container(
        alignment: Alignment.centerLeft,
        child: Text("Update Documents",
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w500,
              fontSize: 15),),
      ),
      SizedBox(height: 20,),
      Container(
          height: 50,
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
              Colors.white,
              Colors.white70,
            ]),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Front Photo ID",style: TextStyle(color: Colors.grey,fontSize: 14),),
                InkWell(
                    onTap: (){
                      _showPicker(context);
                    },
                    child: Icon(Icons.cloud_upload_outlined,size: 25,color: Colors.grey,))
              ],
            ),
          ),
          // child: TextFormField(
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.next,
          //   autovalidateMode: AutovalidateMode.onUserInteraction,
          //   textAlignVertical: TextAlignVertical.bottom,
          //   decoration: InputDecoration(
          //     border: InputBorder.none,
          //     contentPadding:
          //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          //     errorBorder:
          //     new OutlineInputBorder(borderSide: BorderSide.none),
          //     labelText: "Photo ID",
          //     labelStyle: TextStyle(
          //       color: AppColors.lighttextColor,
          //       fontSize: 14,
          //     ),
          //   ),
          //   validator: (value) {
          //     if (value!.trim().isEmpty) {
          //       return "Please, Upload your Photo ID ";
          //     }
          //
          //     return null;
          //   },
          // ),
      ),
      SizedBox(height: 20,),
      Container(
        height: 50,
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
            Colors.white,
            Colors.white70,
          ]),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Back Photo ID",style: TextStyle(color: Colors.grey,fontSize: 14),),
              InkWell(
                  onTap: (){
                    _uploadPhotoIdBack(context);
                  },
                  child: Icon(Icons.cloud_upload_outlined,size: 25,color: Colors.grey,))
            ],
          ),
        ),
        // child: TextFormField(
        //   keyboardType: TextInputType.text,
        //   textInputAction: TextInputAction.next,
        //   autovalidateMode: AutovalidateMode.onUserInteraction,
        //   textAlignVertical: TextAlignVertical.bottom,
        //   decoration: InputDecoration(
        //     border: InputBorder.none,
        //     contentPadding:
        //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        //     errorBorder:
        //     new OutlineInputBorder(borderSide: BorderSide.none),
        //     labelText: "Photo ID",
        //     labelStyle: TextStyle(
        //       color: AppColors.lighttextColor,
        //       fontSize: 14,
        //     ),
        //   ),
        //   validator: (value) {
        //     if (value!.trim().isEmpty) {
        //       return "Please, Upload your Photo ID ";
        //     }
        //
        //     return null;
        //   },
        // ),
      ),
      SizedBox(height: 15),
      Container(
          height: 50,
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
              Colors.white,
              Colors.white70,
            ]),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Upload Sign",style: TextStyle(color: Colors.grey,fontSize: 14),),
              InkWell(
                  onTap: (){
                   _uploadSignature(context);
                  },
                  child: Icon(Icons.cloud_upload_outlined,size: 25,color: Colors.grey,))
            ],
          ),
        ),
          // child: TextFormField(
          //
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.next,
          //   autovalidateMode: AutovalidateMode.onUserInteraction,
          //   textAlignVertical: TextAlignVertical.bottom,
          //   decoration: InputDecoration(
          //     border: InputBorder.none,
          //     contentPadding:
          //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          //     errorBorder:
          //     new OutlineInputBorder(borderSide: BorderSide.none),
          //     labelText: "Upload sign",
          //     labelStyle: TextStyle(
          //       color: AppColors.lighttextColor,
          //       fontSize: 14,
          //     ),
          //   ),
          //   validator: (value) {
          //     if (value!.trim().isEmpty) {
          //       return "Please, upload your sign ";
          //     }
          //
          //     return null;
          //   },
          // ),
      ),
      SizedBox(height: 15),
      Container(
          height: 50,
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
              Colors.white,
              Colors.white70,
            ]),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Upload certificate",style: TextStyle(color: Colors.grey,fontSize: 14),),
              InkWell(
                  onTap: (){
                    _uploadQualificationImagee(context);
                  },
                  child: Icon(Icons.cloud_upload_outlined,size: 25,color: Colors.grey,))
            ],
          ),
        ),
          // child: TextFormField(
          //   controller: _address,
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.next,
          //   autovalidateMode: AutovalidateMode.onUserInteraction,
          //   textAlignVertical: TextAlignVertical.bottom,
          //   decoration: InputDecoration(
          //     border: InputBorder.none,
          //     contentPadding:
          //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          //     errorBorder:
          //     new OutlineInputBorder(borderSide: BorderSide.none),
          //     labelText: "Upload certificate",
          //     labelStyle: TextStyle(
          //       color: AppColors.lighttextColor,
          //       fontSize: 14,
          //     ),
          //   ),
          //   validator: (value) {
          //     if (value!.trim().isEmpty) {
          //       return "Please, Upload your certificate";
          //     }
          //
          //     return null;
          //   },
          // ),
      ),
      SizedBox(height: 15),
      Container(
          height: 50,
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
              Colors.white,
              Colors.white70,
            ]),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Indeminity Certificate",style: TextStyle(color: Colors.grey,fontSize: 14),),
              InkWell(
                  onTap: (){
                    _uploadIndemnityCertificate(context);
                  },
                  child: Icon(Icons.cloud_upload_outlined,size: 25,color: Colors.grey,))
            ],
          ),
        ),
          // child: TextFormField(
          //   keyboardType: TextInputType.number,
          //   textInputAction: TextInputAction.next,
          //   autovalidateMode: AutovalidateMode.onUserInteraction,
          //   textAlignVertical: TextAlignVertical.bottom,
          //   decoration: InputDecoration(
          //     border: InputBorder.none,
          //     contentPadding:
          //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          //     errorBorder:
          //     new OutlineInputBorder(borderSide: BorderSide.none),
          //     labelText: "Indemnity Certificate",
          //     labelStyle: TextStyle(
          //       color: AppColors.lighttextColor,
          //       fontSize: 14,
          //     ),
          //   ),
          //   validator: (value) {
          //     if (value!.trim().isEmpty) {
          //       return "Please, upload your Indemnity Certificate";
          //     }
          //     return null;
          //   },
          // ),
      ),
      SizedBox(height: 15),
      Container(
        height: 50,
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
            Colors.white,
            Colors.white70,
          ]),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Medical Registration",style: TextStyle(color: Colors.grey,fontSize: 14),),
              InkWell(
                  onTap: (){
                    _uploadMedicalRegistration(context);
                  },
                  child: Icon(Icons.cloud_upload_outlined,size: 25,color: Colors.grey,))
            ],
          ),
        ),
        // child: TextFormField(
        //   keyboardType: TextInputType.number,
        //   textInputAction: TextInputAction.next,
        //   autovalidateMode: AutovalidateMode.onUserInteraction,
        //   textAlignVertical: TextAlignVertical.bottom,
        //   decoration: InputDecoration(
        //     border: InputBorder.none,
        //     contentPadding:
        //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        //     errorBorder:
        //     new OutlineInputBorder(borderSide: BorderSide.none),
        //     labelText: "Indemnity Certificate",
        //     labelStyle: TextStyle(
        //       color: AppColors.lighttextColor,
        //       fontSize: 14,
        //     ),
        //   ),
        //   validator: (value) {
        //     if (value!.trim().isEmpty) {
        //       return "Please, upload your Indemnity Certificate";
        //     }
        //     return null;
        //   },
        // ),
      ),
      SizedBox(height: 15),
      Container(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: (){
            Get.bottomSheet(
              SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child:Column(
                      children: [
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.cancel,size: 35,)),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Update Bank Details",
                          style: TextStyle(color: AppColors.darktextColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Container(height: 2,
                            color: AppColors.darktextColor,),
                        ),
                        SizedBox(height: 15,),
                        _accountnumberfield(),
                        SizedBox(height: 15,),
                        _accountholdernamefield(),
                        SizedBox(height: 15,),
                        _ifsccodefield(),
                        SizedBox(height: 15,),
                        _bankbranchfield(),
                        SizedBox(height: 15,),
                        _banknamefield(),
                        SizedBox(height: 40,),
                        if(_isLoad)
                          CircularProgressIndicator()
                        else Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: InkWell(
                              onTap: (){
                                _bankUpdate();
                                print("asbklk");
                                Get.back();
                              },
                              child: CustomButton(
                                  text1: "",
                                  text2: "SUBMIT",
                                  width: Get.width,
                                  height: 50)),
                        ),
                        SizedBox(height: 40,),
                      ],
                    )
                ),
              ),
              isDismissible: true,
              enableDrag: true,
            );
          },
          child: Text("Add Bank Details +",
            style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w500,
                fontSize: 15),),
        ),
      ),
      SizedBox(height: 30),
      if(_isLoad)
        CircularProgressIndicator()
      else Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _updateclinicAddress();
              }
            },
            child: CustomButton(
                text1: "",
                text2: "SUBMIT",
                width: Get.width,
                height: 50)),
      ),
    ]);
  }
  _accountnumberfield() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
      Container(
          height: 50,
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
            controller: _accountnumber,
            keyboardType: TextInputType.number,
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
                  borderSide:
                  new BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "  Account Number",
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please, enter your Account Number";
              }

              return null;
            },
          )),
    );
  }
  _accountholdernamefield() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
      Container(
          height: 50,
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
            controller: _accountholder,
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
                  borderSide:
                  new BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "  Account Holder Name",
            ),
            validator: (value) => value!.isEmpty
                ? 'Enter Your Account Holder Name'
                :RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
                ? 'Enter a Valid Account Holder Name'
                : null,
          )),
    );
  }
  _ifsccodefield() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
      Container(
          height: 50,
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
            controller: _ifsc,
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
                  borderSide:
                  new BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "  IFSC Code",
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please, enter your IFSC Code";
              }

              return null;
            },
          )),
    );
  }
  _bankbranchfield() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
      Container(
          height: 50,
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
            controller: _branchname,
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
                  borderSide:
                  new BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "  Bank Branch",
            ),
            validator: (value) => value!.isEmpty
                ? 'Enter Your Branch Name'
                :RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
                ? 'Enter a Valid Branch Name'
                : null,
          )),
    );
  }

  _banknamefield() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
      Container(
          height: 50,
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
            controller: _bankname,
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
                  borderSide:
                  new BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "  Bank Name ",
            ),
            validator: (value) => value!.isEmpty
                ? 'Enter Your Bank Name'
                :RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
                ? 'Enter a Valid Bank Name'
                : null,
          )),
    );
  }
}


void _showPicker(context) {

  final signupController = Get.put(UploadPhotoIdFrontController());

  showModalBottomSheet(
    // enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_camera,
                      size: 35,),
                    title: new Text('Camera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),),
                    onTap: () {
                      signupController.getImage(ImageSource.camera,context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_library,
                    size: 35,),
                  title: new Text('Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );



}

void _uploadPhotoIdBack(context) {

  final signupController = Get.put(UploadPhotoIdBackController());

  showModalBottomSheet(
    // enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_camera,
                      size: 35,),
                    title: new Text('Camera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),),
                    onTap: () {
                      signupController.getImage(ImageSource.camera,context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_library,
                    size: 35,),
                  title: new Text('Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );



}

void _uploadSignature(context) {

  final signupController = Get.put(UploadSignatureController());

  showModalBottomSheet(
    // enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_camera,
                      size: 35,),
                    title: new Text('Camera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),),
                    onTap: () {
                      signupController.getImage(ImageSource.camera,context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_library,
                    size: 35,),
                  title: new Text('Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );



}

void _uploadQualificationImagee(context) {

  final signupController = Get.put(UploadQualificationImageeController());

  showModalBottomSheet(
    // enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_camera,
                      size: 35,),
                    title: new Text('Camera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),),
                    onTap: () {
                      signupController.getImage(ImageSource.camera,context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_library,
                    size: 35,),
                  title: new Text('Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );



}

////////////////////////////////////////////////////

void _uploadMedicalRegistration(context) {

  final signupController = Get.put(UploadMedicalRegistrationController());

  showModalBottomSheet(
    // enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_camera,
                      size: 35,),
                    title: new Text('Camera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),),
                    onTap: () {
                      signupController.getImage(ImageSource.camera,context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_library,
                    size: 35,),
                  title: new Text('Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );



}

void _uploadIndemnityCertificate(context) {

  final signupController = Get.put(UploadIndemnityCertificateController());

  showModalBottomSheet(
    // enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_camera,
                      size: 35,),
                    title: new Text('Camera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),),
                    onTap: () {
                      signupController.getImage(ImageSource.camera,context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_library,
                    size: 35,),
                  title: new Text('Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );



}