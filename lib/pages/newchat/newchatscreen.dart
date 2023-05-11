// @dart=2.9
import 'dart:async';
import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/chat_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/model/chatModel/getchat_model.dart';
import 'package:aec_medical_doctor/pages/newchat/medicalhistory_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'newmessagebubble.dart';
import 'newmessagechat.dart';

class ChatScreenNew extends StatefulWidget {
  // final String name;
  // ChatScreenNew({this.name})

  @override
  _ChatScreenNewState createState() => _ChatScreenNewState();
}

class _ChatScreenNewState extends State<ChatScreenNew> {
  StreamController<List<GetChatData>> _controller =
  StreamController<List<GetChatData>>.broadcast();

  String patientName = Get.arguments;

  //AllPatientsData patientName1 = Get.arguments;

  var id;
  final controller = new TextEditingController();
  Timer timer;
  Future future;

  /*void userId() async{
    id = await SharedPrefManager.getPrefrenceString(AppConstant.USERID);
    print("idsssss"+id);
  }*/

  @override
  void initState() {
    super.initState();
    // stopconsultation();
    // loadDetails();
    // userId();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(Duration(seconds: 5), (_) => loadDetails());
    });
  }

  loadDetails() async {
    future = Provider.of<ChatRepo>(context, listen: false).getChatApi();
    future.then((response) async {
      _controller.add(response);
      return response;
    });
  }

  bool _isLoad = false;
  bool isSwitched2 = false;

  Future<void> toggleSwitch2() async {
    // if (!isSwitched2) {
    //   setState(() {
        await stopconsultation();
    //     isSwitched2 = true;
    //   });
    //   print('Switch Button is ON');
    // } else {
    //   setState(() {
    //     isSwitched2 = false;
    //   });
    //   print('Switch Button is OFF');
    // }
  }

  bool status = false;
  bool stopconsult = false;

  void _submit() {
    setState(() {
      _isLoad = true;
    });

    ChatRepo chatRepo = new ChatRepo();
    chatRepo.sendChatNotificationApi();
    _isLoad = false;
  }

  stopconsultation() {
    setState(() {
      _isLoad = true;
    });
    ChatRepo chatRepo = new ChatRepo();
    chatRepo.chatStatusApi();
    JitsiMeet.closeMeeting();
    Navigator.pop(context);
    _isLoad = false;
  }

  @override
  void dispose() {
    _controller.close();
    controller.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  support(){
    Get.bottomSheet(
      Container(
          height: 200,
          color: AppColors.backgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.contact_support_outlined,
                    size: 20,
                    color: AppColors.appbarbackgroundColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Contact us",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              Text(
                "For any Query connect\n with us",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.darktextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      _sendMail(
                          'apolloeclinic@gmail.com');
                    },
                    child: Container(
                      width: 120,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Mail us",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      _makePhoneCall('tel:9414600141');
                    },
                    child: Container(
                      width: 120,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Call us",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
      isDismissible: true,
      enableDrag: true,
    );
  }

  _jointMeetingAPI() {}

  _joinMeeting() async {
    // Fluttertoast.showToast(msg: 'join meet');

    String videourl =
    await SharedPrefManager.getPrefrenceString(AppConstant.VIDEOURL);
    ChatRepo chatRepo = new ChatRepo();
    chatRepo.sendCallNotificationApi(videourl);
    chatRepo.callingApi();

    String ptName =
    await SharedPrefManager.getPrefrenceString(AppConstant.PATIENTNAME);
    var ss = videourl.split('/');
    String room = ss.removeLast();
    String host = ss.last;

    try {

      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.CHAT_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false,
        FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
        FeatureFlagEnum.RECORDING_ENABLED: false,
        FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
        FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,

      };

      FeatureFlag featureFlag = new FeatureFlag();
      // featureFlag.

      if (!host.contains('http')) {
        host = 'https://' + host;
        print(host);
      }

      var options = JitsiMeetingOptions(room: room)
      // ..room = "myroom" // Required, spaces will be trimmed
        ..serverURL = host
        ..subject = "Meeting with $ptName"
        ..userDisplayName = ptName
        ..userEmail = "myemail@email.com"
        ..userAvatarURL = "https://someimageurl.com/image.jpg" // or .png
        ..audioOnly = true
        ..audioMuted = false
        ..videoMuted = true
        ..featureFlags = featureFlags;
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("joinMeetingerror:" + error);
      debugPrint("joinMeetingerror: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patientName.isNull ? "Chat" : patientName),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColors.appbarbackgroundColor,
        actions: [
          if (patientName != "Chat")
            InkWell(
                onTap: () async {
                  _joinMeeting();
                  // if (await canLaunch(videourl)) {
                  //   if (!videourl.contains('http')) videourl = 'https://$videourl';
                  //
                  //   await launch(videourl, forceWebView: true ,enableJavaScript: true);
                  // } else {
                  //   throw 'Could not launch $videourl';
                  // }
                },
                child: Icon(Icons.call)),
          SizedBox(width: 15,),
          if (patientName != "Chat")
            PopupMenuButton<int>(
              color: Colors.white,
              itemBuilder: (context) =>
              [
                PopupMenuItem(child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return patientName == "Chat"
                        ? SizedBox()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                            scale: 1,
                            child: SizedBox(width: 35,
                              child: Switch(
                                // onChanged: toggleSwitch2,
                                onChanged: (bool value) {
                                  print("Switch Button");
                                  print(value);
                                  setState(() {
                                    isSwitched2 = value;
                                  });
                                  toggleSwitch2();
                                },
                                value: isSwitched2,
                                activeColor: Colors.blue,
                                activeTrackColor: Colors.blue,
                                inactiveThumbColor: Colors.black87,
                                inactiveTrackColor: Colors.black87,
                              ),
                            )),
                        SizedBox(width: 10,),
                        Text(
                          "Complete Consult",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    );
                  },)),

                PopupMenuItem<int>(
                    value: 2,
                    child: patientName == "Chat"
                        ? SizedBox()
                        : InkWell(
                      onTap: () {
                        Get.to(
                          MedicalHistoryPage(),
                          transition: Transition.rightToLeftWithFade,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.history,
                            size: 35,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Medical History",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )),
                PopupMenuItem<int>(
                    value: 3,
                    child: patientName == "Chat"
                        ? SizedBox()
                        : InkWell(
                      onTap: () async {
                        _submit();
                        status = status ? true : true;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          status
                              ? Icon(
                            Icons.notifications,
                            size: 35,
                            color: Colors.blue,
                          )
                              : Icon(
                            Icons.notifications,
                            size: 35,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Notify to User",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )),
                PopupMenuItem<int>(
                    value: 4,
                    child: patientName == "Chat"
                        ? SizedBox()
                        : InkWell(
                      onTap: () async {

                        Navigator.pop(context);

                        support();

                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return Dialog(
                        //         child: Container(
                        //           height: 200,
                        //           child: Padding(
                        //             padding:
                        //             const EdgeInsets.only(left: 18.0),
                        //             child: Column(
                        //               mainAxisAlignment:
                        //               MainAxisAlignment.center,
                        //               children: [
                        //                 InkWell(
                        //                   onTap: () {
                        //                     _makePhoneCall('tel:9414600141');
                        //                   },
                        //                   child: Row(
                        //                     children: [
                        //                       IconButton(
                        //                           onPressed: () {},
                        //                           icon: Icon(
                        //                             Icons.call,
                        //                             size: 40,
                        //                             color: Colors.blueAccent,
                        //                           )),
                        //                       Text(
                        //                         "   Call",
                        //                         style: TextStyle(
                        //                             letterSpacing: 1,
                        //                             fontSize: 20,
                        //                             fontWeight:
                        //                             FontWeight.w500),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 InkWell(
                        //                   onTap: () {
                        //                     _sendMail(
                        //                         'apolloeclinic@gmail.com');
                        //                   },
                        //                   child: Row(
                        //                     children: [
                        //                       IconButton(
                        //                           onPressed: () {},
                        //                           icon: Icon(
                        //                             Icons.email,
                        //                             size: 40,
                        //                             color: Colors.blueAccent,
                        //                           )),
                        //                       Text(
                        //                         "   Email",
                        //                         style: TextStyle(
                        //                             letterSpacing: 1,
                        //                             fontSize: 20,
                        //                             fontWeight:
                        //                             FontWeight.w500),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.support,
                            size: 35,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Support",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )),
                PopupMenuItem<int>(
                    value: 4,
                    child: patientName == "Chat"
                        ? SizedBox()
                        : InkWell(
                      onTap: () async {
                        loadDetails();
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 35,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Refresh     ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
        ],
      ),
      body: Container(color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: Provider.of<ChatRepo>(context).getChatApi(),
                builder: (ctx, futureSnapShots) {
                  if (futureSnapShots.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (futureSnapShots.hasData) {
                      return StreamBuilder(
                        stream: _controller.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<GetChatData>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Center(
                                child: Text('None'),
                              );
                              break;
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                              break;
                            case ConnectionState.active:
                              List<GetChatData> responseChat = snapshot.data;
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    reverse: false,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (ctx, index) =>
                                        NewMessageBubble(
                                            responseChat[index].message,
                                            responseChat[index].user,
                                            responseChat[index].userType,
                                            responseChat[index].patientName,
                                            responseChat[index]
                                                .image
                                                .toString(),
                                            responseChat[index].time,
                                            responseChat[index].ago,
                                            responseChat[index].doctor));
                              }
                              debugPrint('dataForConsole: Hello');

                              break;
                            case ConnectionState.done:
                              print('Done data is here ${snapshot.data}');
                              if (snapshot.hasData) {
                                return Center(
                                    child: Text("No messages are available"));
                              } else if (snapshot.hasError) {
                                return Text('Has Error');
                              } else {
                                return Text('Error');
                              }
                              break;
                          }
                          return Text('Non in Switch');
                        },
                      );
                    } else {
                      return Text("s");
                      return Center(
                        child: Text(
                          "No messages are there",
                          style: TextStyle(
                              fontFamily: "Proxima Nova",
                              fontWeight: FontWeight.w600,
                              fontSize:
                              20 * MediaQuery
                                  .of(context)
                                  .textScaleFactor),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            if (patientName == "Chat") SizedBox() else
              NewMessagesChat(),
          ],
        ),
      ),
    );
  }


  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendMail(email) async {
    // Android and iOS
    var uri = 'mailto:' + email + '?subject=hello&body=Hello';
    print('mailto: $email ?subject=hello&body=Hello');
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      Fluttertoast.showToast(
        msg: "Can't Launch!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      throw 'Could not launch $uri';
    }
  }
}
