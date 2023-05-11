import 'package:aec_medical_doctor/api/repository/prescription_repo.dart';
import 'package:aec_medical_doctor/model/prescriptionModel/allprescription_model.dart';
import 'package:aec_medical_doctor/model/prescriptionModel/prescriptionDetails_model.dart';
import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrescriptionDetailPage extends StatefulWidget {
  const PrescriptionDetailPage({Key? key}) : super(key: key);

  @override
  _PrescriptionDetailPageState createState() => _PrescriptionDetailPageState();
}

class _PrescriptionDetailPageState extends State<PrescriptionDetailPage> {


  late List<PrescriptionDetailsData> prescriptionDetailsData = [];

  late Future future;

  @override
  void initState() {
    PrescriptionRepo prescriptionRepo = new PrescriptionRepo();
    future = prescriptionRepo.singlePrescriptionApi();
    future.then((value){
      setState(() {
        prescriptionDetailsData = value;
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
        title: Image.asset(
          "assets/images/logo.png",
          height: 30,
          width: 30,
        ),
      ),
      body: prescriptionDetailsData.isEmpty?Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
               Align(
                alignment: Alignment.centerLeft,
                child: Text("Prescription Details",
                    style: TextStyle(
                        fontSize: 22,
                        color: AppColors
                            .appbarbackgroundColor,
                        fontWeight:
                        FontWeight.bold)),
              ),
              SizedBox(height: 20,),
              _detailedCard(),
              SizedBox(height: 20),
             // _addNewSummaryCard(),
            ],
          ),
        ),
      ),
    );
  }


  TextStyle textStyle = TextStyle(
    color: AppColors.lighttextColor,
    fontSize: 14,
    letterSpacing: 0.5,
    fontFamily: GoogleFonts.lato().fontFamily,
    fontWeight: FontWeight.w500,
  );


  TextStyle profileStyle = TextStyle(
      color: Color(0xff366997),
      fontWeight: FontWeight.bold,
      fontSize: 15,
      fontFamily: GoogleFonts.lato().fontFamily,
      letterSpacing: 0.5);

  _detailedCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.white,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Patient Name : ",
                    style: textStyle),
                Text(prescriptionDetailsData[0].patientName,
                    style: profileStyle),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Patient Age : ",
                    style: textStyle),
                Text(prescriptionDetailsData[0].patientAge,
                    style: profileStyle),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Gender : ",
                    style: textStyle),
                Text(prescriptionDetailsData[0].gender,
                    style: profileStyle),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Medicine : ",
                    style: textStyle),
                Text(prescriptionDetailsData[0].oEx,
                    style:profileStyle),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Lab Tests : ",
                    style: textStyle),
                Text(prescriptionDetailsData[0].details.test[0].test,
                    style: profileStyle),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Advice : ",
                    style: textStyle),
                Text(prescriptionDetailsData[0].details.advice[0].adviceTitle,
                    style: profileStyle),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Note : ",
                    style: textStyle),
                Text(prescriptionDetailsData[0].comment,
                    style: profileStyle),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  _addNewSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.white,
      elevation: 5,
      child: InkWell(
        onTap: () {},
        child: Container(
            height: 60,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add_sharp,
                    size: 20,
                    color: AppColors.appbarbackgroundColor,
                  ),
                  Center(
                    child: Text(" Add New Prescription",
                        style: TextStyle(
                          color: AppColors.appbarbackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
