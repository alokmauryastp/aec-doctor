// @dart=2.9
class GetMedicalHistoryModel {
  int status;
  String msg;
  GetMedicalHistoryData data;

  GetMedicalHistoryModel({this.status, this.msg, this.data});

  GetMedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new GetMedicalHistoryData.fromJson(json['data']) : null;
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

class GetMedicalHistoryData {
  String question1;
  String answer1;
  String question2;
  String answer2;
  String question3;
  String answer3;
  String question4;
  String answer4;
  String question5;
  String answer5;
  String question6;
  String answer6;
  String question7;
  String answer7;
  String question8;
  String answer8;
  String question9;
  String answer9;
  String question10;
  String answer10;

  GetMedicalHistoryData(
      {this.question1,
        this.answer1,
        this.question2,
        this.answer2,
        this.question3,
        this.answer3,
        this.question4,
        this.answer4,
        this.question5,
        this.answer5,
        this.question6,
        this.answer6,
        this.question7,
        this.answer7,
        this.question8,
        this.answer8,
        this.question9,
        this.answer9,
        this.question10,
        this.answer10});

  GetMedicalHistoryData.fromJson(Map<String, dynamic> json) {
    question1 = json['Question1'];
    answer1 = json['Answer1'];
    question2 = json['Question2'];
    answer2 = json['Answer2'];
    question3 = json['Question3'];
    answer3 = json['Answer3'];
    question4 = json['Question4'];
    answer4 = json['Answer4'];
    question5 = json['Question5'];
    answer5 = json['Answer5'];
    question6 = json['Question6'];
    answer6 = json['Answer6'];
    question7 = json['Question7'];
    answer7 = json['Answer7'];
    question8 = json['Question8'];
    answer8 = json['Answer8'];
    question9 = json['Question9'];
    answer9 = json['Answer9'];
    question10 = json['Question10'];
    answer10 = json['Answer10'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Question1'] = this.question1;
    data['Answer1'] = this.answer1;
    data['Question2'] = this.question2;
    data['Answer2'] = this.answer2;
    data['Question3'] = this.question3;
    data['Answer3'] = this.answer3;
    data['Question4'] = this.question4;
    data['Answer4'] = this.answer4;
    data['Question5'] = this.question5;
    data['Answer5'] = this.answer5;
    data['Question6'] = this.question6;
    data['Answer6'] = this.answer6;
    data['Question7'] = this.question7;
    data['Answer7'] = this.answer7;
    data['Question8'] = this.question8;
    data['Answer8'] = this.answer8;
    data['Question9'] = this.question9;
    data['Answer9'] = this.answer9;
    data['Question10'] = this.question10;
    data['Answer10'] = this.answer10;
    return data;
  }
}
