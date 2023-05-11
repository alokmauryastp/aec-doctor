import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:aec_medical_doctor/utils/strings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NothingHere extends StatefulWidget {
  const NothingHere({Key? key}) : super(key: key);

  @override
  _NothingHereState createState() => _NothingHereState();
}

class _NothingHereState extends State<NothingHere> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbarbackgroundColor,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(),
                  Image.asset("assets/images/logo.png",
                    height: 30,
                    width: 30,),
                  Icon(Icons.notifications,size: 30,),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 60,),
             Image.asset("assets/images/nothinghere.png",),
              SizedBox(height: 10,),
              Text("Nothing Here!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text("Drag down to refresh the page and check again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }

}
