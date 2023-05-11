import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/templete_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/custom/custom_button.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key}) : super(key: key);

  @override
  _AddMedicinePageState createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  TextEditingController name=new TextEditingController();
  TextEditingController genericName=new TextEditingController();
  TextEditingController strength=new TextEditingController();
  TextEditingController dosage=new TextEditingController();
  TextEditingController duration=new TextEditingController();
  TextEditingController comments=new TextEditingController();
  bool loading=false;
  var mealStatus = -1;
  final _formKey = GlobalKey<FormState>();
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                SizedBox(height:10),
                Text("Add Medicine",style: StringsStyle.title,),
                SizedBox(height:10),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    SizedBox(height: 5),
                    _medicineNameCard(),
                    SizedBox(height: 5),
                    _genericNameCard(),
                    SizedBox(height: 5),
                    _strengthCard(),
                    SizedBox(height: 5),
                    _dosageAndCustomCard(),
                    SizedBox(height: 5),
                  //  _durationAndDaysCard(),
                  //  SizedBox(height: 5),
                    _additionalCommentsCard(),
                    SizedBox(height: 5),
                    _mealOption(),
                  ]),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.backgroundColor,
          elevation: 0,
          child: Bounce(
            duration: Duration(milliseconds: 110),
            //onPressed: _trySubmit,
            onPressed: ()async {
              if (_formKey.currentState!.validate()) {
                setState((){
                  loading=true;
                });
                 String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);
   
                Map parameter={
                  'doctor_id':doctorId,
                  'name':name.text,
                  'generic':genericName.text,
                  'strength':strength.text,
                  'dosage':dosage.text,
                  'duration':duration.text,
                  'comment':comments.text,
                  'take_medicine':mealStatus==0?'Before Meal':'After Meal'

                };
                TemplateRep().addMedicine(parameter).then((value) {
                     setState((){
                  loading=false;
                });
                if(value['status']==1){
                  Get.back();
                }
                });
                // Get.back();
              }
              ;
            },

            child: Container(
                height: 50,
              width: 250,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: loading==true?Container(
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
              ))):CustomButton(
                    text2:"DONE",
                    width: 250,
                    height: 45,
                    text1: '',
                  ),
                ))),
          ),
        ));
  }

  _medicineNameCard() {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            controller: name,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: 'Medicine Name',
              hintStyle: TextStyle(
                color: AppColors.lighttextColor,
                fontSize: 14,
              ),
              border: InputBorder.none,
              errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please, enter the medicine name";
              }

              return null;
            },
          ),
        ));
  }

  _genericNameCard() {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
              controller: genericName,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: 'Generic Name',
              hintStyle: TextStyle(
                color: AppColors.lighttextColor,
                fontSize: 14,
              ),
              border: InputBorder.none,
              errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please, enter the generic name";
              }

              return null;
            },
          ),
        ));
  }

  _strengthCard() {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
              controller: strength,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: 'Strength',
              hintStyle: TextStyle(
                color: AppColors.lighttextColor,
                fontSize: 14,
              ),
              border: InputBorder.none,
              errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please, enter the strength";
              }

              return null;
            },
          ),
        ));
  }

  _dosageAndCustomCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width / 2.2,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                    controller: dosage,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Dosage',
                    hintStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, enter the strength";
                    }

                    return null;
                  },
                ),
              )),
        ),
           SizedBox(
          width: Get.width / 2.2,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                    controller: duration,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Duration',
                    hintStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, enter the duration";
                    }

                    return null;
                  },
                ),
              )),
        ),
     
        // SizedBox(
        //   width: Get.width / 2.2,
        //   child: Card(
        //       elevation: 3,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(5.0),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 10),
        //         child: TextFormField(
        //           textAlign: TextAlign.left,
        //           decoration: InputDecoration(
        //             hintText: 'Custom',
        //             hintStyle: TextStyle(
        //               color: AppColors.lighttextColor,
        //               fontSize: 14,
        //             ),
        //             border: InputBorder.none,
        //             errorBorder:
        //                 new OutlineInputBorder(borderSide: BorderSide.none),
        //             suffixIcon: PopupMenuButton<String>(
        //                 onSelected: (value) {
        //                   Get.snackbar(
        //                     "Changes saved with success",
        //                     "just now",
        //                     snackPosition: SnackPosition.BOTTOM,
        //                     colorText: AppColors.lighttextColor,
        //                     backgroundColor: AppColors.backgroundColor,
        //                     boxShadows: [
        //                       BoxShadow(
        //                         blurRadius: 1,
        //                         color: Colors.grey.shade200,
        //                         offset: Offset(0, 2),
        //                         spreadRadius: 2,
        //                       ),
        //                     ],
        //                     margin: EdgeInsets.all(15),
        //                   );
        //                 },
        //                 icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        //                 itemBuilder: (BuildContext context) {
        //                   return [
        //                     PopupMenuItem(
        //                       child: Text("India"),
        //                       value: "",
        //                     ),
        //                     PopupMenuItem(
        //                       child: Text(
        //                         "Japan",
        //                       ),
        //                       value: "",
        //                     ),
        //                     PopupMenuItem(
        //                       child: Text(
        //                         "America",
        //                       ),
        //                       value: "America",
        //                     ),
        //                     PopupMenuItem(
        //                       child: Text(
        //                         "Korea",
        //                       ),
        //                       value: "",
        //                     ),
        //                     PopupMenuItem(
        //                       child: Text(
        //                         "Chaina",
        //                       ),
        //                       value: "",
        //                     ),
        //                     PopupMenuItem(
        //                       child: Text(
        //                         "Itli",
        //                       ),
        //                       value: "",
        //                     ),
        //                   ];
        //                 }),
        //           ),
        //           validator: (value) {
        //             if (value!.trim().isEmpty) {
        //               return "Please, choose the custom";
        //             }

        //             return null;
        //           },
        //         ),
        //       )),
        // ),
    
    
    
      ],
    );
  }

  _durationAndDaysCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width / 2.2,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Duration',
                    hintStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, enter the duration";
                    }

                    return null;
                  },
                ),
              )),
        ),
        SizedBox(
          width: Get.width / 2.2,
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Days',
                    hintStyle: TextStyle(
                      color: AppColors.lighttextColor,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    errorBorder:
                        new OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: PopupMenuButton<String>(
                        onSelected: (value) {
                          Get.snackbar(
                            "Changes saved with success",
                            "just now",
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: AppColors.lighttextColor,
                            backgroundColor: AppColors.backgroundColor,
                            boxShadows: [
                              BoxShadow(
                                blurRadius: 1,
                                color: Colors.grey.shade200,
                                offset: Offset(0, 2),
                                spreadRadius: 2,
                              ),
                            ],
                            margin: EdgeInsets.all(15),
                          );
                        },
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: Text("Sunday"),
                              value: "",
                            ),
                            PopupMenuItem(
                              child: Text(
                                "Monday",
                              ),
                              value: "",
                            ),
                            PopupMenuItem(
                              child: Text(
                                "Tuesday",
                              ),
                              value: "America",
                            ),
                            PopupMenuItem(
                              child: Text(
                                "Wednesday",
                              ),
                              value: "",
                            ),
                            PopupMenuItem(
                              child: Text(
                                "Thrusday",
                              ),
                              value: "",
                            ),
                            PopupMenuItem(
                              child: Text(
                                "Friday",
                              ),
                              value: "",
                            ),
                            PopupMenuItem(
                              child: Text(
                                "Saturday",
                              ),
                              value: "",
                            ),
                          ];
                        }),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please, choose the days";
                    }

                    return null;
                  },
                ),
              )),
        ),
    
    
    
    
    
      ],
    );
  }

  _additionalCommentsCard() {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
              controller: comments,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: 'Additional Comments',
              hintStyle: TextStyle(
                color: AppColors.lighttextColor,
                fontSize: 14,
              ),
              border: InputBorder.none,
              errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please, enter the additional comments";
              }

              return null;
            },
          ),
        ));
  }

  _mealOption() {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    mealStatus = 0;
                  });
                },
                icon: mealStatus == 0
                    ? Icon(Icons.check_box,
                        color: AppColors.appbarbackgroundColor)
                    : Icon(Icons.check_box_outline_blank,
                        color: AppColors.darktextColor)),
            Text("Before Meal"),
          ],
        ),
        SizedBox(width: 20),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    mealStatus = 1;
                  });
                },
                icon: mealStatus == 1
                    ? Icon(Icons.check_box,
                        color: AppColors.appbarbackgroundColor)
                    : Icon(Icons.check_box_outline_blank,
                        color: AppColors.darktextColor)),
            Text("After Meal"),
          ],
        ),
      ],
    );
  }
}
