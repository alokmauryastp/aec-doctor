// @dart=2.9
class NotificationsModel {
  int status;
  String msg;
  List<NotificationsData> data;

  NotificationsModel({this.status, this.msg, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<NotificationsData>();
      json['data'].forEach((v) {
        data.add(new NotificationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsData {
  String notificationId;
  String title;
  String message;
  String date;
  String time;

  NotificationsData({this.notificationId, this.title, this.message, this.date, this.time});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    notificationId = json['NotificationId'];
    title = json['Title'];
    message = json['Message'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationId'] = this.notificationId;
    data['Title'] = this.title;
    data['Message'] = this.message;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
