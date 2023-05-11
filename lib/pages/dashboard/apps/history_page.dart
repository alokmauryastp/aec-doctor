import 'package:aec_medical_doctor/api/AppConstant.dart';
import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/api/sharedprefrence.dart';
import 'package:aec_medical_doctor/model/allpatients_model.dart';
import 'package:aec_medical_doctor/pages/newchat/newchatscreen.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../notification_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {


  DateTime selectedDate = DateTime.now();
  var formatDate;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),);

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDate = selectedDate.year.toString() + "/"+selectedDate.month.toString() + "/" +selectedDate.day.toString();
      });
    }
  }

  DateTime toselectedDate = DateTime.now();
  var toformatDate;

  _toselectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toselectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),);

    if (picked != null && picked != toselectedDate) {
      setState(() {
        toselectedDate = picked;
        toformatDate = toselectedDate.year.toString() + "/"+toselectedDate.month.toString() + "/" +toselectedDate.day.toString();
      });
    }
  }


  List<AllPatientsData> allPatientsData = [];

  bool _isLoad = false;

  void _filterhistory(){
    setState(() {
      _isLoad = true;
    });
    HomeRepo homeRepo = new HomeRepo();
    Future future = homeRepo.allPatientApi(formatDate, toformatDate);
    future.then((value) {
      setState(() {
        allPatientsData = value;
        // print("kktitle" + allPatientsData[0].patientName);
      });
    });
    setState(() {
      _isLoad = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filterhistory();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appbarbackgroundColor,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.apps,
                      size: 30,
                    ),
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 30,
                    width: 30,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(NotificationPage(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(milliseconds: 600));
                    },
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: allPatientsData.isNull? Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/nohistory.jpeg",width: Get.width,),
              Text("Sorry! history data not available .",style: TextStyle(fontSize: 20,
                  color: AppColors.appbarbackgroundColor,
                  fontWeight: FontWeight.bold),),
            ],
          ),
        ):SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _details(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 2,
                  color: AppColors.appbarbackgroundColor,
                ),
                SizedBox(
                  height: 20,
                ),
                _patientList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _details() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text("History",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: AppColors.appbarbackgroundColor,
                letterSpacing: 0.5,
              )),
          SizedBox(
            height: 20,
          ),
          Text("Click here to select week"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "From",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  _fromdate(),
                  SizedBox(
                    width: 5,
                  ),
                  Text("To"),
                  SizedBox(
                    width: 5,
                  ),
                  _todate(),
                ],
              ),
              if(_isLoad)CircularProgressIndicator()
              else  InkWell(
                  onTap: () {
                    _filterhistory();
                  },
                  child: Center(
                    child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.black26,
                              Colors.black87,
                              // Colors.red.shade500,
                              // AppColors.redColor,
                            ]),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold,
                                  letterSpacing: 0.5,
                                  fontFamily: GoogleFonts.lato().fontFamily
                              ),
                            ))),
                  )),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       "From",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     _date(),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Text("To"),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     _date(),
          //   ],
          // ),
        ],
      ),
    );
  }

  _patientList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: allPatientsData.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 5,
            child: InkWell(onTap: () async {
              await SharedPrefManager.savePrefString(
                  AppConstant.CONSULTID,
                  allPatientsData[index].consultId);
              Get.to(
                ChatScreenNew(),
                arguments: "Chat",
                transition: Transition.rightToLeftWithFade,
              );

            },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Consult Id :  #${allPatientsData[index].consultId}",
                            style: TextStyle(
                              color: AppColors.lighttextColor,
                              fontSize: 13,
                              letterSpacing: 0.5,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5,),
                        Text("Patient : ${allPatientsData[index].patientName}",
                            style: detailStyle),

                      ],),

                      Text("Paid",
                          style: _textStyle),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }


  TextStyle detailStyle = TextStyle(
    color: AppColors.darktextColor,
    fontSize: 14,
    letterSpacing: 0.5,
    fontFamily: GoogleFonts.lato().fontFamily,
    fontWeight: FontWeight.bold,
  );


  TextStyle _textStyle = TextStyle(
      color: Color(0xff366997),
      fontWeight: FontWeight.bold,
      fontSize: 15,
      fontFamily: GoogleFonts.lato().fontFamily,
      letterSpacing: 0.5);

  _fromdate() {
    return Container(
      height: 35,
      // width: 100,
      padding: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: AppColors.whitetextColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(3, 3))
        ],
      ),
      child: GestureDetector(
        onTap:()=> _selectDate(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(formatDate ?? "Date",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54
                ),),
            ),
            const Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
      ),);
  }

  _todate() {
    return Container(
      height: 35,
      // width: 100,
      padding: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: AppColors.whitetextColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(3, 3))
        ],
      ),
      child: GestureDetector(
        onTap:()=> _toselectDate(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(toformatDate ?? "Date",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54
                ),),
            ),
            const Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
      ),);
  }


  _date() {
    return Container(
        height: 30,
        width: 60,
        decoration: BoxDecoration(
          color: AppColors.whitetextColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(3, 3))
          ],
        ),
        child: Center(
          child: TextFormField(
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                  borderSide:
                  new BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                  new BorderSide(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              hintText: "Date",
              suffixIcon: PopupMenuButton<String>(
                  onSelected: (value) {
                    // Get.snackbar(
                    //   "Changes saved with success",
                    //   "just now",
                    //   snackPosition: SnackPosition.BOTTOM,
                    //   colorText: AppColors.lighttextColor,
                    //   backgroundColor: AppColors.backgroundColor,
                    //   boxShadows: [
                    //     BoxShadow(
                    //       blurRadius: 1,
                    //       color: Colors.grey.shade200,
                    //       offset: Offset(0, 2),
                    //       spreadRadius: 2,
                    //     ),
                    //   ],
                    //   margin: EdgeInsets.all(15),
                    // );
                  },
                  // icon: Icon(
                  //   Icons.keyboard_arrow_down_outlined,
                  //   color: AppColors.appbarbackgroundColor,
                  // ),
                  child: Center(child: Text("Date")),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text("0-3 month"),
                        value: "",
                      ),
                      PopupMenuItem(
                        child: Text(
                          "3-6 month",
                        ),
                        value: "",
                      ),
                      PopupMenuItem(
                        child: Text(
                          "6-9 month",
                        ),
                        value: "",
                      ),
                      PopupMenuItem(
                        child: Text(
                          "9-12 month",
                        ),
                        value: "",
                      ),
                      PopupMenuItem(
                        child: Text(
                          "1-2 month",
                        ),
                        value: "",
                      ),
                      PopupMenuItem(
                        child: Text(
                          "2-3 month",
                        ),
                        value: "",
                      ),
                    ];
                  }),
              hintStyle: TextStyle(
                color: AppColors.lighttextColor,
                fontSize: 14,
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please, fill this!";
              }
              return null;
            },
          ),
        ));
  }
}
