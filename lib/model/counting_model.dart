// @dart=2.9
class CountingModel {
  int status;
  String msg;
  CountingData data;

  CountingModel({this.status, this.msg, this.data});

  CountingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new CountingData.fromJson(json['data']) : null;
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

class CountingData {
  String amountPaid;
  String amountPending;
  int completeConsultation;
  int totalConsultation;

  CountingData(
      {this.amountPaid,
        this.amountPending,
        this.completeConsultation,
        this.totalConsultation});

  CountingData.fromJson(Map<String, dynamic> json) {
    amountPaid = json['AmountPaid'];
    amountPending = json['AmountPending'];
    completeConsultation = json['CompleteConsultation'];
    totalConsultation = json['TotalConsultation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmountPaid'] = this.amountPaid;
    data['AmountPending'] = this.amountPending;
    data['CompleteConsultation'] = this.completeConsultation;
    data['TotalConsultation'] = this.totalConsultation;
    return data;
  }
}
