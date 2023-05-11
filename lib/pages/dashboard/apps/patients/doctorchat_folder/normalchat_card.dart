import 'package:flutter/material.dart';

class NormalChatCard extends StatefulWidget {
  const NormalChatCard({Key? key}) : super(key: key);

  @override
  _NormalChatCardState createState() => _NormalChatCardState();
}

class _NormalChatCardState extends State<NormalChatCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              color: Colors.teal.shade100,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 10,
                    child: Text("Dr. Name",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 60, 20),
                    child: Text(
                        "Good afternoon patient name! i am here to help you, please tell me more about your problem.",
                        style: TextStyle(fontSize: 14)),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Row(
                      children: [
                        Text("20:58",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)),
                        SizedBox(width: 5),
                        Icon(Icons.done_all, size: 17),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
