// @dart=2.9
import 'package:aec_medical_doctor/api/repository/chat_repo.dart';
import 'package:aec_medical_doctor/model/chatModel/getmedicalhistory_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MedicalHistoryPage extends StatefulWidget {
  const MedicalHistoryPage({Key key}) : super(key: key);

  @override
  _MedicalHistoryPageState createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {

  final _formKey = GlobalKey<FormState>();

  var index = "a";

  String answer;
  bool _isLoad= false;
  List<GetMedicalHistoryModel> getMedicalHistoryModel = [];


  @override
  void initState() {
    super.initState();
    ChatRepo chatRepo = new ChatRepo();
    Future future = chatRepo.getMedicalHistoryApi();
    future.then((value) {
      setState(() {
        getMedicalHistoryModel = value;
        print("ssspeciality" + getMedicalHistoryModel[0].data.answer1);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: true,
        title: Text(
          "Medical History",
          style: StringsStyle.pagetitlestyle,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, size: 25)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child:
                  getMedicalHistoryModel.isEmpty?CircularProgressIndicator():Column(
                    children: [
                      if(getMedicalHistoryModel[0].data.question1.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 1",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question1,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _questiontxtfield(),
                                    ])),
                                SizedBox(height: 1,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 10,),
                      if(getMedicalHistoryModel[0].data.question2.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 2",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question2,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question1txtfield(),
                                    ]),
                                ),
                                SizedBox(height: 1,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15,),
                      if(getMedicalHistoryModel[0].data.question3.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 3",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question3,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question2txtfield(),
                                    ])),
                                SizedBox(height: 1,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15,),
                      if(getMedicalHistoryModel[0].data.question4.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 4",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question4,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question3txtfield(),
                                    ])),

                                SizedBox(height: 1,),


                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 1,),
                      if(getMedicalHistoryModel[0].data.question5.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 5",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question5,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question4txtfield(),

                                    ])),
                                SizedBox(height: 1,),


                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15,),
                      if(getMedicalHistoryModel[0].data.question6.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 6",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question6,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question5txtfield(),
                                    ])),

                                SizedBox(height: 1,),


                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15,),
                      if(getMedicalHistoryModel[0].data.question7.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 7",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question7,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question6txtfield(),
                                    ])),

                                SizedBox(height: 1,),

                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15,),
                      if(getMedicalHistoryModel[0].data.question8.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 8",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question8,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question7txtfield(),
                                    ])),
                                SizedBox(height: 1,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15,),
                      if(getMedicalHistoryModel[0].data.question9.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 9",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question9,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question8txtfield(),
                                    ])),
                                SizedBox(height: 1,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15,),
                      if(getMedicalHistoryModel[0].data.question10.isEmpty)
                        Text("")
                      else Card(elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Question 10",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appbarbackgroundColor)),
                                      SizedBox(height: 5,),
                                      Text(getMedicalHistoryModel[0].data.question10,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darktextColor)),
                                      SizedBox(height: 10,),
                                      _question9txtfield(),
                                    ])),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );

  }
  _questiontxtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer1}");
  }

  _question1txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer2}");


  }

  _question2txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer3}");
  }

  _question3txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer4}");
  }

  _question4txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer5}");
  }

  _question5txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer6}");
  }

  _question6txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer7}");
  }

  _question7txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer8}");
  }

  _question8txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer9}");
  }

  _question9txtfield() {
    return Text("Answer: ${getMedicalHistoryModel[0].data.answer10}");
  }

}
