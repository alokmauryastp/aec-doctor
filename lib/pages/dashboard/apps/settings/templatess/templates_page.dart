import 'package:aec_medical_doctor/api/repository/templete_repo.dart';
import 'package:aec_medical_doctor/model/AdviceModel.dart';
import 'package:aec_medical_doctor/model/GetMedicineModel.dart';
import 'package:aec_medical_doctor/model/showquestion_model.dart';
import 'package:aec_medical_doctor/model/showtest_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'addadvice_page.dart';
import 'addmedicine_page.dart';
import 'addquestion_page.dart';
import 'addtest_page.dart';
import 'editAdvice_page.dart';
import 'editmedicine_page.dart';
import 'editquestion_page.dart';
import 'edittest_page.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({Key? key}) : super(key: key);

  @override
  _TemplatesPageState createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  var onclick = 0;
  bool isLoading = false;
  List<Datum> medicinceList = [];

  void getMedicineList() async {
    medicinceList.clear();
    setState(() {
      isLoading = true;
    });
    TemplateRep().getMedicineList().then((value) {
      print(value);
      if (value['status'] == 1) {
        print("success full");
        for (int i = 0; i < value['data'].length; i++) {
          Datum data = Datum.fromJson(value['data'][i]);
          medicinceList.add(data);
        }
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }




  bool isLoading1 = false;
  List<QnDatum> questionList = [];
  void getQuestionList() async {
    questionList.clear();
    setState(() {
      isLoading1 = true;
    });
    TemplateRep().getQuestionList().then((value) {
      print(value);
      if (value['status'] == 1) {
        print("successfull");
        for (int i = 0; i < value['data'].length; i++) {
          QnDatum data = QnDatum.fromJson(value['data'][i]);
          questionList.add(data);
        }
      } else {}
      setState(() {
        isLoading1 = false;
      });
    });
  }

  List<TestDatum> testList = [];
  void getTestList() async {
    testList.clear();
    setState(() {
      isLoading1 = true;
    });
    TemplateRep().getTestList().then((value) {
      print(value);
      if (value['status'] == 1) {
        print("successfull");
        for (int i = 0; i < value['data'].length; i++) {
          TestDatum data = TestDatum.fromJson(value['data'][i]);
          testList.add(data);
        }
      } else {}
      setState(() {
        isLoading1 = false;
      });
    });
  }

  List<AdviceDatum> adviceList = [];

  void getAdvice() async {
    adviceList.clear();
    setState(() {
      isLoading = true;
    });
    TemplateRep().getAdvice().then((value) {
      print(value);
      if (value['status'] == 1) {
        print("success full");
        print(value);
        for (int i = 0; i < value['data'].length; i++) {
          AdviceDatum data = AdviceDatum.fromJson(value['data'][i]);
          adviceList.add(data);
        }
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMedicineList();
    getTestList();
    // getQuestionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo.png",
          height: 30,
          width: 30,
        ),
        actions: [
          IconButton(
              onPressed: () {
                switch (onclick) {
                  case 0:
                    Get.to(AddMedicinePage(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(milliseconds: 600))
                        ?.then((value) {
                      getMedicineList();
                    });
                    break;
                  case 1:
                    Get.to(AddAdvicePage(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(milliseconds: 600))
                        ?.then((value) {
                      getAdvice();
                    });
                    break;
                  case 2:
                    Get.to(AddQuestionPage(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(milliseconds: 600))
                        ?.then((value) {
                      getQuestionList();
                    });
                    break;
                  case 3:
                    Get.to(AddTestPage(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(milliseconds: 600))
                        ?.then((value) {
                      getTestList();
                    });
                    break;
                  default:
                    print("5th");
                    break;
                }
              },
              icon: Icon(Icons.add, size: 25, color: Colors.white))
        ],
      ),
      body: Container(
          width: Get.width / 1,
          color: AppColors.appbarbackgroundColor,
          child: Stack(children: [
            _medicinesContainer(),
            _adviceContainer(),
            _questionsContainer(),
            _TestContainer(),
            // _diagnosisContainer(),
            _verticalTabBar(),
            _tabNameIndicator(),
          ])),
    );
  }

  _verticalTabBar() {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: 60,
        color: AppColors.appbarbackgroundColor,
        height: Get.height / 1,
        child: Column(
          children: [
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                setState(() {
                  onclick = 0;
                });
                getMedicineList();
              },
              child: CircleAvatar(
                  radius: 21,
                  backgroundColor: AppColors.lightblueColor,
                  child:
                      Center(child: Icon(Icons.medication, color: Colors.red))),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                setState(() {
                  onclick = 1;
                });
                getAdvice();
              },
              child: CircleAvatar(
                  radius: 21,
                  backgroundColor: AppColors.lightblueColor,
                  child:
                      Center(child: Icon(Icons.lightbulb_outline , color: Colors.red))),
            ),
            SizedBox(height: 15),
            InkWell(
                onTap: () {
                  setState(() {
                    onclick = 2;
                  });
                  getQuestionList();
                },
                child: CircleAvatar(
                    radius: 21,
                    backgroundColor: AppColors.lightblueColor,
                    child: Center(
                        child: Icon(Icons.help, color: Colors.red)))),
            SizedBox(height: 15),
            InkWell(
                onTap: () {
                  setState(() {
                    onclick = 3;
                  });
                },
                child: CircleAvatar(
                    radius: 21,
                    backgroundColor: AppColors.lightblueColor,
                    child: Center(
                        child: Icon(Icons.receipt_long, color: Colors.red)))),
            // SizedBox(height: 15),
            // InkWell(
            //     onTap: () {
            //       setState(() {
            //         onclick = 4;
            //       });
            //     },
            //     child: CircleAvatar(
            //         radius: 21,
            //         backgroundColor: AppColors.lightblueColor,
            //         child: Center(
            //             child: Icon(Icons.medication, color: Colors.red)))),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _tabNameIndicator() {
    return Positioned(
        left: 60,
        top: 0,
        child: Container(
            height: Get.height / 1,
            width: 100,
            color: Colors.transparent,
            child: Column(children: [
              SizedBox(height: 25),
              Visibility(
                visible: onclick == 0,
                child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.appbarbackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(3, 3),
                              color: Colors.grey.shade300)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                      child: Text("Medicines",
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
              ),
              SizedBox(height: 58),
              Visibility(
                visible: onclick == 1,
                child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.appbarbackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(3, 3),
                              color: Colors.grey.shade300)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                      child: Text("Advice",
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
              ),
              SizedBox(height: 57),
              Visibility(
                visible: onclick == 2,
                child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.appbarbackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(3, 3),
                              color: Colors.grey.shade300)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                      child: Text("Questions",
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
              ),
              SizedBox(height: 57),
              Visibility(
                visible: onclick == 3,
                child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.appbarbackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(3, 3),
                              color: Colors.grey.shade300)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                      child: Text("Test",
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
              ),
              SizedBox(height: 57),
              Visibility(
                visible: onclick == 4,
                child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.appbarbackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(3, 3),
                              color: Colors.grey.shade300)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                      child: Text("Diagnosis",
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
              )
            ])));
  }

  _medicinesContainer() {
    return Visibility(
      visible: onclick == 0,
      child: Container(
        //   height:Get.height/1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: Card(
                        elevation: 1,
                        color: Colors.blueGrey.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text("Medicine List",
                                style: StringsStyle.normaltextstyle),
                          ),
                        ),
                      ),
                    ),
                    isLoading == true
                        ? Container(
                            height: Get.height / 1,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Container(
                            height: Get.height / 1,
                            child: ListView.builder(
                                itemCount: medicinceList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return  Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  child: SizedBox(
                                  width: Get.width,
                                  child: Card(
                                  elevation: 3,
                                  child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Title: ${medicinceList[index].name}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                      SizedBox(height: 10,),
                                      Text("Description: ${medicinceList[index].comment}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                      ),
                                    ),
                                  ) ,secondaryActions: <Widget>[
                                    IconSlideAction(
                                        caption: 'Edit',
                                        color: Colors.black45,
                                        icon: Icons.edit,
                                        onTap: () => {
                                          Get.to(EditMedicinePage(),
                                              arguments: medicinceList[index]
                                          )!.then((value) {
                                            setState((){
                                              getMedicineList();
                                            });
                                          })
                                        }),
                                    IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () => {
                                          TemplateRep().deleteMedicine(medicinceList[index].medicineId).then((value) {
                                            getMedicineList();
                                          })
                                        }),
                                  ],
                                  );
                                }),
                          )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  _adviceContainer() {
    return Visibility(
      visible: onclick == 1,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Container(
              color: AppColors.backgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Card(
                      elevation: 1,
                      color: Colors.blueGrey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text("Advice List",
                              style: StringsStyle.normaltextstyle),
                        ),
                      ),
                    ),
                  ),
                  isLoading == true
                      ? Container(
                          height: Get.height / 1,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Container(
                          height: Get.height / 1,
                          child: ListView.builder(
                              itemCount: adviceList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Card(
                                      elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Title: ${adviceList[index].title}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            SizedBox(height: 10,),
                                            Text("Description: ${adviceList[index].description}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                        caption: 'Edit',
                                        color: Colors.black45,
                                        icon: Icons.edit,
                                        onTap: () => {
                                          Get.to(EditAdvicePage(),
                                          arguments: adviceList[index]
                                          )!.then((value) {
                                            setState((){
                                              getAdvice();
                                            });
                                          })
                                        }),
                                    IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () => {
                                          TemplateRep().deleteAdvice(adviceList[index].adviceId).then((value) {
                                            getAdvice();
                                          })
                                        }),
                                  ],
                                );
                              }),
                        )
                ],
              )),
        ),
      ),
    );
  }

  _questionsContainer() {
    return Visibility(
      visible: onclick == 2,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Container(
              color: AppColors.backgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Card(
                      elevation: 1,
                      color: Colors.blueGrey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text("List of questions",
                              style: StringsStyle.normaltextstyle),
                        ),
                      ),
                    ),
                  ),
                  isLoading1 == true
                      ? Container(
                          height: Get.height / 1,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Container(
                          height: Get.height / 1,
                          child: ListView.builder(
                              itemCount: questionList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: SizedBox(
                                width: Get.width,
                                child: Card(
                                elevation: 3,
                                child: Padding(
                                padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Title: ${questionList[index].title}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(height: 10,),
                                      Text("Description: ${questionList[index].question}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                    ),
                                  ),
                                ),
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                        caption: 'Edit',
                                        color: Colors.black45,
                                        icon: Icons.edit,
                                        onTap: () => {
                                          Get.to(EditQuestionPage(),
                                              arguments: questionList[index]
                                          )!.then((value) {
                                            setState((){
                                              getQuestionList();
                                            });
                                          })
                                        }),
                                    IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () => {
                                          TemplateRep().deleteQuestion(questionList[index].questionId).then((value) {
                                            getQuestionList();
                                          })
                                        }),
                                  ],);
                              }))
                ],
              )),
        ),
      ),
    );
  }

  _TestContainer() {
    return Visibility(
      visible: onclick == 3,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Container(
              color: AppColors.backgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Card(
                      elevation: 1,
                      color: Colors.blueGrey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text("List of Test",
                              style: StringsStyle.normaltextstyle),
                        ),
                      ),
                    ),
                  ),
                  isLoading1 == true
                      ? Container(
                          height: Get.height / 1,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Container(
                          height: Get.height / 1,
                          child: ListView.builder(
                              itemCount: testList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return  Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: SizedBox(
                                width: Get.width,
                                child: Card(
                                elevation: 3,
                                child: Padding(
                                padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Title: ${testList[index].test}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(height: 10,),
                                      Text("Description: ${testList[index].description}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                      ),
                                    ),
                                  ),
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                        caption: 'Edit',
                                        color: Colors.black45,
                                        icon: Icons.edit,
                                        onTap: () => {
                                          Get.to(EditTestPage(),
                                              arguments: testList[index]
                                          )!.then((value) {
                                            setState((){
                                              getTestList();
                                            });
                                          })
                                        }),
                                    IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () => {
                                          TemplateRep().deleteTest(testList[index].testId).then((value) {
                                            getTestList();
                                          })
                                        }),
                                  ],);
                              }))
                ],
              )),
        ),
      ),
    );
  }

  _diagnosisContainer() {
    return Visibility(
      visible: onclick == 4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Container(
              color: AppColors.backgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Card(
                      elevation: 1,
                      color: Colors.blueGrey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text("Ready Template",
                              style: StringsStyle.normaltextstyle),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                      itemCount: 20,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: Get.width,
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Center(
                                child: Text(
                                  "Acene",
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                ],
              )),
        ),
      ),
    );
  }
}
