import 'dart:convert';

List<Faq> faqFromJson(String str) =>
    List<Faq>.from(json.decode(str).map((x) => Faq.fromJson(x)));

String faqToJson(List<Faq> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Faq {
  Faq({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<Datum> data;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        status: json["status"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.faqId,
    required this.question,
    required this.answer,
    required this.date,
    required this.time,
  });

  String faqId;
  String question;
  String answer;
  DateTime date;
  String time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        faqId: json["FAQId"],
        question: json["Question"],
        answer: json["Answer"],
        date: DateTime.parse(json["Date"]),
        time: json["Time"],
      );

  Map<String, dynamic> toJson() => {
        "FAQId": faqId,
        "Question": question,
        "Answer": answer,
        "Date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "Time": time,
      };
}
