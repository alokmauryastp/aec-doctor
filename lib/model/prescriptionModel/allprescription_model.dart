// @dart=2.9
class AllPrescriptionModel {
  int status;
  String msg;
  List<AllPrescriptionData> data;

  AllPrescriptionModel({this.status, this.msg, this.data});

  AllPrescriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<AllPrescriptionData>();
      json['data'].forEach((v) {
        data.add(new AllPrescriptionData.fromJson(v));
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

class AllPrescriptionData {
  String prescriptionId;
  String consultId;
  String patientName;
  String patientAge;
  String address;
  String gender;
  String oEx;
  String pD;
  String comment;
  String date;
  String time;

  AllPrescriptionData(
      {this.prescriptionId,
        this.consultId,
        this.patientName,
        this.patientAge,
        this.address,
        this.gender,
        this.oEx,
        this.pD,
        this.comment,
        this.date,
        this.time});

  AllPrescriptionData.fromJson(Map<String, dynamic> json) {
    prescriptionId = json['PrescriptionId'];
    consultId = json['ConsultId'];
    patientName = json['PatientName'];
    patientAge = json['PatientAge'];
    address = json['Address'];
    gender = json['Gender'];
    oEx = json['o_ex'];
    pD = json['PD'];
    comment = json['Comment'];
    date = json['Date'];
    time = json['Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PrescriptionId'] = this.prescriptionId;
    data['ConsultId'] = this.consultId;
    data['PatientName'] = this.patientName;
    data['PatientAge'] = this.patientAge;
    data['Address'] = this.address;
    data['Gender'] = this.gender;
    data['o_ex'] = this.oEx;
    data['PD'] = this.pD;
    data['Comment'] = this.comment;
    data['Date'] = this.date;
    data['Time'] = this.time;
    return data;
  }
}
