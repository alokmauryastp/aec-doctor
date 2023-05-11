import 'package:aec_medical_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

class ChooseOptionCard extends StatefulWidget {
  const ChooseOptionCard({Key? key}) : super(key: key);

  @override
  _ChooseOptionCardState createState() => _ChooseOptionCardState();
}

class _ChooseOptionCardState extends State<ChooseOptionCard> {
  var onchoose = 0;
  var optionsList = [
    "Constipation",
    "Sensitivity to cold(unable to feel warm)",
    "Dry skin",
    "Muscle weakness",
    "Hair thinning",
    "Hair loss",
    "Sweating",
    "None",
  ];
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
                  Text("Do you have any of the\nfollowing currently?",
                      style: TextStyle(fontSize: 15)),
                  SizedBox(height: 3),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: optionsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    onchoose = index;
                                  });
                                },
                                child: Container(
                                    child: onchoose == index
                                        ? Icon(Icons.check_box,
                                            color:
                                                AppColors.appbarbackgroundColor)
                                        : Icon(Icons.check_box_outline_blank,
                                            color: AppColors
                                                .appbarbackgroundColor))),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                optionsList[index],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
