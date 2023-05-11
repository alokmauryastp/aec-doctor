import 'dart:io';
import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/auth_repo.dart';
import 'package:aec_medical_doctor/api/repository/profile_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/controller/profile_controller.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/model/profile/getprofile_model.dart';
import 'package:aec_medical_doctor/model/profile/symptoms_model.dart';
import 'package:aec_medical_doctor/model/speciality_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'update_documents_page.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final profileController = Get.put(ProfileController());
  DateTime selectedDate = DateTime.now();
  var formatDate;

  GetProfileData getProfileModel = Get.arguments;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(1980),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDate = selectedDate.day.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.year.toString();
      });
    }
  }

  List<String> _genders = ['Male', 'Female'];

  List<String> _symptoms = [
    'Sore Throat',
    'Coughing',
    'Pneumonia',
    'Hair loss',
    'Shoulder pain',
    'High Blood pressure',
    'Vertigo',
    'Leg Pain',
    'Vitiligo',
    'Knee Pain',
    'Fungal infection',
    'Acne',
    'Cold',
    'Fever'
  ];

  // List<String> _speciality = ['Kidney & Urine','Psychiatry','Stomach & Digestion','Gynecology','Pediatrics','General Physician','Dermatology'];

  String? _selectgen;
  String? _selectg;
  String? _selectv1;
  String? _selectv2;

  String? _selectsymptoms;
  String? _selectspeciality;

  int _radioSelected = 0;
  late String _radioVal;
  late String files;
  late File filename;
  late File newFile;

  // GetProfileData getProfileData = Get.arguments;

  late String name;
  late String award;
  late String mobilenumber;
  late String email;
  late String gender;
  late String speciality;
  late String symptom;
  late var dob;
  late String address;
  late String image;
  late String experiace;
  late String qualification;
  late String hqualification;
  late String medicalregistrationid;

  void _allDetail() async {
    String images = await getProfileModel.profile;
    String names = await getProfileModel.name;
    String awards = await getProfileModel.award;
    String mobilnumbers = await getProfileModel.mobile;
    String emails = await getProfileModel.email;
    String genders = await getProfileModel.gender;
    var dateob = await getProfileModel.dOB;
    String experiaces = await getProfileModel.experiance;
    String qualifications = await getProfileModel.qualification;
    String hqualifications = await getProfileModel.highestQualification;
    String medicalregistrationids = await getProfileModel.medicalRegistrationId;
    String addresses = await getProfileModel.address;
    String specialitys = await getProfileModel.speciality;
    String symptoms = await getProfileModel.symptoms;

    //print("hbshdjs"+getProfileModel);

    setState(() {
      _selectgen = getProfileModel.gender;
      name = names;
      award = awards;
      mobilenumber = mobilnumbers;
      email = emails;
      gender = genders;
      dob = dateob;
      // _selectgen = genders;
      address = addresses;
      image = images;
      experiace = experiaces;
      qualification = qualifications;
      hqualification = hqualifications;
      medicalregistrationid = medicalregistrationids;
      speciality = specialitys;
      symptom = symptoms;
      _selectspeciality = getProfileModel.speciality;
      _selectsymptoms = getProfileModel.symptoms;
    });
    _name.text = names;
    _award.text = awards;
    _mobile.text = mobilnumbers;
    _email.text = emails;
    _gender.text = genders;
    _dob.text = dateob;
    _address.text = addresses;
    _image.text = images;
    _experiance.text = experiaces;
    _qualification.text = qualifications;
    _hqualification.text = hqualifications;
    _medicalregistrationid.text = medicalregistrationids;
    // _speciality = specialitys;
    // _symptoms = symptoms;
  }

  final _name = TextEditingController();
  final _award = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _gender = TextEditingController();
  final _dob = TextEditingController();
  final _medicalregistrationid = TextEditingController();
  final _hqualification = TextEditingController();
  final _experiance = TextEditingController();
  final _qualification = TextEditingController();
  final _address = TextEditingController();
  final _image = TextEditingController();

  // final _speciality = TextEditingController();
  // final _symptom = TextEditingController();

  bool _isLoad = false;
  List<SymptomsData> symptomsData = [];

  List<SpecialityData> specialityData = [];
  List<String> _speciality = [];

  late Future future;

  @override
  void initState() {
    super.initState();
    print("k1" + getProfileModel.speciality);
    print("k2" + getProfileModel.symptoms);
    print("k3" + getProfileModel.gender);

    AuthRepo authRepo = new AuthRepo();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var future = authRepo.symptomsApi();
      future.then((value) async {
        setState(() {
          symptomsData = value;
          print("kktitlesss" + symptomsData[0].symptoms);
        });
      });
    });
    future = authRepo.specialityApi();
    future.then((value) {
      setState(() {
        specialityData = value;
        print("kktitle" + specialityData[0].speciality);
        for (var i = 0; i < specialityData.length; i++) {
          print("_speciality");
          print(specialityData.length);
          _speciality.add(specialityData[i].speciality);
        }
      });
    });
    _allDetail();
  }

  void _updateprofile() async {
    setState(() {
      _isLoad = true;
    });
    ProfileRepo profileRepo = new ProfileRepo();
    await profileRepo.updateproifileApi(
        _name.text,
        _email.text,
        _mobile.text,
        selectedDate.isNull ? formatDate : selectedDate,
        _selectg.isNull ? gender : _selectg,
        _experiance.text,
        _hqualification.text,
        _qualification.text,
        _medicalregistrationid.text,
        _selectv2.isNull ? speciality : _selectv2,
        _selectv1.isNull ? symptom : _selectv1,
        _award.text);
    setState(() {
      _isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.appbarbackgroundColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, size: 25)),
          title: Text(
            "Update profile",
            style: StringsStyle.pagetitlestyle,
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(children: [
          SizedBox(height: 2),
          _editimagebody(),
          _editprofilebody(),
        ])))));
  }

  _editimagebody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Update",
                  style: TextStyle(
                      color: AppColors.appbarbackgroundColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
              SizedBox(height: 2),
              Text("Profile",
                  style: TextStyle(
                      color: AppColors.appbarbackgroundColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
            ]),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  height: 90,
                  width: 90,
                  child: Obx(
                    () => profileController.selectedImagePath.value == ''
                        ? CircleAvatar(
                            radius: 75,
                            backgroundImage: NetworkImage(image),
                          )
                        : ClipOval(
                            child: Image.file(
                            File(profileController.selectedImagePath.value),
                            fit: BoxFit.cover,
                          )),
                  ),
                ),
              ),
            ),
          ]),
        )
      ]),
    );
  }

  _editprofilebody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
          key: _formKey,
          child: Column(children: [
            // Text(symptom),
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
                  controller: _name,
                  // keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Full Name",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) => value!.isEmpty
                      ? 'Enter Your Name'
                      : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value)
                          ? 'Enter a Valid Name'
                          : null,
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
                  controller: _email,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Please enter a valid email",
                )),
            SizedBox(
              height: 15,
            ),
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
                  controller: _mobile,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Mobile number",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, enter your mobile number";
                    }
                    if (value.trim().length < 10) {
                      return "mobile number have must be at least 10 digits";
                    }
                    return null;
                  },
                )),
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            formatDate ?? dob,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_sharp)
                      ],
                    ),
                  ),
                ),
              ),
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
              child: Center(
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  iconSize: 20.0,
                  hint: Text(
                    '${gender}                                                                         ',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  // Not necessary for Option 1
                  value: _selectg,
                  onChanged: (newValue) {
                    setState(() {
                      _selectg = newValue;
                    });
                  },
                  items: _genders.map((type) {
                    return DropdownMenuItem(
                      child: new Text(type),
                      value: type,
                    );
                  }).toList(),
                ),
              ),
            ),
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
                  controller: _experiance,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Experience(Years)",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, enter your experience ";
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
                  controller: _hqualification,
                  // keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Highest Qualification",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, enter your Highest Qualification ";
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
                  controller: _qualification,
                  // keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Qualification",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, enter your Qualification ";
                    }

                    return null;
                  },
                )),

            // SizedBox(height: 15),
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
            //       controller: _address,
            //       keyboardType: TextInputType.text,
            //       textInputAction: TextInputAction.next,
            //       autovalidateMode: AutovalidateMode.onUserInteraction,
            //       textAlignVertical: TextAlignVertical.bottom,
            //       decoration: InputDecoration(
            //         border: InputBorder.none,
            //         contentPadding:
            //             EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            //         errorBorder:
            //             new OutlineInputBorder(borderSide: BorderSide.none),
            //         labelText: "Clinic/hospital name and address",
            //         labelStyle: TextStyle(
            //           color: AppColors.lighttextColor,
            //           fontSize: 14,
            //         ),
            //       ),
            //       validator: (value) {
            //         if (value!.trim().isEmpty) {
            //           return "Please, enter your Clinic/hospital name and address";
            //         }
            //
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
                  controller: _medicalregistrationid,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Medical registration ID",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, enter your Medical registration ID";
                    }
                    return null;
                  },
                )),
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
                padding: const EdgeInsets.only(left: 16.0),
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  iconSize: 20.0,
                  hint: Text(
                    '${getProfileModel.symptoms.split(",")[0]}',
                    style: TextStyle(fontSize: 14),
                  ),
                  // Not necessary for Option 1
                  value: _selectv1,
                  onChanged: (newValue) {
                    setState(() {
                      _selectv1 = newValue;
                    });
                  },
                  items: _symptoms.map((type) {
                    return DropdownMenuItem(
                      child: Expanded(child: new Text(type)),
                      value: type,
                    );
                  }).toList(),
                ),
              ),
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
                padding: const EdgeInsets.only(left: 16.0),
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  iconSize: 20.0,
                  hint: Text(
                    '${speciality}                                                  ',
                    style: TextStyle(fontSize: 14),
                  ),
                  // Not necessary for Option 1
                  value: _selectv2,
                  onChanged: (newValue) {
                    setState(() {
                      _selectv2 = newValue;
                    });
                  },
                  items: _speciality.map((type) {
                    return DropdownMenuItem(
                      child: new Text(type),
                      value: type,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                  controller: _award,
                  // keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Award",
                    labelStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                  ),
                  //    validator: (value) {
                  //    if (value!.trim().isEmpty) {
                  //    return "Please, enter your ";
                  //   }
                  // return null;
                  // },
                )),
            SizedBox(height: 30),
            if (_isLoad)
              CircularProgressIndicator()
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _updateprofile();
                        // Get.to(UpdateDocumentPage());
                      }
                    },
                    child: CustomButton(
                        text1: "",
                        text2: "NEXT",
                        width: Get.width,
                        height: 50)),
              ),
          ])),
    );
  }

 }

void _showPicker(context) {
  final signupController = Get.put(ProfileController());

  showModalBottomSheet(
      // enableDrag: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      size: 35,
                    ),
                    title: new Text(
                      'Camera',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      signupController.getImage(ImageSource.camera, context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(
                    Icons.photo_library,
                    size: 35,
                  ),
                  title: new Text(
                    'Gallery',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery, context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
