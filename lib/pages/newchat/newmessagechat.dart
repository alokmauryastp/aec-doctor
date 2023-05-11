// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/chat_repo.dart';
import 'package:aec_medical_doctor/api/repository/templete_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/custom/green_custom_button.dart';
import 'package:aec_medical_doctor/model/AdviceModel.dart';
import 'package:aec_medical_doctor/model/question_assistant_model.dart';
import 'package:aec_medical_doctor/model/showquestion_model.dart';
import 'package:aec_medical_doctor/model/showtest_model.dart';
import 'package:aec_medical_doctor/pages/dashboard/FollowUp.dart';
import 'package:aec_medical_doctor/pages/dashboard/prescriptions/addNew_prescription_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:file/local.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';

class NewMessagesChat extends StatefulWidget {
  // String patientName;
  // NewMessagesChat(this.patientName);

  @override
  _NewMessagesChatState createState() {
    return _NewMessagesChatState();
  }
}

class _NewMessagesChatState extends State<NewMessagesChat> {
  bool isTyppingStart = false;
  bool show = false;
  bool _visibility = false;
  FocusNode focusNode = FocusNode();

  LocalFileSystem localFileSystem = LocalFileSystem();
  File filename;
  File newFile;
  PlatformFile file;
  var _enteredMessage = '', base64Image = '';
  final controller = new TextEditingController();
  final searchController = new TextEditingController();

  bool checkboxValueadvice = false;
  List<String> selectedadvices = [];
  List<AdviceDatum> advices = [];

  // List<AdviceDatum> template = [];
  bool isLoading = false;

  void getAdvice() async {
    advices.clear();
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
          advices.add(data);
        }
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  /// question ///////////////////////////////
  List<String> selectedquestions = [];
  List<QnDatum> questions = [];

  void getQuestion() async {
    questions.clear();
    setState(() {
      isLoading = true;
    });
    TemplateRep().getQuestionList().then((value) {
      print(value);
      if (value['status'] == 1) {
        print("success full");
        print(value);
        for (int i = 0; i < value['data'].length; i++) {
          QnDatum data = QnDatum.fromJson(value['data'][i]);
          questions.add(data);
        }
      } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  /// tests ///////////////////////////////////////////////////////////////
  List<String> selectedtests = [];
  List<TestDatum> testList = [];
  List<QuestionAssistantModel> questionAssistant = [];
  List<QuestionAssistantModel> _searchResult = [];

  void getQuestionAssistant() async {
    questionAssistant.clear();
    setState(() {
      isLoading = true;
    });

    TemplateRep().getQuestionAssistant().then((value) {
      print(value);
      // if (value['status'] == 1) {
      print("successfull");
      for (int i = 0; i < value.length; i++) {
        QuestionAssistantModel data = QuestionAssistantModel.fromJson(value[i]);
        questionAssistant.add(data);
        tempList.add(DropdownMenuItem(
          child: Text(data.question),
          value: data.question,
        ));
      }
      print(questionAssistant.length);
      // } else {}
      setState(() {
        isLoading = false;
      });
    });
  }

  void getTestList() async {
    testList.clear();
    setState(() {
      isLoading = true;
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
        isLoading = false;
      });
    });
  }

  void _sendMessage() async {
// String advice = await SharedPrefManager.getPrefrenceString(AppConstant.ADVICE);
    FocusScope.of(context).unfocus();
    setState(() {
      Provider.of<ChatRepo>(context, listen: false).saveDoctorChatMessageApi(
          controller.text, base64Image.isEmpty ? '' : base64Image);
      filename = null;
    });
    controller.clear();
  }

  void onFileOpen() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );
    if (result != null) {
      file = result.files.first;
      filename = File(file.path);

      setState(() {
        newFile = filename;
      });

      List<int> imageBytes = newFile.readAsBytesSync();
      base64Image = base64.encode(imageBytes);
    }
  }

  final List<DropdownMenuItem> tempList = [];
  String _selectTemp = '';

  @override
  void initState() {
    super.initState();
    getAdvice();
    getQuestion();
    getTestList();
    getQuestionAssistant();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 3),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          filename != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      Image.file(
                        filename,
                        width: MediaQuery.of(context).size.width - 15,
                        height: 250,
                        errorBuilder: (context, error, stackTrace) {
                          return Text("");
                        },
                      ),
                      Positioned(
                        right: 4,
                        top: 0,
                        child: Container(
                          alignment: Alignment.topRight,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: IconButton(
                              alignment: Alignment.center,
                              color: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  filename = null;
                                });
                              }),
                        ),
                      ),
                    ]),
                  ],
                )
              : SizedBox(
                  height: 0,
                ),
          SizedBox(
            height: 0,
          ),
          _botton(),
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 0, bottom: 4, right: 0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none),
                          controller: controller,
                          onChanged: (value) {
                            setState(() {
                              _enteredMessage = value;
                            });
                          },
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 50,
                        child: IconButton(
                          splashRadius: 0.1,
                          onPressed: () {
                            onFileOpen();
                            // openMyDialog();
                          },
                          icon: Icon(
                            Icons.attach_file_rounded,
                            color: Colors.grey,
                            size: 26,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: IconButton(
                              splashRadius: 0.1,
                              color: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.send_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: _sendMessage),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: IconButton(
                              splashRadius: 0.1,
                              alignment: Alignment.centerRight,
                              color: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.more_vert,
                                size: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                _showPopupMenu();
                                setState(() {
                                  _visibility
                                      ? _visibility = false
                                      : _visibility = false;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    questionAssistant.forEach((data) {
      if (data.question.contains(text) ||
          data.question.contains(text.capitalizeFirst)) _searchResult.add(data);
    });

    setState(() {});
  }

  _botton() {
    return Visibility(
      visible: _visibility,
      maintainAnimation: false,
      maintainState: true,
      replacement: SizedBox(),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      _visibility = false;
                    });

                    Get.to(
                      FollowUp(),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 90,
                    // height: 40,
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
                        AppColors.appbarbackgroundColor,
                        AppColors.appbarbackgroundColor,
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Text('Follow Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 10,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      _visibility = false;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 90,
                    // height: 40,
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
                        AppColors.appbarbackgroundColor,
                        AppColors.appbarbackgroundColor,
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Text('Template',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 10,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _visibility = false;
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return _Advices(
                              advice: advices,
                              selectedadvices: selectedadvices,
                              onSelectedAdviceListChanged: (advice) {
                                selectedadvices = advice;
                                print(selectedadvices);
                              });
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 75,
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
                        AppColors.appbarbackgroundColor,
                        AppColors.appbarbackgroundColor,
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Text('ADVICES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 10,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _visibility = false;
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Question(
                              question: questions,
                              selectedquestion: selectedquestions,
                              onSelectedQuestionListChanged: (question) {
                                selectedquestions = question;
                                print(selectedquestions);
                              });
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 75,
                    // height: 40,
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
                        AppColors.appbarbackgroundColor,
                        AppColors.appbarbackgroundColor,
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10),
                      child: Text('QUESTIONS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 10,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _visibility = false;
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Test(
                              test: testList,
                              selectedtest: selectedtests,
                              onSelectedTestListChanged: (question) {
                                selectedtests = question;
                                print(selectedtests);
                              });
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 75,
                    // height: 40,
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
                        AppColors.appbarbackgroundColor,
                        AppColors.appbarbackgroundColor,
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Text('TESTS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 10,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),

                /// PRESCRIPTION /////////////////////////////////////////
                InkWell(
                  onTap: () async {
                    setState(() {
                      _visibility = false;
                    });
                    String page = await SharedPrefManager.getPrefrenceString(
                        AppConstant.PATIENTAGE);
                    String pgender = await SharedPrefManager.getPrefrenceString(
                        AppConstant.PATIENTGENDER);
                    String pname = await SharedPrefManager.getPrefrenceString(
                        AppConstant.PATIENTNAME);
                    Get.to(
                      AddNewPrescriptionPage(pname, pgender, page),
                      transition: Transition.rightToLeftWithFade,
                    );

                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return Test(
                    //           test: testList,
                    //           selectedtest: selectedtests,
                    //           onSelectedTestListChanged: (question) {
                    //             selectedtests = question;
                    //             print(selectedtests);
                    //           });
                    //     });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 90,
                    // height: 40,
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
                        AppColors.appbarbackgroundColor,
                        AppColors.appbarbackgroundColor,
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Text('PRESCRIPTION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 10,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showTemplate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Template",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: AppColors.appbarbackgroundColor,
                          fontWeight: FontWeight.bold),
                    ),

                    // new Container(
                    //   color: Theme.of(context).primaryColor,
                    //   child: new Padding(
                    //     padding: const EdgeInsets.all(0.0),
                    //     child: new Card(
                    //       child: new ListTile(
                    //         leading: new Icon(Icons.search),
                    //         title: new TextField(
                    //           controller: searchController,
                    //           decoration: new InputDecoration(
                    //               hintText: 'Search', border: InputBorder.none),
                    //           onChanged: onSearchTextChanged,
                    //         ),
                    //         trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    //           searchController.clear();
                    //           onSearchTextChanged('');
                    //         },),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child:
                          // _searchResult.length != 0 || searchController.text.isNotEmpty ?

                          // ListView.builder(
                          //     padding: EdgeInsets.all(16),
                          //     reverse: false,
                          //     shrinkWrap: true,
                          //     itemCount: _searchResult.length,
                          //     itemBuilder: (context, index) {
                          //       return Padding(
                          //         padding: const EdgeInsets.all(5.0),
                          //         child: InkWell(
                          //             onTap: () {
                          //               setState(() {
                          //                 _selectTemp = _searchResult[index].question;
                          //               });
                          //             },
                          //             child: Column(
                          //               children: [
                          //                 Row(
                          //                   children: [
                          //                     Icon(Icons.circle_rounded,size: 10,),
                          //                     SizedBox(width: 10,),
                          //                     Expanded(
                          //                       child: Text(
                          //                         _searchResult[index].question,
                          //                         style: TextStyle(fontWeight: FontWeight.w800),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Divider(thickness: 1,)
                          //               ],
                          //             )),
                          //       );
                          //     }) :
                          ListView.builder(
                              padding: EdgeInsets.all(16),
                              reverse: false,
                              shrinkWrap: true,
                              itemCount: questionAssistant.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectTemp =
                                              questionAssistant[index].question;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.circle_rounded,
                                                size: 10,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  questionAssistant[index]
                                                      .question,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1,
                                          )
                                        ],
                                      )),
                                );
                              }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SearchChoices.single(
                            displayClearIcon: false,icon: Icon(Icons.search),
                            // validator: (value) {
                            //   return ((value?.length ?? 0) < 1 ? "" : null);
                            // },
                            underline: SizedBox(),
                            padding: 0,
                            items: tempList,
                            value: _selectTemp,
                            hint: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Template",
                                style: TextStyle(fontSize: 16, height: 3),
                              ),
                            ),
                            searchHint: "Search Template",
                            onChanged: (value) {
                              setState(() {
                                _selectTemp = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_selectTemp.isEmpty) {
                          Fluttertoast.showToast(msg: 'Select Template!');
                        } else {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                          setState(() {
                            Provider.of<ChatRepo>(context, listen: false)
                                .saveDoctorChatMessageApi(_selectTemp, '');
                            Fluttertoast.showToast(msg: 'Submitted!');
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 40,
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
                              AppColors.appbarbackgroundColor,
                              AppColors.appbarbackgroundColor,
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('Send',
                              style: TextStyle(
                                color: AppColors.whitetextColor,
                                fontSize: 15,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  showadvice() {
    showDialog(
        context: context,
        builder: (context) {
          return _Advices(
              advice: advices,
              selectedadvices: selectedadvices,
              onSelectedAdviceListChanged: (advice) {
                selectedadvices = advice;
                print(selectedadvices);
              });
        });
  }

  void _showPopupMenu() async {
    var size = MediaQuery.of(context).size;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(size.width, size.height - 365, 0, 0),
      useRootNavigator: true,
      items: [
        PopupMenuItem<int>(
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showTemplate();
                },
                child: const Text('Template')),
            value: 0),
        PopupMenuItem<int>(
            child: InkWell(
                onTap: () {
                  showadvice();
                },
                child: const Text('Advices')),
            value: 1),
        PopupMenuItem<int>(
            child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Question(
                            question: questions,
                            selectedquestion: selectedquestions,
                            onSelectedQuestionListChanged: (question) {
                              selectedquestions = question;
                              print(selectedquestions);
                            });
                      });
                },
                child: const Text('Questions')),
            value: 2),
        PopupMenuItem<int>(
            child: InkWell(
                onTap: () {
                  setState(() {
                    _visibility = false;
                  });
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Test(
                            test: testList,
                            selectedtest: selectedtests,
                            onSelectedTestListChanged: (question) {
                              selectedtests = question;
                              print(selectedtests);
                            });
                      });
                },
                child: const Text('Tests')),
            value: 3),
        PopupMenuItem<int>(
            onTap: () async {
              setState(() {
                _visibility = false;
              });
              String page = await SharedPrefManager.getPrefrenceString(
                  AppConstant.PATIENTAGE);
              String pgender = await SharedPrefManager.getPrefrenceString(
                  AppConstant.PATIENTGENDER);
              String pname = await SharedPrefManager.getPrefrenceString(
                  AppConstant.PATIENTNAME);
              Get.to(
                AddNewPrescriptionPage(pname, pgender, page),
                transition: Transition.rightToLeftWithFade,
              );
            },
            child: const Text('Prescription'),
            value: 5),
        PopupMenuItem<int>(
            child: InkWell(
                onTap: () {
                  Get.to(
                    FollowUp(),
                    transition: Transition.rightToLeftWithFade,
                  );

                  setState(() {
                    _visibility = false;
                  });
                },
                child: const Text('Follow Up')),
            value: 6),
      ],
      elevation: 8.0,
    );
  }

  void openMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Container(
                color: Colors.white,
                height: 200,
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  "test",
                  style: TextStyle(color: Colors.red),
                )));
      },
    );
  }
}

/// advices ////////////////////////////////////////////////////////////////////

class _Advices extends StatefulWidget {
  _Advices({
    this.advice,
    this.selectedadvices,
    this.onSelectedAdviceListChanged,
  });

  final List<AdviceDatum> advice;
  final List<String> selectedadvices;
  final ValueChanged<List<String>> onSelectedAdviceListChanged;

  @override
  __AdvicesState createState() => __AdvicesState();
}

class __AdvicesState extends State<_Advices> {
  List<String> _tempSelectedAdvices = [];

  void _sendMessage() async {
    String advice =
        await SharedPrefManager.getPrefrenceString(AppConstant.ADVICE);
    FocusScope.of(context).unfocus();
    setState(() {
      String replaceString = advice.replaceAll(new RegExp(r'[^\w\s]+'), '');
      Provider.of<ChatRepo>(context, listen: false)
          .saveDoctorChatMessageApi(replaceString, '');
    });
  }

  @override
  void initState() {
    _tempSelectedAdvices = widget.selectedadvices;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'ADVICES',
              style: TextStyle(
                  fontSize: 20.0,
                  color: AppColors.appbarbackgroundColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Select',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.advice.length,
                  itemBuilder: (BuildContext context, int index) {
                    AdviceDatum cityName = widget.advice[index];
                    return Container(
                      child: CheckboxListTile(
                          title: Text(cityName.description.toString()),
                          value: _tempSelectedAdvices.contains(cityName.title),
                          onChanged: (bool value) {
                            if (value) {
                              if (!_tempSelectedAdvices
                                  .contains(cityName.title)) {
                                setState(() {
                                  _tempSelectedAdvices
                                      .add(cityName.title.toString());
                                });
                              }
                            } else {
                              if (_tempSelectedAdvices
                                  .contains(cityName.title)) {
                                setState(() {
                                  _tempSelectedAdvices.removeWhere(
                                      (String city) => city == cityName.title);
                                });
                              }
                            }
                            widget.onSelectedAdviceListChanged(
                                _tempSelectedAdvices);
                          }),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                  child: InkWell(
                    onTap: () async {
                      await SharedPrefManager.savePrefString(
                          AppConstant.ADVICE, _tempSelectedAdvices.toString());
                      String advice =
                          await SharedPrefManager.getPrefrenceString(
                              AppConstant.ADVICE);
                      if (_tempSelectedAdvices.toList().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select then send",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black,
                            textColor: Colors.white);
                      } else {
                        Navigator.pop(context);
                        _sendMessage();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 40,
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
                          AppColors.appbarbackgroundColor,
                          AppColors.appbarbackgroundColor,
                        ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Send',
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Question ////////////////////////////////////////////////////////////////////

class Question extends StatefulWidget {
  Question({
    this.question,
    this.selectedquestion,
    this.onSelectedQuestionListChanged,
  });

  final List<QnDatum> question;
  final List<String> selectedquestion;
  final ValueChanged<List<String>> onSelectedQuestionListChanged;

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  List<String> _tempSelectedQuestion = [];

  void _sendMessage() async {
    String question =
        await SharedPrefManager.getPrefrenceString(AppConstant.QUESTION);
    FocusScope.of(context).unfocus();
    setState(() {
      String replaceString = question.replaceAll(new RegExp(r'[^\w\s]+'), '');
      Provider.of<ChatRepo>(context, listen: false)
          .saveDoctorChatMessageApi(replaceString, '');
    });
  }

  @override
  void initState() {
    _tempSelectedQuestion = widget.selectedquestion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'QUESTION',
              style: TextStyle(
                  fontSize: 20.0,
                  color: AppColors.appbarbackgroundColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Select',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.question.length,
                  itemBuilder: (BuildContext context, int index) {
                    QnDatum cityName = widget.question[index];
                    return Container(
                      child: CheckboxListTile(
                          title: Text(cityName.question.toString()),
                          value:
                              _tempSelectedQuestion.contains(cityName.question),
                          onChanged: (bool value) {
                            if (value) {
                              if (!_tempSelectedQuestion
                                  .contains(cityName.question)) {
                                setState(() {
                                  _tempSelectedQuestion
                                      .add(cityName.question.toString());
                                });
                              }
                            } else {
                              if (_tempSelectedQuestion
                                  .contains(cityName.question)) {
                                setState(() {
                                  _tempSelectedQuestion.removeWhere(
                                      (String city) =>
                                          city == cityName.question);
                                });
                              }
                            }
                            widget.onSelectedQuestionListChanged(
                                _tempSelectedQuestion);
                          }),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                  child: InkWell(
                    onTap: () async {
                      await SharedPrefManager.savePrefString(
                          AppConstant.QUESTION,
                          _tempSelectedQuestion.toString());
                      String advice =
                          await SharedPrefManager.getPrefrenceString(
                              AppConstant.QUESTION);
                      if (_tempSelectedQuestion.toList().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select then send",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black,
                            textColor: Colors.white);
                      } else {
                        await Navigator.pop(context);
                        _sendMessage();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 40,
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
                          AppColors.appbarbackgroundColor,
                          AppColors.appbarbackgroundColor,
                        ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Send',
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// tests ////////////////////////////////////////////////////////////////////

class Test extends StatefulWidget {
  Test({
    this.test,
    this.selectedtest,
    this.onSelectedTestListChanged,
  });

  final List<TestDatum> test;
  final List<String> selectedtest;
  final ValueChanged<List<String>> onSelectedTestListChanged;

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> _tempSelectedTest = [];

  void _sendMessage() async {
    String test = await SharedPrefManager.getPrefrenceString(AppConstant.TESTS);
    FocusScope.of(context).unfocus();
    setState(() {
      String replaceString = test.replaceAll(new RegExp(r'[^\w\s]+'), '');
      Provider.of<ChatRepo>(context, listen: false)
          .saveDoctorChatMessageApi(replaceString, '');
    });
  }

  @override
  void initState() {
    _tempSelectedTest = widget.selectedtest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Tests',
              style: TextStyle(
                  fontSize: 20.0,
                  color: AppColors.appbarbackgroundColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Select',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.test.length,
                  itemBuilder: (BuildContext context, int index) {
                    TestDatum cityName = widget.test[index];
                    return Container(
                      child: CheckboxListTile(
                          title: Text(cityName.test.toString()),
                          value: _tempSelectedTest.contains(cityName.test),
                          onChanged: (bool value) {
                            if (value) {
                              if (!_tempSelectedTest.contains(cityName.test)) {
                                setState(() {
                                  _tempSelectedTest
                                      .add(cityName.test.toString());
                                });
                              }
                            } else {
                              if (_tempSelectedTest.contains(cityName.test)) {
                                setState(() {
                                  _tempSelectedTest.removeWhere(
                                      (String city) => city == cityName.test);
                                });
                              }
                            }
                            widget.onSelectedTestListChanged(_tempSelectedTest);
                          }),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                  child: InkWell(
                    onTap: () async {
                      await SharedPrefManager.savePrefString(
                          AppConstant.TESTS, _tempSelectedTest.toString());
                      String advice =
                          await SharedPrefManager.getPrefrenceString(
                              AppConstant.QUESTION);
                      if (_tempSelectedTest.toList().isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select then send",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black,
                            textColor: Colors.white);
                      } else {
                        await Navigator.pop(context);
                        _sendMessage();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 40,
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
                          AppColors.appbarbackgroundColor,
                          AppColors.appbarbackgroundColor,
                        ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Send',
                          style: TextStyle(
                            color: AppColors.whitetextColor,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
