// @dart=2.9
class PrescriptionDetailsModel {
  int status;
  String msg;
  List<Null> date;
  List<PrescriptionDetailsData> data;

  PrescriptionDetailsModel({this.status, this.msg, this.date, this.data});

  PrescriptionDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    // if (json['date'] != null) {
    //   date = new List<Null>();
    //   json['date'].forEach((v) {
    //     date.add(new Null.fromJson(v));
    //   });
    // }
    if (json['data'] != null) {
      data = new List<PrescriptionDetailsData>();
      json['data'].forEach((v) {
        data.add(new PrescriptionDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    // if (this.date != null) {
    //   data['date'] = this.date.map((v) => v.toJson()).toList();
    // }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrescriptionDetailsData {
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
  Details details;

  PrescriptionDetailsData(
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
        this.time,
        this.details});

  PrescriptionDetailsData.fromJson(Map<String, dynamic> json) {
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
    details =
    json['Details'] != null ? new Details.fromJson(json['Details']) : null;
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
    if (this.details != null) {
      data['Details'] = this.details.toJson();
    }
    return data;
  }
}

class Details {
  List<Test> test;
  List<Medicine> medicine;
  List<Advice> advice;

  Details({this.test, this.medicine, this.advice});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['test'] != null) {
      test = new List<Test>();
      json['test'].forEach((v) {
        test.add(new Test.fromJson(v));
      });
    }
    if (json['medicine'] != null) {
      medicine = new List<Medicine>();
      json['medicine'].forEach((v) {
        medicine.add(new Medicine.fromJson(v));
      });
    }
    if (json['advice'] != null) {
      advice = new List<Advice>();
      json['advice'].forEach((v) {
        advice.add(new Advice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.test != null) {
      data['test'] = this.test.map((v) => v.toJson()).toList();
    }
    if (this.medicine != null) {
      data['medicine'] = this.medicine.map((v) => v.toJson()).toList();
    }
    if (this.advice != null) {
      data['advice'] = this.advice.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Test {
  String test;
  String description;

  Test({this.test, this.description});

  Test.fromJson(Map<String, dynamic> json) {
    test = json['Test'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Test'] = this.test;
    data['Description'] = this.description;
    return data;
  }
}

class Medicine {
  String medicineName;
  String medicineStrength;
  String dose;
  String duration;
  String instrunction;

  Medicine(
      {this.medicineName,
        this.medicineStrength,
        this.dose,
        this.duration,
        this.instrunction});

  Medicine.fromJson(Map<String, dynamic> json) {
    medicineName = json['MedicineName'];
    medicineStrength = json['MedicineStrength'];
    dose = json['Dose'];
    duration = json['Duration'];
    instrunction = json['Instrunction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MedicineName'] = this.medicineName;
    data['MedicineStrength'] = this.medicineStrength;
    data['Dose'] = this.dose;
    data['Duration'] = this.duration;
    data['Instrunction'] = this.instrunction;
    return data;
  }
}

class Advice {
  String adviceTitle;
  String adviceDescription;

  Advice({this.adviceTitle, this.adviceDescription});

  Advice.fromJson(Map<String, dynamic> json) {
    adviceTitle = json['AdviceTitle'];
    adviceDescription = json['AdviceDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdviceTitle'] = this.adviceTitle;
    data['AdviceDescription'] = this.adviceDescription;
    return data;
  }
}
