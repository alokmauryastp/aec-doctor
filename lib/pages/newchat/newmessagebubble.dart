// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class NewMessageBubble extends StatefulWidget {
  NewMessageBubble(this.message, this.isMe, this.id, this.msgType, this.image,
      this.time, this.ago, this.doctor,
      {this.key});

  final Key key;
  final String message;
  final String isMe;
  final String id;
  final String msgType;
  final String image;
  final String time;
  final String ago;
  final String doctor;

  @override
  _NewMessageBubbleState createState() => _NewMessageBubbleState();
}

class _NewMessageBubbleState extends State<NewMessageBubble> {
  Duration duration;
  Duration position;
  String localFilePath;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _positionSubscription.cancel();
    // _audioPlayerStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: widget.id == "user"
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Container(
            // alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: widget.id == "user" ? Colors.grey[300] : Color(0xff6e66e4),
              borderRadius: BorderRadius.only(
                topLeft: widget.id == "user"
                    ? Radius.circular(0)
                    : Radius.circular(15),
                topRight: widget.id == "user"
                    ? Radius.circular(15)
                    : Radius.circular(15),
                bottomLeft: Radius.circular(15),
                // bottomLeft: !isMe == ? Radius.circular(0) : Radius.circular(12),
                bottomRight:  widget.id =='user'
                    ? Radius.circular(15)
                    : Radius.circular(0),
              ),
            ),
            width: 180,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              crossAxisAlignment: widget.id == "user"
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                // Container(alignment: Alignment.centerLeft,
                //   padding: EdgeInsets.only(left: 10),
                //   child: Text("You",style:
                //   TextStyle(fontSize: 13, color: Colors.black)),),
                widget.image.isEmpty
                    ? Text("")
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: widget.id == "user"
                              ? InkWell(
                                  onTap: () {
                                    _viewImage(widget.image);
                                  },
                                  child: Image.network(
                                    widget.image,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    _viewImage(
                                        'https://apolloeclinic.com/uploads/chat_image/' +
                                            widget.image
                                                .split("/")
                                                .removeLast());
                                  },
                                  child: Image.network(
                                    'https://apolloeclinic.com/uploads/chat_image/' +
                                        widget.image.split("/").removeLast(),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),
                      ),
                //SizedBox(height: 3,),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(widget.message,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: widget.id == "user"
                                  ? Colors.black
                                  : Colors.white)),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 10),
                  child: Text((widget.time).isEmpty ? "" : widget.time,
                      style: TextStyle(
                          fontSize: 13,
                          color: widget.id == "user"
                              ? Colors.black
                              : Colors.white)),
                ),
                SizedBox(
                  height: 3,
                ),

                /*widget.id == "user"?ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: widget.image==null?Text("jj"):Image.network(widget.image,
                          fit: BoxFit.contain,)):Text("iiii")*/
                /*widget.msgType == "image" ? GestureDetector(
                      onTap: (){
                      },
                      child:
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.message,
                            fit: BoxFit.contain,)),
                    ):*/
                // msgType =="image"?Text(message,style: TextStyle(color: isMe == id ? Colors.black : Theme.of(context).accentTextTheme.headline1.color),):,
              ],
            ),
          ),
        ],
      )
    ]);
  }

  void _viewImage(path) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                color: Colors.white,
                child: PhotoView(
                  imageProvider: NetworkImage(path),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
