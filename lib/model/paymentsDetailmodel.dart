// @dart=2.9
class PaymentDetailsModel {
  int status;
  String msg;
  List<PaymentDetailsData> data;

  PaymentDetailsModel({this.status, this.msg, this.data});

  PaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<PaymentDetailsData>();
      json['data'].forEach((v) {
        data.add(new PaymentDetailsData.fromJson(v));
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

class PaymentDetailsData {
  String s0;
  String paymentId;
  String totalAmount;
  String onlineCommision;
  String onlineCommisionAmount;
  String companyCommision;
  String companyCommisionAmount;
  String paidAmount;
  String date;
  String time;

  PaymentDetailsData(
      {this.s0,
        this.paymentId,
        this.totalAmount,
        this.onlineCommision,
        this.onlineCommisionAmount,
        this.companyCommision,
        this.companyCommisionAmount,
        this.paidAmount,
        this.date,
        this.time});

  PaymentDetailsData.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    paymentId = json['PaymentId'];
    totalAmount = json['TotalAmount'];
    onlineCommision = json['OnlineCommision'];
    onlineCommisionAmount = json['OnlineCommisionAmount'];
    companyCommision = json['CompanyCommision'];
    companyCommisionAmount = json['CompanyCommisionAmount'];
    paidAmount = json['PaidAmount'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['PaymentId'] = this.paymentId;
    data['TotalAmount'] = this.totalAmount;
    data['OnlineCommision'] = this.onlineCommision;
    data['OnlineCommisionAmount'] = this.onlineCommisionAmount;
    data['CompanyCommision'] = this.companyCommision;
    data['CompanyCommisionAmount'] = this.companyCommisionAmount;
    data['PaidAmount'] = this.paidAmount;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
