import 'package:aec_medical_doctor/pages/dashboard/apps/patients/doctorchat_folder/normalchat_card.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/patients/patientchat_folder/chooseoption_card.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/patients/patientchat_folder/normaltext_card.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/patients/patientchat_folder/textfield_card.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

class ChatWithPatientPage extends StatefulWidget {
  const ChatWithPatientPage({Key? key}) : super(key: key);

  @override
  _ChatWithPatientPageState createState() => _ChatWithPatientPageState();
}

class _ChatWithPatientPageState extends State<ChatWithPatientPage> {
  bool isTyppingStart = false;
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        centerTitle: false,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Patient Name",
                  style: TextStyle(
                      color: AppColors.whitetextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
              SizedBox(height: 5),
              Text("Age 26, Male, id: 157895",
                  style: TextStyle(
                      color: AppColors.whitetextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 13)),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                BottomSheet(context);
              },
              icon: Icon(Icons.ac_unit, color: AppColors.whitetextColor)),
          PopupMenuButton<String>(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Action"),
                value: "Action",
              ),
              PopupMenuItem(
                child: Text(
                  "Report issues",
                ),
                value: "Report",
              ),
            ];
          }),
        ],
      ),
      body: Container(
          color: AppColors.backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WillPopScope(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 150,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        NormalTextCard(),
                        SizedBox(height: 5),
                        TextFieldCard(),
                        SizedBox(height: 5),
                        ChooseOptionCard(),
                        SizedBox(height: 5),
                        NormalChatCard(),
                        SizedBox(height: 5),
                        NormalChatCard(),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 57,
                            child: Card(
                                margin: EdgeInsets.fromLTRB(3, 0, 3, 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      isTyppingStart =
                                          val.length > 0 ? true : false;
                                    });
                                  },
                                  controller: _controller,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type your message here...",
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.lighttextColor),
                                    contentPadding: EdgeInsets.only(left: 15),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: IconButton(
                                          icon: Icon(Icons.attach_file,
                                              color: Colors.grey),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (builder) =>
                                                    bottomsheet());
                                          }),
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 5, 8),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.deepPurple[800],
                              child: Center(
                                child: Icon(
                                    isTyppingStart ? Icons.send : Icons.mic,
                                    color: Colors.white,
                                    size: 23),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // show ? emojiselect() : Container(),
                    ],
                  ),
                ),
              ],
            ),
            onWillPop: () {
              if (show) {
                setState(() {
                  show = false;
                });
              } else {
                Navigator.pop(context);
              }
              return Future.value(false);
            },
          )),
    );
  }

  Widget bottomsheet() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 15,
      child: Card(
          margin: EdgeInsets.all(18),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: InkWell(
              // splashColor: Colors.deepPurple,
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        color: Colors.black,
                      ),
                      SizedBox(height: 5),
                      Text(
                        " Documentation",
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.insert_photo,
                        color: Colors.black,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Gallary",
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Camera",
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                  // iconcreation(Icons.insert_photo, Colors.purple, "Gallery"),
                  // iconcreation(
                  //     Icons.picture_as_pdf_sharp, Colors.blueGrey, "Documents"),
                  // iconcreation(
                  //     Icons.camera_alt, Colors.deepOrangeAccent, "Camera"),
                ],
              ),
            ),
          )),
    );
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return Column(children: [
      CircleAvatar(
        backgroundColor: color,
        radius: 10,
        child: Icon(icon, size: 29, color: Colors.white),
      ),
      SizedBox(height: 5),
      Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
    ]);
  }

  Future<dynamic> BottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        elevation: 0,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  child: Wrap(children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: AppColors.appbarbackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.call,
                                    color: AppColors.whitetextColor, size: 15),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Call Now",
                                    style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: AppColors.appbarbackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.video_call,
                                    size: 15, color: AppColors.whitetextColor),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Call Now",
                                    style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: AppColors.appbarbackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.call,
                                    color: AppColors.whitetextColor, size: 15),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Set a Schedule",
                                    style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: AppColors.appbarbackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.chat_rounded,
                                    size: 15, color: AppColors.whitetextColor),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Patient chat request",
                                    style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: AppColors.appbarbackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.chat,
                                    size: 15, color: AppColors.whitetextColor),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Send Prescript",
                                    style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: AppColors.appbarbackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.note_alt_outlined,
                                    size: 15, color: AppColors.whitetextColor),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Report issue / drop",
                                    style: TextStyle(
                                        color: AppColors.whitetextColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(color: AppColors.appbarbackgroundColor, height: 2),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: AppColors.appbarbackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_note_outlined,
                                size: 15, color: AppColors.whitetextColor),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Patient needs call later - reschdule",
                                style: TextStyle(
                                    color: AppColors.whitetextColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: AppColors.appbarbackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_note_outlined,
                                size: 15, color: AppColors.whitetextColor),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Ask for reports - Auto schdule",
                                style: TextStyle(
                                    color: AppColors.whitetextColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: AppColors.appbarbackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_note_outlined,
                                size: 15, color: AppColors.whitetextColor),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Patient not responding - Auto schdule",
                                style: TextStyle(
                                    color: AppColors.whitetextColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ])));
        });
  }
}
