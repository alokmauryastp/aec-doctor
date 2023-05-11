import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

class NormalTextCard extends StatefulWidget {
  const NormalTextCard({Key? key}) : super(key: key);

  @override
  _NormalTextCardState createState() => _NormalTextCardState();
}

class _NormalTextCardState extends State<NormalTextCard> {
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
                  Text("Patient Details", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      text: 'Age: ',
                      style: TextStyle(
                          color: AppColors.appbarbackgroundColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      children: const <TextSpan>[
                        TextSpan(
                          text: '26',
                          style: TextStyle(
                              color: AppColors.darktextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      text: 'Gender: ',
                      style: TextStyle(
                          color: AppColors.appbarbackgroundColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Male',
                          style: TextStyle(
                              color: AppColors.darktextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Problem Details:  ",
                    style: TextStyle(
                        color: AppColors.appbarbackgroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "jashd ausa auisndausd ais as aisid oa jksds.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: AppColors.darktextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
