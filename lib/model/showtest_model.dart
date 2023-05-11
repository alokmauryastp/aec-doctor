// To parse this JSON data, do
//
//     final showTestModel = showTestModelFromJson(jsonString);

import 'dart:convert';

List<ShowTestModel> showTestModelFromJson(String str) => List<ShowTestModel>.from(json.decode(str).map((x) => ShowTestModel.fromJson(x)));

String showTestModelToJson(List<ShowTestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowTestModel {
  ShowTestModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  int status;
  String msg;
  List<TestDatum> data;

  factory ShowTestModel.fromJson(Map<String, dynamic> json) => ShowTestModel(
    status: json["status"],
    msg: json["msg"],
    data: List<TestDatum>.from(json["data"].map((x) => TestDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TestDatum {
  TestDatum({
    required this.testId,
    required this.test,
    required this.description,
  });

  String testId;
  String test;
  String description;

  factory TestDatum.fromJson(Map<String, dynamic> json) => TestDatum(
    testId: json["TestId"],
    test: json["Test"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "TestId": testId,
    "Test": test,
    "Description": description,
  };
}
