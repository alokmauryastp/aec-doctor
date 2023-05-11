import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/model/notification_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  List<NotificationsData> notificationData = [];


  @override
  void initState() {
    super.initState();
    HomeRepo homeRepo = new HomeRepo();
    Future future = homeRepo.notificationApi();
    future.then((value) {
      setState(() {
        notificationData = value;
        print("kktitle" + notificationData[0].message);
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
       //title: Text("Notifications", style: StringsStyle.pagetitlestyle,),
        title: Image.asset(
          "assets/images/logo.png",
          height: 30,
          width: 30,
        ),
      ),
      body: notificationData.isEmpty?Container(
        color: Colors.white,
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          Image.asset("assets/images/nonotification.jpg",width: Get.width,),
          Text("You have not receive any notification",style: TextStyle(fontSize: 20,
              color: AppColors.appbarbackgroundColor,
              fontWeight: FontWeight.bold),),
         ],
        ),
      ):SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
              itemCount: notificationData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                    elevation: 3,
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.red[50],
                                child:  Image.asset("assets/images/logo.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(notificationData[index].title, style: StringsStyle.headingstyle),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      width: Get.width - 100,
                                      child: Text(notificationData[index].message,
                                        style: TextStyle(fontSize: 13),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width - 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${notificationData[index].date} ${notificationData[index].time}",
                                              style: TextStyle(fontSize: 10)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ])));
              },
            ),
          )),
    );
  }
}
