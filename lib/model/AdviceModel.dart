// To parse this JSON data, do
//
//     final advicesModel = advicesModelFromJson(jsonString);

import 'dart:convert';

List<AdvicesModel> advicesModelFromJson(String str) => List<AdvicesModel>.from(json.decode(str).map((x) => AdvicesModel.fromJson(x)));

String advicesModelToJson(List<AdvicesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvicesModel {
    AdvicesModel({
       required this.status,
       required this.msg,
       required this.data,
    });

    int status;
    String msg;
    List<AdviceDatum> data;

    factory AdvicesModel.fromJson(Map<String, dynamic> json) => AdvicesModel(
        status: json["status"],
        msg: json["msg"],
        data: List<AdviceDatum>.from(json["data"].map((x) => AdviceDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AdviceDatum {
    AdviceDatum({
       required this.adviceId,
       required this.title,
       required this.description,
    });

    String adviceId;
    String title;
    String description;

    factory AdviceDatum.fromJson(Map<String, dynamic> json) => AdviceDatum(
        adviceId: json["AdviceId"],
        title: json["Title"],
        description: json["Description"],
    );

    Map<String, dynamic> toJson() => {
        "AdviceId": adviceId,
        "Title": title,
        "Description": description,
    };
}
