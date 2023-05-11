// @dart=2.9
class AllPatientsModel {
  int status;
  String msg;
  List<AllPatientsData> data;

  AllPatientsModel({this.status, this.msg, this.data});

  AllPatientsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<AllPatientsData>();
      json['data'].forEach((v) {
        data.add(new AllPatientsData.fromJson(v));
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

class AllPatientsData {
  String consultId;
  String patientName;
  String disease;
  String patientAge;
  String gender;
  String address;
  String language;
  String consultMedium;
  String paymentAmount;
  String paymentMode;
  String assignId;
  String waitingTime;
  String date;
  String time;
  String doctor;
  String validTill;
  String userProfile;
  String userName;
  String userMobile;
  String userOccupation;
  String userId;
  bool consultStatus;

  AllPatientsData(
      {this.consultId,
        this.patientName,
        this.disease,
        this.patientAge,
        this.gender,
        this.address,
        this.language,
        this.consultMedium,
        this.paymentAmount,
        this.paymentMode,
        this.assignId,
        this.waitingTime,
        this.date,
        this.time,
        this.doctor,
        this.validTill,
        this.userProfile,
        this.userName,
        this.userMobile,
        this.userOccupation,
        this.userId,
        this.consultStatus});

  AllPatientsData.fromJson(Map<String, dynamic> json) {
    consultId = json['ConsultId'];
    patientName = json['PatientName'];
    disease = json['Disease'];
    patientAge = json['PatientAge'];
    gender = json['Gender'];
    address = json['Address'];
    language = json['Language'];
    consultMedium = json['ConsultMedium'];
    paymentAmount = json['PaymentAmount'];
    paymentMode = json['PaymentMode'];
    assignId = json['AssignId'];
    waitingTime = json['WaitingTime'];
    date = json['Date'];
    time = json['Time'];
    doctor = json['Doctor'];
    validTill = json['ValidTill'];
    userProfile = json['UserProfile'];
    userName = json['UserName'];
    userMobile = json['UserMobile'];
    userOccupation = json['UserOccupation'];
    userId = json['UserId'];
    consultStatus = json['ConsultStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ConsultId'] = this.consultId;
    data['PatientName'] = this.patientName;
    data['Disease'] = this.disease;
    data['PatientAge'] = this.patientAge;
    data['Gender'] = this.gender;
    data['Address'] = this.address;
    data['Language'] = this.language;
    data['ConsultMedium'] = this.consultMedium;
    data['PaymentAmount'] = this.paymentAmount;
    data['PaymentMode'] = this.paymentMode;
    data['AssignId'] = this.assignId;
    data['WaitingTime'] = this.waitingTime;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Doctor'] = this.doctor;
    data['ValidTill'] = this.validTill;
    data['UserProfile'] = this.userProfile;
    data['UserName'] = this.userName;
    data['UserMobile'] = this.userMobile;
    data['UserOccupation'] = this.userOccupation;
    data['UserId'] = this.userId;
    data['ConsultStatus'] = this.consultStatus;
    return data;
  }
}
