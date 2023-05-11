// @dart=2.9
class ShowCounselingModel {
  int status;
  String msg;
  List<ShowCounselingData> data;

  ShowCounselingModel({this.status, this.msg, this.data});

  ShowCounselingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<ShowCounselingData>();
      json['data'].forEach((v) {
        data.add(new ShowCounselingData.fromJson(v));
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

class ShowCounselingData {
  String counselingId;
  String name;
  String title;
  String price;
  String offerPrice;
  String startDate;
  String hour;
  String minute;
  String duration;
  String link;
  String subject;
  String description;
  String date;
  String time;

  ShowCounselingData(
      {this.counselingId,
        this.name,
        this.title,
        this.price,
        this.offerPrice,
        this.startDate,
        this.hour,
        this.minute,
        this.duration,
        this.link,
        this.subject,
        this.description,
        this.date,
        this.time});

  ShowCounselingData.fromJson(Map<String, dynamic> json) {
    counselingId = json['CounselingId'];
    name = json['Name'];
    title = json['Title'];
    price = json['Price'];
    offerPrice = json['OfferPrice'];
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
    data['OfferPrice'] = this.offerPrice;
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
