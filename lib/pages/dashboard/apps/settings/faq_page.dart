import 'package:aec_medical_doctor/api/repository/auth_repo.dart';
import 'package:aec_medical_doctor/api/repository/cms_repo.dart';
import 'package:aec_medical_doctor/model/faq_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expandable/expandable.dart';

import '../../notification_page.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  
  bool isLoading = false;
  List<Datum> faqList = [];
  void callFaqApi() async {
    setState(() {
      isLoading = true;
    });

    CmsRepo().getFaqApi('doctor').then((value) {
      if(value['status']==1){
        for (int i = 0; i < value['data'].length; i++) {
        Datum data = Datum.fromJson(value['data'][i]);
        faqList.add(data);
      }
      setState(() {
        isLoading = false;
      });
      }
      else{
   setState(() {
        isLoading = false;
      });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    callFaqApi();
    super.initState();
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
        body: isLoading == true
            ? Center(
              child:CircularProgressIndicator()
            )
            : faqList.length==0?Center(
              child:EmptyWidget(
                image: null,
                packageImage: PackageImage.Image_2,
                title: 'No Data',
                subTitle: 'Sorry! No Data found.',
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  color: Color(0xff9da9c7),
                  fontWeight: FontWeight.w500,
                ),
                subtitleTextStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffabb8d6),
                ),
              ),
            ):SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      _heading(),
                      SizedBox(height: 20),
                      _subHeading(),
                      SizedBox(height: 20),
                      ListView.builder(
                          itemCount: faqList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,15,8,5),
                              child: ExpandablePanel(
                                header: Text(faqList[index].question,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                collapsed: Text(
                                  "",
                                ),
                                expanded: Text(
                                  faqList[index].answer,
                                  softWrap: true,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ));
  }

  _heading() {
    return Text(Strings.FAQ_HEADING, style: StringsStyle.heading);
  }

  _subHeading() {
    return Column(
      children: [
        Text(Strings.FAQ_SUBHEADING1, style: StringsStyle.faqsubheadingstyle),
        Text(Strings.FAQ_SUBHEADING2, style: StringsStyle.faqsubheadingstyle),
        Text(Strings.FAQ_SUBHEADING3, style: StringsStyle.faqsubheadingstyle),
      ],
    );
  }
}
