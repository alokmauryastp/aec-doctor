import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/model/counting_model.dart';
import 'package:aec_medical_doctor/model/earning_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../notification_page.dart';
import 'package:google_fonts/google_fonts.dart';

class EarningPage extends StatefulWidget {
  const EarningPage({Key? key}) : super(key: key);

  @override
  _EarningPageState createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  DateTime selectedDate = DateTime.now();
  var formatDate;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDate = selectedDate.year.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.day.toString();
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
      lastDate: DateTime(2035),
    );

    if (picked != null && picked != toselectedDate) {
      setState(() {
        toselectedDate = picked;
        toformatDate = toselectedDate.year.toString() +
            "/" +
            toselectedDate.month.toString() +
            "/" +
            toselectedDate.day.toString();
      });
    }
  }

  List<EarningData> earningData = [];

  late Future future;

  bool _isLoad = false;

  void _filterearning() {
    setState(() {
      _isLoad = true;
    });
    HomeRepo homeRepo = new HomeRepo();
    future = homeRepo.earninglistApi(formatDate, toformatDate);
    future.then((value) {
      setState(() {
        earningData = value;
      });
    });
    setState(() {
      _isLoad = false;
    });
  }

  List<CountingModel> countingModel = [];

  @override
  void initState() {
    super.initState();
    HomeRepo homeRepo = new HomeRepo();
    future = homeRepo.countingApi();
    future.then((value) {
      setState(() {
        countingModel = value;
        print("kktitle" + countingModel[0].data.amountPaid);
      });
    });
    _filterearning();
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
                    onTap: () {
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
        child: earningData.isEmpty
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                  // color: Colors.white,
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset("assets/images/noearning.jpg",width: Get.width,),
                  //     Text("Sorry! earning data not available .",style: TextStyle(fontSize: 20,
                  //         color: AppColors.appbarbackgroundColor,
                  //         fontWeight: FontWeight.bold),),
                  //   ],
                  // ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _heading(),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            _amountpaid(),
                            _amountpending(),
                            _completedconsultation(),
                            _totalconsultation(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _patientList(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _heading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:
                  Text(Strings.EARNING_HEADING, style: StringsStyle.heading)),
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
              if (_isLoad)
                CircularProgressIndicator()
              else
                InkWell(
                    onTap: () {
                      setState(() {
                        _filterearning();
                      });
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
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              fontFamily: GoogleFonts.lato().fontFamily
                            ),
                          ))),
                    )),
            ],
          ),
        ],
      ),
    );
  }

  _patientList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: earningData.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(earningData[index].user,
                        style: detailstyle),
                    Text("${Strings.RUPEES}${earningData[index].amount}",
                        style: _textStyle),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _amountpaid() {
    return Container(
      height: 50,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.AMOUNT_PAID,
              style: detailstyle,
            ),
            Text(
              "${Strings.RUPEES}${countingModel.isNull ? "0.0" : countingModel[0].data.amountPaid}",
              style: _textStyle,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle = TextStyle(
      color: Color(0xff366997),
      fontWeight: FontWeight.bold,
      fontSize: 15,
      fontFamily: GoogleFonts.lato().fontFamily,
      letterSpacing: 0.5);

  TextStyle detailstyle = TextStyle(
    color: AppColors.darktextColor,
    fontSize: 14,
    letterSpacing: 0.5,
    fontFamily: GoogleFonts.lato().fontFamily,
    fontWeight: FontWeight.w500,
  );

  _amountpending() {
    return Container(
      height: 40,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.AMOUNT_PENDING,
              style: detailstyle,
            ),
            Text(
              "${Strings.RUPEES}${(countingModel[0].data.amountPending).isNull ? "0.0" : countingModel[0].data.amountPending}",
              style: _textStyle,
            ),
          ],
        ),
      ),
    );
  }

  _completedconsultation() {
    return Container(
      height: 40,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.COMPLETE_CONSULTATION,
              style: detailstyle,
            ),
            Text(
              "${(countingModel[0].data.completeConsultation).isNull ? "0" : countingModel[0].data.completeConsultation}",
              style: _textStyle,
            ),
          ],
        ),
      ),
    );
  }

  _totalconsultation() {
    return Container(
      height: 50,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.TOTAL_CONSULTATION,
              style: detailstyle,
            ),
            Text(
              "${(countingModel[0].data.totalConsultation).isNull ? "0" : countingModel[0].data.totalConsultation}",
              style: _textStyle,
            ),
          ],
        ),
      ),
    );
  }

  // _date() {
  //   return Container(
  //       height: 30,
  //       width: 60,
  //       child: TextFormField(
  //         keyboardType: TextInputType.text,
  //         autovalidateMode: AutovalidateMode.onUserInteraction,
  //         textAlignVertical: TextAlignVertical.bottom,
  //         decoration: InputDecoration(
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //             borderSide:
  //                 BorderSide(color: AppColors.backgroundColor, width: 1),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //             borderSide:
  //                 BorderSide(color: AppColors.backgroundColor, width: 1),
  //           ),
  //           errorBorder: OutlineInputBorder(
  //               borderSide: new BorderSide(color: Colors.transparent, width: 1),
  //               borderRadius: BorderRadius.circular(10)),
  //           focusedErrorBorder: OutlineInputBorder(
  //               borderSide: new BorderSide(color: Colors.transparent, width: 1),
  //               borderRadius: BorderRadius.circular(10)),
  //           border: OutlineInputBorder(
  //               borderSide: new BorderSide(color: Colors.yellow, width: 1),
  //               borderRadius: BorderRadius.circular(10)),
  //           hintText: "Date",
  //           suffixIcon: PopupMenuButton<String>(
  //               onSelected: (value) {
  //                 // Get.snackbar(
  //                 //   "Changes saved with success",
  //                 //   "just now",
  //                 //   snackPosition: SnackPosition.BOTTOM,
  //                 //   colorText: AppColors.lighttextColor,
  //                 //   backgroundColor: AppColors.backgroundColor,
  //                 //   boxShadows: [
  //                 //     BoxShadow(
  //                 //       blurRadius: 1,
  //                 //       color: Colors.grey.shade200,
  //                 //       offset: Offset(0, 2),
  //                 //       spreadRadius: 2,
  //                 //     ),
  //                 //   ],
  //                 //   margin: EdgeInsets.all(15),
  //                 // );
  //               },
  //               icon: Icon(
  //                 Icons.keyboard_arrow_down_outlined,
  //                 color: AppColors.appbarbackgroundColor,
  //               ),
  //               itemBuilder: (BuildContext context) {
  //                 return [
  //                   PopupMenuItem(
  //                     child: Text("0-3 month"),
  //                     value: "",
  //                   ),
  //                   PopupMenuItem(
  //                     child: Text(
  //                       "3-6 month",
  //                     ),
  //                     value: "",
  //                   ),
  //                   PopupMenuItem(
  //                     child: Text(
  //                       "6-9 month",
  //                     ),
  //                     value: "",
  //                   ),
  //                   PopupMenuItem(
  //                     child: Text(
  //                       "9-12 month",
  //                     ),
  //                     value: "",
  //                   ),
  //                   PopupMenuItem(
  //                     child: Text(
  //                       "1-2 month",
  //                     ),
  //                     value: "",
  //                   ),
  //                   PopupMenuItem(
  //                     child: Text(
  //                       "2-3 month",
  //                     ),
  //                     value: "",
  //                   ),
  //                 ];
  //               }),
  //           hintStyle: TextStyle(
  //             color: AppColors.lighttextColor,
  //             fontSize: 14,
  //           ),
  //         ),
  //         validator: (value) {
  //           if (value!.trim().isEmpty) {
  //             return "Please, fill this!";
  //           }
  //           return null;
  //         },
  //       ));
  // }

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
        onTap: () => _selectDate(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(
                formatDate ?? "Date",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
      ),
    );
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
        onTap: () => _toselectDate(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(
                toformatDate ?? "Date",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
      ),
    );
  }
}
