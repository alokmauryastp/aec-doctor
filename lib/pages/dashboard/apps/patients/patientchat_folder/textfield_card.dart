import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

class TextFieldCard extends StatefulWidget {
  const TextFieldCard({Key? key}) : super(key: key);

  @override
  _TextFieldCardState createState() => _TextFieldCardState();
}

class _TextFieldCardState extends State<TextFieldCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            color: AppColors.whitetextColor,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 60, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Please enter the patient's \nname",
                      style: TextStyle(fontSize: 15)),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.appbarbackgroundColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Patient Name',
                          hintStyle: TextStyle(
                            color: AppColors.lighttextColor,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          errorBorder: new OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
