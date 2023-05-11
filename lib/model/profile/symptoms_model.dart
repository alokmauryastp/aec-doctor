// @dart=2.9
class SymptomsModel {
  int status;
  String msg;
  List<SymptomsData> data;

  SymptomsModel({this.status, this.msg, this.data});

  SymptomsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SymptomsData>();
      json['data'].forEach((v) {
        data.add(new SymptomsData.fromJson(v));
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

class SymptomsData {
  String symptomsId;
  String symptoms;
  String description;
  String price;

  SymptomsData({this.symptomsId, this.symptoms, this.description, this.price});

  SymptomsData.fromJson(Map<String, dynamic> json) {
    symptomsId = json['SymptomsId'];
    symptoms = json['Symptoms'];
    description = json['Description'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SymptomsId'] = this.symptomsId;
    data['Symptoms'] = this.symptoms;
    data['Description'] = this.description;
    data['Price'] = this.price;
    return data;
  }
}
