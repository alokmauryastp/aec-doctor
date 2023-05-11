

import 'dart:convert';

List<GetMedicine> getMedicineFromJson(String str) => List<GetMedicine>.from(json.decode(str).map((x) => GetMedicine.fromJson(x)));

String getMedicineToJson(List<GetMedicine> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMedicine {
    GetMedicine({
       required this.status,
       required this.msg,
       required this.data,
    });

    int status;
    String msg;
    List<Datum> data;

    factory GetMedicine.fromJson(Map<String, dynamic> json) => GetMedicine(
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
       required this.medicineId,
       required this.name,
       required this.generic,
       required this.strength,
       required this.dosage,
       required this.duration,
       required this.comment,
       required this.takeMedicine,
    });

    String medicineId;
    String name;
    String generic;
    String strength;
    String dosage;
    String duration;
    String comment;
    String takeMedicine;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        medicineId: json["MedicineId"],
        name: json["Name"],
        generic: json["Generic"],
        strength: json["Strength"],
        dosage: json["dosage"],
        duration: json["Duration"],
        comment: json["Comment"],
        takeMedicine: json["take_medicine"],
    );

    Map<String, dynamic> toJson() => {
        "MedicineId": medicineId,
        "Name": name,
        "Generic": generic,
        "Strength": strength,
        "dosage": dosage,
        "Duration": duration,
        "Comment": comment,
        "take_medicine": takeMedicine,
    };
}
