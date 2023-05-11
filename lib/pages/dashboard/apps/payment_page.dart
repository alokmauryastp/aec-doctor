// import 'package:aec_medical/api/repository/courses_repo.dart';
// import 'package:aec_medical/model/courseModel/mycoursesModel/mycourses_model.dart';
// import 'package:aec_medical/utils/colors.dart';
// import 'package:aec_medical/utils/strings.dart';
// import 'package:aec_medical/utils/strings_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class MyCoursesPage extends StatefulWidget {
//   const MyCoursesPage({Key? key}) : super(key: key);
//
//   @override
//   _MyCoursesPageState createState() => _MyCoursesPageState();
// }
//
// class _MyCoursesPageState extends State<MyCoursesPage>
//   with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   late List<MyCoursesData> myCoursesData = [];
//
//   @override
//   void initState() {
//   _tabController = TabController(length: 3, vsync: this);
//   CoursesRepo coursesRepo = new CoursesRepo();
//   Future future1 = coursesRepo.mycoursesApi();
//   future1.then((value){
//     setState(() {
//       myCoursesData = value;
//       print("ssssymptoms"+myCoursesData[0].title);
//     });
//   });
//   super.initState();
//   }
//
//   @override
//   void dispose() {
//   super.dispose();
//   _tabController.dispose();
//   }
//   var CategoryName = [
//     "For Relationship",
//     "Kids related issues",
//     "Pregnency",
//     "Psychological",
//     "Motivational",
//     "Loneliness",
//     "Suicidal Thoughts",
//     "Feeligs of anger",
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.appbarbackgroundColor,
//           centerTitle: true,
//           title: Text(
//             Strings.MYCOURSEPAGE,
//             style: StringsStyle.pagetitlestyle,
//           ),
//           leading: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: Icon(Icons.keyboard_arrow_left_outlined, size: 30)),
//         ),
//         body: SafeArea(
//           child: Padding(
//           padding: const EdgeInsets.only(top: 50),
//           child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           if(myCoursesData.isEmpty)
//             Center(child: CircularProgressIndicator())
//             else Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Text("My Courses",
//             style: TextStyle(
//             color: Color(0XFF005B5C),
//             fontSize: 25,
//             fontWeight: FontWeight.bold
//             ),),
//           ),
//           SizedBox(height: 20,),
//           Container(
//             padding: EdgeInsets.only(right: 30),
//           child: TabBar(
//             indicatorWeight: 3,
//             indicatorColor: Color(0XFF005B5C),
//           indicatorSize: TabBarIndicatorSize.label,
//           controller: _tabController,
//           labelColor: Color(0XFF005B5C),
//           unselectedLabelColor: Colors.grey,
//           tabs: [
//           Tab(
//           text: 'All',
//           ),
//           Tab(
//           text: 'Ongoing',
//           ),
//           Tab(
//           text: 'Completed',
//           ),
//           ],
//           ),
//           ),
//           // tab bar view here
//           Expanded(
//           child: TabBarView(
//           controller: _tabController,
//           children: [
//           // first tab bar view widget
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SingleChildScrollView(
//                 child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 5.0,
//                       mainAxisSpacing: 5.0,
//                       childAspectRatio: 1,
//                     ),
//                     itemCount: myCoursesData.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         color: Colors.white,
//                         elevation: 5,
//                         child: InkWell(
//                           splashColor: AppColors.appbarbackgroundColor,
//                           onTap: () {
//                             // Get.to(CounsellingDetailPage(),
//                             //     transition: Transition.rightToLeftWithFade,
//                             //     duration: Duration(milliseconds: 600));
//                           },
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Container(
//                                   height: 60, width: 60,
//                                   child: Image.network(myCoursesData[index].image),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(myCoursesData[index].name,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontSize: 12))
//                               ]),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//
//           // second tab bar view widget
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SingleChildScrollView(
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: CategoryName.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           color: Colors.white,
//                           elevation: 5,
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 60, width: 60,
//                                 child: Image.asset("assets/images/step1.png"),
//                               ),
//                               SizedBox(width: 10,),
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                      Column(
//                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                        children: [
//                                          Padding(
//                                            padding: const EdgeInsets.symmetric(vertical: 15),
//                                            child: Text("Course Name",
//                                                style: TextStyle(
//                                                    color: AppColors.appbarbackgroundColor,
//                                                    fontSize: 17,
//                                                    fontWeight: FontWeight.bold)),
//                                          ),
//                                          Text("Duration: 3 months",
//                                              style: TextStyle(
//                                                  color: Colors.grey,
//                                                  fontSize: 15,
//                                                  fontWeight: FontWeight.bold)),
//                                          SizedBox(height: 20,),
//                                        ],
//                                      ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 0),
//                                             child: Text("From 01/jun/2021",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 10),
//                                             child: Text("To 01/Aug/2021",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           SizedBox(height: 20,),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                  Padding(
//                                    padding: const EdgeInsets.only(bottom: 20),
//                                    child: Card(
//                                      shape: RoundedRectangleBorder(
//                                        borderRadius: BorderRadius.circular(10.0),
//                                      ),
//                                      color: Color(0XFF005B5C),
//                                      elevation: 5,
//                                      child: Container(
//                                        height: 15,
//                                        width: 240,
//                                      ),
//                                    ),
//                                  )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SingleChildScrollView(
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: CategoryName.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           color: Colors.white,
//                           elevation: 5,
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 60, width: 60,
//                                 child: Image.asset("assets/images/step1.png"),
//                               ),
//                               SizedBox(width: 10,),
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(vertical: 15),
//                                             child: Text("Course Name",
//                                                 style: TextStyle(
//                                                     color: AppColors.appbarbackgroundColor,
//                                                     fontSize: 17,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           Text("Duration: 3 months",
//                                               style: TextStyle(
//                                                   color: Colors.grey,
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.bold)),
//                                           SizedBox(height: 20,),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 0),
//                                             child: Text("From 01/jun/2021",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 10),
//                                             child: Text("To 01/Aug/2021",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                           ),
//                                           SizedBox(height: 20,),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 20),
//                                     child: Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10.0),
//                                       ),
//                                       color: Color(0XFF005B5C),
//                                       elevation: 5,
//                                       child: Container(
//                                         height: 15,
//                                         width: 240,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//           ],
//           ),
//           ),
//           ],
//           ),
//           ),
//         ),
//           );
//   }
// }
import 'package:aec_medical_doctor/api/repository/home_repo.dart';
import 'package:aec_medical_doctor/model/completePayment_model.dart';
import 'package:aec_medical_doctor/model/paymentsDetailmodel.dart';
import 'package:aec_medical_doctor/pages/dashboard/notification_page.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with SingleTickerProviderStateMixin {
  bool isloading=false;
  late List<CompletePaymentData> completePaymentData = [];

  late List<PaymentDetailsData> paymentDetailsData = [];
  var _index = 0;


  @override
  void initState() {
    setState(() {
      isloading=true;
    });
    HomeRepo homeRepo = new HomeRepo();
    Future future = homeRepo.completePaymentApi("","");
    future.then((value){
      setState(() {
        completePaymentData = value;
        isloading=false;
      });
    });
    Future future1 = homeRepo.paymentDetailsApi("2021/07/01","2022/12/31");
    future1.then((value){
      setState(() {
        paymentDetailsData = value;
        isloading=false;
      });
      print(paymentDetailsData.length);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appbarbackgroundColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.apps, size: 30)),
          centerTitle: true,
          actions: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30,),
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.whitetextColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        _heading(),
                        SizedBox(height: 20),
                        // _searchbox(),
                      ]),
                ),
              ),
              SizedBox(height: 2),
              _listview(),
              SizedBox(height: 30),
            ],
          ),
        ));
  }

  _heading() {
    return Container(
        width: Get.width,
        child: Text("CompletePayment/PaymentDetail",
            style: TextStyle(
            color: AppColors.appbarbackgroundColor,
            fontSize: 20,
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.justify,
        ));
  }


  activeStyle() {
    return TextStyle(
      color: AppColors.whitetextColor,
      fontSize: 15,
      letterSpacing: 0.2,
      fontWeight: FontWeight.bold,
    );
  }

  inactiveStyle() {
    return TextStyle(color: Theme.of(context).primaryColorDark);
  }

  BoxDecoration myBoxinActive() {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
      ),
    );
  }

  BoxDecoration myBoxActive() {
    return BoxDecoration(
      color: Theme.of(context).primaryColorDark,
      border: Border.all(color: Theme.of(context).primaryColorDark, width: 1),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
      ),
    );
  }

  _listview() {
    return Container(
        color: AppColors.whitetextColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                          splashColor: AppColors.appbarbackgroundColor,
                          onTap: () {
                            setState(() {
                              _index = 0;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: _index == 0 ? myBoxActive() : myBoxinActive(),
                            child: _index == 0
                                ? Text("Complete Payment",
                                textAlign: TextAlign.center,
                                style: activeStyle())
                                : Text("Complete Payment",
                                textAlign: TextAlign.center,
                                style: inactiveStyle()),
                          )),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        alignment: Alignment.center,
                        child: InkWell(
                            splashColor: AppColors.appbarbackgroundColor,
                            onTap: () {
                              setState(() {
                                _index = 1;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: _index == 1 ? myBoxActive() : myBoxinActive(),
                              child: _index == 1
                                  ? Text("Payment Details",
                                  textAlign: TextAlign.center,
                                  style: activeStyle())
                                  : Text("Payment Details",
                                  textAlign:TextAlign.center,
                                  style: inactiveStyle()),
                            )),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            if(completePaymentData.isNull)
              Visibility(
                visible: _index == 0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Image.asset("assets/images/notcounselling.jpg",width: Get.width,),
                      Text("Sorry! Complete Payment not available.",style: TextStyle(fontSize: 20,
                          color: AppColors.appbarbackgroundColor,
                          fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              )
            else  if(completePaymentData.isEmpty)
              Center(child: CircularProgressIndicator())
            else Visibility(
                  visible: _index == 0,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        child:  ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: completePaymentData.length,
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
                                        Text(completePaymentData[index].patient,
                                            style: TextStyle(
                                                color: AppColors.darktextColor,
                                                fontWeight: FontWeight.w500)),
                                        Text("Rs. ${completePaymentData[index].amount}",
                                            style: TextStyle(
                                                color: AppColors.darktextColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                  )),
            if(paymentDetailsData.isNull)
              Visibility(
                  visible: _index == 1,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset("assets/images/notcounselling.jpg",width: Get.width,),
                        Text("Sorry! Payment Details not available.",style: TextStyle(fontSize: 20,
                            color: AppColors.appbarbackgroundColor,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )
              )
            else  if(paymentDetailsData.isEmpty)
              Text("")
            else Visibility(
                  visible: _index == 1,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        child:  ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: paymentDetailsData.length,
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
                                        Text("Payment Id: "+paymentDetailsData[index].paymentId,
                                            style: TextStyle(
                                                color: AppColors.darktextColor,
                                                fontWeight: FontWeight.w500)),
                                        Text("Rs. ${paymentDetailsData[index].totalAmount}",
                                            style: TextStyle(
                                                color: AppColors.darktextColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ))),
          ]),
        ));
  }
}