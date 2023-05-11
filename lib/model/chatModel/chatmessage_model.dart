// @dart=2.9
class MessageChatModel {
  int status;
  String msg;
  List<Null> data;

  MessageChatModel({this.status, this.msg, this.data});

  MessageChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    // if (json['data'] != null) {
    //   data = new List<Null>();
    //   json['data'].forEach((v) {
    //     data.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    // if (this.data != null) {
    //   data['data'] = this.data.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
