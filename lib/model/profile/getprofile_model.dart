// @dart=2.9
class GetProfileModel {
  int status;
  String msg;
  GetProfileData data;

  GetProfileModel({this.status, this.msg, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new GetProfileData.fromJson(json['data']) : null;
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

class GetProfileData {
  String doctorId;
  String name;
  String mobile;
  String email;
  String profile;
  String dOB;
  String gender;
  String experiance;
  String highestQualification;
  String qualification;
  String medicalRegistrationId;
  String specialityValue;
  String speciality;
  String symptoms;
  String clinicName;
  String address;
  String pincode;
  String state;
  String district;
  String districtId;
  String accountHolder;
  String accountNumber;
  String iFSC;
  String bankName;
  String branchName;
  String photoIdFront;
  String photoIdFrontStatus;
  String photoIdBack;
  String photoIdBackStatus;
  String signature;
  String signatureStatus;
  String qualificationImage;
  String qualificationImageStatus;
  String medicalRegistrationImage;
  String medicalRegistrationImageStatus;
  String indemnityCertificate;
  String indemnityCertificateStatus;
  String verifyStatus;
  String counselingStatus;
  String award;
  String is_online;

  GetProfileData(
      {this.doctorId,
        this.name,
        this.mobile,
        this.email,
        this.profile,
        this.dOB,
        this.gender,
        this.experiance,
        this.highestQualification,
        this.qualification,
        this.medicalRegistrationId,
        this.specialityValue,
        this.speciality,
        this.symptoms,
        this.clinicName,
        this.address,
        this.pincode,
        this.state,
        this.district,
        this.districtId,
        this.accountHolder,
        this.accountNumber,
        this.iFSC,
        this.bankName,
        this.branchName,
        this.photoIdFront,
        this.photoIdFrontStatus,
        this.photoIdBack,
        this.photoIdBackStatus,
        this.signature,
        this.signatureStatus,
        this.qualificationImage,
        this.qualificationImageStatus,
        this.medicalRegistrationImage,
        this.medicalRegistrationImageStatus,
        this.indemnityCertificate,
        this.indemnityCertificateStatus,
        this.verifyStatus,
        this.counselingStatus,
        this.award,
        this.is_online
      });

  GetProfileData.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    name = json['Name'];
    mobile = json['Mobile'];
    email = json['Email'];
    profile = json['Profile'];
    dOB = json['DOB'];
    gender = json['Gender'];
    experiance = json['Experiance'];
    highestQualification = json['HighestQualification'];
    qualification = json['Qualification'];
    medicalRegistrationId = json['MedicalRegistrationId'];
    specialityValue = json['SpecialityValue'];
    speciality = json['Speciality'];
    symptoms = json['Symptoms'];
    clinicName = json['ClinicName'];
    address = json['Address'];
    pincode = json['Pincode'];
    state = json['State'];
    district = json['District'];
    districtId = json['DistrictId'];
    accountHolder = json['AccountHolder'];
    accountNumber = json['AccountNumber'];
    iFSC = json['IFSC'];
    bankName = json['BankName'];
    branchName = json['BranchName'];
    photoIdFront = json['PhotoIdFront'];
    photoIdFrontStatus = json['PhotoIdFrontStatus'];
    photoIdBack = json['PhotoIdBack'];
    photoIdBackStatus = json['PhotoIdBackStatus'];
    signature = json['Signature'];
    signatureStatus = json['SignatureStatus'];
    qualificationImage = json['QualificationImage'];
    qualificationImageStatus = json['QualificationImageStatus'];
    medicalRegistrationImage = json['MedicalRegistrationImage'];
    medicalRegistrationImageStatus = json['MedicalRegistrationImageStatus'];
    indemnityCertificate = json['IndemnityCertificate'];
    indemnityCertificateStatus = json['IndemnityCertificateStatus'];
    verifyStatus = json['VerifyStatus'];
    counselingStatus = json['CounselingStatus'];
    award = json['Award'];
    is_online = json['is_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['Name'] = this.name;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['Profile'] = this.profile;
    data['DOB'] = this.dOB;
    data['Gender'] = this.gender;
    data['Experiance'] = this.experiance;
    data['HighestQualification'] = this.highestQualification;
    data['Qualification'] = this.qualification;
    data['MedicalRegistrationId'] = this.medicalRegistrationId;
    data['SpecialityValue'] = this.specialityValue;
    data['Speciality'] = this.speciality;
    data['Symptoms'] = this.symptoms;
    data['ClinicName'] = this.clinicName;
    data['Address'] = this.address;
    data['Pincode'] = this.pincode;
    data['State'] = this.state;
    data['District'] = this.district;
    data['DistrictId'] = this.districtId;
    data['AccountHolder'] = this.accountHolder;
    data['AccountNumber'] = this.accountNumber;
    data['IFSC'] = this.iFSC;
    data['BankName'] = this.bankName;
    data['BranchName'] = this.branchName;
    data['PhotoIdFront'] = this.photoIdFront;
    data['PhotoIdFrontStatus'] = this.photoIdFrontStatus;
    data['PhotoIdBack'] = this.photoIdBack;
    data['PhotoIdBackStatus'] = this.photoIdBackStatus;
    data['Signature'] = this.signature;
    data['SignatureStatus'] = this.signatureStatus;
    data['QualificationImage'] = this.qualificationImage;
    data['QualificationImageStatus'] = this.qualificationImageStatus;
    data['MedicalRegistrationImage'] = this.medicalRegistrationImage;
    data['MedicalRegistrationImageStatus'] =
        this.medicalRegistrationImageStatus;
    data['IndemnityCertificate'] = this.indemnityCertificate;
    data['IndemnityCertificateStatus'] = this.indemnityCertificateStatus;
    data['VerifyStatus'] = this.verifyStatus;
    data['CounselingStatus'] = this.counselingStatus;
    data['Award'] = this.award;
    data['is_online'] = this.is_online;
    return data;
  }
}
