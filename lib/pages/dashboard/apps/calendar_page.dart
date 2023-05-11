import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 100, 30, 20),
                child: Center(
                    child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                          height: 45,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: AppColors.appbarbackgroundColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Center(
                            child: Text("August",
                                style: TextStyle(
                                    color: AppColors.whitetextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          )),
                      SizedBox(height: 5),
                      TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        pageAnimationCurve: Curves.bounceInOut,
                        headerVisible: false,
                        focusedDay: DateTime.now(),
                      )
                    ],
                  ),
                )),
              ),
              Bounce(
                  duration: Duration(milliseconds: 110),
                  //onPressed: _trySubmit,
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: AppColors.lighttextColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3))
                        ]),
                    child: Center(
                        child: Icon(Icons.clear,
                            size: 35, color: AppColors.whitetextColor)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
