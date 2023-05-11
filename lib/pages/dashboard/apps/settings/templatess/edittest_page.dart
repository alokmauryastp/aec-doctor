import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/templete_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/model/AdviceModel.dart';
import 'package:aec_medical_doctor/model/showtest_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class EditTestPage extends StatefulWidget {
  const EditTestPage({Key? key}) : super(key: key);

  @override
  _EditTestPageState createState() => _EditTestPageState();
}

class _EditTestPageState extends State<EditTestPage> {
  TextEditingController test =new TextEditingController();
  TextEditingController description=new TextEditingController();
  bool loading=false;
  final _formKey = GlobalKey<FormState>();

  late TestDatum _testDatum;


  void initalizeDataToAllTextField(){
    setState((){
      test.text=_testDatum.test;
      description.text=_testDatum.description;
    });
  }

  @override
  void initState() {
    _testDatum=Get.arguments;
    initalizeDataToAllTextField();
    super.initState();
  }


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
            child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Edit Test"),
                        SizedBox(height:10),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Title"),
                          controller: test,
                          style: TextStyle(
                              color: AppColors.lighttextColor, fontSize: 13),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please, enter the title";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Description"),
                          controller: description,
                          style: TextStyle(
                              color: AppColors.lighttextColor, fontSize: 13),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please, enter the Description";
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Bounce(
                              duration: Duration(milliseconds: 110),
                              //onPressed: _trySubmit,
                              onPressed: ()async {
                                if (_formKey.currentState!.validate()) {
                                  setState((){
                                    loading=true;
                                  });
                                  String doctorId = await SharedPrefManager.getPrefrenceString(AppConstant.DOCTORID);

                                  Map parameter={
                                    "doctor_id":doctorId,
                                    "test_id": _testDatum.testId,
                                  //  test.text=_testDatum.test,
                                    "test": test.text,
                                    "description": description.text,

                                  };
                                  TemplateRep().editTest(parameter).then((value) {
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

                              child:  loading==true?Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.whitetextColor,
                                      border: Border.all(
                                        color: AppColors.appbarbackgroundColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Center(
                                        child:SizedBox(height:15,width:15,child: CircularProgressIndicator())
                                    ),
                                  )):Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.whitetextColor,
                                      border: Border.all(
                                        color: AppColors.appbarbackgroundColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Center(
                                      child: Text(
                                        "EDIT",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.appbarbackgroundColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          )),
    );
  }
}
