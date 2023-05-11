// @dart=2.9
class GetChatModel {
  int status;
  String msg;
  List<GetChatData> data;
  int num;

  GetChatModel({this.status, this.msg, this.data, this.num});

  GetChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<GetChatData>();
      json['data'].forEach((v) {
        data.add(new GetChatData.fromJson(v));
      });
    }
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['num'] = this.num;
    return data;
  }
}

class GetChatData {
  String chatId;
  String message;
  String image;
  String doctorImage;
  String userImage;
  String doctor;
  String user;
  String patientName;
  String date;
  String time;
  String ago;
  String userType;

  GetChatData(
      {this.chatId,
        this.message,
        this.image,
        this.doctorImage,
        this.userImage,
        this.doctor,
        this.user,
        this.patientName,
        this.date,
        this.time,
        this.ago,
        this.userType});

  GetChatData.fromJson(Map<String, dynamic> json) {
    chatId = json['ChatId'];
    message = json['Message'];
    image = json['Image'];
    doctorImage = json['DoctorImage'];
    userImage = json['UserImage'];
    doctor = json['Doctor'];
    user = json['User'];
    patientName = json['PatientName'];
    date = json['Date'];
    time = json['Time'];
    ago = json['Ago'];
    userType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ChatId'] = this.chatId;
    data['Message'] = this.message;
    data['Image'] = this.image;
    data['DoctorImage'] = this.doctorImage;
    data['UserImage'] = this.userImage;
    data['Doctor'] = this.doctor;
    data['User'] = this.user;
    data['PatientName'] = this.patientName;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Ago'] = this.ago;
    data['UserType'] = this.userType;
    return data;
  }
}
