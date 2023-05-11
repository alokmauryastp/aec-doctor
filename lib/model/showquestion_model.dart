// To parse this JSON data, do
//
//     final getQuestions = getQuestionsFromJson(jsonString);

import 'dart:convert';

List<GetQuestions> getQuestionsFromJson(String str) => List<GetQuestions>.from(json.decode(str).map((x) => GetQuestions.fromJson(x)));

String getQuestionsToJson(List<GetQuestions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetQuestions {
  GetQuestions({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<QnDatum> data;

  factory GetQuestions.fromJson(Map<String, dynamic> json) => GetQuestions(
    status: json["status"],
    msg: json["msg"],
    data: List<QnDatum>.from(json["data"].map((x) => QnDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class QnDatum {
  QnDatum({
    required this.questionId,
    required this.title,
    required this.question,
  });

  String questionId;
  String title;
  String question;

  factory QnDatum.fromJson(Map<String, dynamic> json) => QnDatum(
    questionId: json["QuestionId"],
    title: json["Title"],
    question: json["Question"],
  );

  Map<String, dynamic> toJson() => {
    "QuestionId": questionId,
    "Title": title,
    "Question": question,
  };
}