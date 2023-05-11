// @dart=2.9
class MessageCountModel {
  int status;
  String msg;
  MessageCountData data;

  MessageCountModel({this.status, this.msg, this.data});

  MessageCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new MessageCountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class MessageCountData {
  int num;

  MessageCountData({this.num});

  MessageCountData.fromJson(Map<String, dynamic> json) {
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    return data;
  }
}
