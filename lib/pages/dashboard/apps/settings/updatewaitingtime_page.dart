// // @dart=2.9
// import 'package:aec_medical_doctor/api/repository/auth_repo.dart';
// import 'package:aec_medical_doctor/api/repository/home_repo.dart';
// import 'package:aec_medical_doctor/custom/custom_button.dart';
// import 'package:aec_medical_doctor/custom/green_custom_button.dart';
// import 'package:aec_medical_doctor/utils/colors.dart';
// import 'package:aec_medical_doctor/utils/strings.dart';
// import 'package:aec_medical_doctor/utils/strings_style.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounce/flutter_bounce.dart';
// import 'package:get/get.dart';
//
// class UpdateWaitingTimePage extends StatefulWidget {
//   @override
//   _UpdateWaitingTimePageState createState() =>
//       _UpdateWaitingTimePageState();
// }
//
// class _UpdateWaitingTimePageState extends State<UpdateWaitingTimePage> {
//
//
//   final _formKey = GlobalKey<FormState>();
//   final _time = TextEditingController();
//
//   bool _isLoad = false;
//
//   void _trySubmit()async{
//     if(_formKey.currentState!.validate()){
//       setState(() {
//         _isLoad = true;
//       });
//       HomeRepo homeRepo = new HomeRepo();
//       homeRepo.updateWaitingTimeApi(_time.text);
//       setState(() {
//         _isLoad = false;
//       });}}
//
//   bool isChecked = true;
//
//   String _chosenValue;
//
//   void _showDecline() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               title: new Text("Decline Appointment Request"),
//               content:
//               Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                 new Text("Please select an option for why you declined."),
//                 SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: new DropdownButton<String>(
//                       hint: Text('Select one option'),
//                       value: _chosenValue,
//                       underline: Container(),
//                       items: <String>[
//                         'I\'m not able to help',
//                         'Unclear description',
//                         'Not available at set date and time',
//                         'Other'
//                       ].map((String value) {
//                         return new DropdownMenuItem<String>(
//                           value: value,
//                           child: new Text(
//                             value,
//                             style: TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String value) {
//                         setState(() {
//                           _chosenValue = value;
//                         });
//                       },
//                     )),
//               ]),
//               actions: <Widget>[
//                 // usually buttons at the bottom of the dialog
//                 new FlatButton(
//                   child: new Text("Close"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: FlatButton(child: Text('Click'), onPressed: _showDecline),
//         ),
//       ),
//     );
//
//   _button() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50),
//       child: Bounce(
//         duration: Duration(milliseconds: 110),
//         onPressed: _trySubmit,
//         child: CustomButton(
//           text2: 'Update Time',
//           width: Get.width,
//           height: 45,
//           text1: '',
//         ),
//       ),
//     );
//   }
//
// }
