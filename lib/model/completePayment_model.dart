// @dart=2.9
class CompletePaymentModel {
  int status;
  String msg;
  List<CompletePaymentData> data;

  CompletePaymentModel({this.status, this.msg, this.data});

  CompletePaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<CompletePaymentData>();
      json['data'].forEach((v) {
        data.add(new CompletePaymentData.fromJson(v));
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

class CompletePaymentData {
  String doctor;
  String user;
  String patient;
  String amount;
  String date;
  String time;

  CompletePaymentData(
      {this.doctor,
        this.user,
        this.patient,
        this.amount,
        this.date,
        this.time});

  CompletePaymentData.fromJson(Map<String, dynamic> json) {
    doctor = json['Doctor'];
    user = json['User'];
    patient = json['Patient'];
    amount = json['Amount'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Doctor'] = this.doctor;
    data['User'] = this.user;
    data['Patient'] = this.patient;
    data['Amount'] = this.amount;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
