import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/templete_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/model/showquestion_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class EditQuestionPage extends StatefulWidget {
  const EditQuestionPage({Key? key}) : super(key: key);

  @override
  _EditQuestionPageState createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends State<EditQuestionPage> {
  TextEditingController title =new TextEditingController();
  TextEditingController question=new TextEditingController();
  bool loading=false;
  final _formKey = GlobalKey<FormState>();
  late QnDatum _qnDatum;
  void initalizeDataToAllTextField(){
    setState((){
      title.text=_qnDatum.title;
      question.text=_qnDatum.question;
    });
  }

  @override
  void initState() {
    _qnDatum=Get.arguments;
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
                        Text("Add Question"),
                        SizedBox(height:10),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Title"),
                          controller: title,
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
                          decoration: InputDecoration(hintText: "Question"),
                          controller: question,
                          style: TextStyle(
                              color: AppColors.lighttextColor, fontSize: 13),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please, enter the question";
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
                                    'question_id':_qnDatum.questionId,
                                    'doctor_id':doctorId,
                                    'title':title.text,
                                    'question':question.text,

                                  };
                                  TemplateRep().editQuestion(parameter).then((value) {
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
                                        "ADD",
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
