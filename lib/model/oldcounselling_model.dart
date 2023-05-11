// @dart=2.9
class OldCounselingModel {
  int status;
  String msg;
  List<OldCounselingData> data;

  OldCounselingModel({this.status, this.msg, this.data});

  OldCounselingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<OldCounselingData>();
      json['data'].forEach((v) {
        data.add(new OldCounselingData.fromJson(v));
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

class OldCounselingData {
  String counselingId;
  String name;
  String title;
  String price;
  String startDate;
  String hour;
  String minute;
  String duration;
  String link;
  String subject;
  String description;
  String date;
  String time;

  OldCounselingData(
      {this.counselingId,
        this.name,
        this.title,
        this.price,
        this.startDate,
        this.hour,
        this.minute,
        this.duration,
        this.link,
        this.subject,
        this.description,
        this.date,
        this.time});

  OldCounselingData.fromJson(Map<String, dynamic> json) {
    counselingId = json['CounselingId'];
    name = json['Name'];
    title = json['Title'];
    price = json['Price'];
    startDate = json['StartDate'];
    hour = json['Hour'];
    minute = json['Minute'];
    duration = json['Duration'];
    link = json['Link'];
    subject = json['Subject'];
    description = json['Description'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CounselingId'] = this.counselingId;
    data['Name'] = this.name;
    data['Title'] = this.title;
    data['Price'] = this.price;
    data['StartDate'] = this.startDate;
    data['Hour'] = this.hour;
    data['Minute'] = this.minute;
    data['Duration'] = this.duration;
    data['Link'] = this.link;
    data['Subject'] = this.subject;
    data['Description'] = this.description;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
