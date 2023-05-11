
class AppUrlConstant{
  
  //////////////////// Base Url//////////////////////////////////
  
  static String baseUrlUser = "https://apolloeclinic.com/apollo_e_clinic/API/V1/User/";

  static String baseUrlDoctor = "https://apolloeclinic.com/API/V1/Doctor/";


  ///Api End point///////////////////////////////////

  /// Auth API URL //////////////////////////////////

  static String doctorloginwithotp= "doctorLoginWithOtp";

  static String loginotpverify = "doctorVerifyOTP";

  static String resendOtp = "doctorResendOTP";



  ///  /// Profile API URL ////////////////////////////////

    static String uploadProfileImage = "uploadProfileImage";

    static String speciality = "speciality";

    static String symptoms = "symptoms";

    static String getProfile = "getProfile";

    static String profileUpdateSubmit = "profileUpdateSubmit";

    static String clinicUpdate = "clinicUpdate";

    static String bankUpdate = "bankUpdate";

    static String uploadPhotoIdFront = "uploadPhotoIdFront";

    static String uploadPhotoIdBack = "uploadPhotoIdBack";

    static String uploadSignature = "uploadSignature";

    static String uploadQualificationImagee = "uploadQualificationImagee";

    static String uploadMedicalRegistration = "uploadMedicalRegistration";

    static String uploadIndemnityCertificate = "uploadIndemnityCertificate";



  /// template API URL ////////////////////////////////

  static final String faq="doctorFAQ";

  static final String showMedicine="showMedicine";

  static final String showQuestion="showQuestion";

  static final String showTest="showTest";

  static final String getQuestionAssistant="getQuestionAssistant";

  static final String addMedicine="addMedicine";

  static final String addQuestion="addQuestion";

  static final String addTest = "addTest";




  static final String addAdvice="addAdvice";

  static final String getAdvice="showAdvice";

  static final String editAdvice="editAdvice";

  static final String deleteAdvice='deleteAdvice';

  static final String editMedicine='editMedicine';

  static final String deleteMedicine='deleteMedicine';

  static final String editTest='editTest';

  static final String deleteTest='deleteTest';

  static final String editQuestion='editQuestion';

  static final String deleteQuestion='deleteQuestion';

  static final String updateToken = "updateToken";
  static final String doctorOnlineStatus = "doctorOnlineStatus";


  static final String checkDoctorAccount = "checkDoctorAccount";


  /// patients ////////////////////////////////////////


  static final String upcomingPatient = "upcomingPatient";

  static final String oldPatient = "oldPatient";

  static final String allPatient = "allPatient";

  static final String updateWaitingTime = "updateWaitingTime";

  static final String notification = "notification";

  static final String filterPatient = "filterPatient";

  static final String completePatient = "completePatient";


  /// chat ///////////////////////////////////////////////

  static final String getChat = "getChat";

  static final String saveDoctorChatMessage = "saveDoctorChatMessage";

  static final String checkMesagesCount = "checkMesagesCount";

  static final String sendChatNotification = "sendChatNotification";
  static final String sendCallNotification = "sendCallNotification";

  static final String getMedicalHistory = "getMedicalHistory";

  static final String chatStatus = "chatStatus";

  /// earning api ///////////////////////////////////////////////////// 

  static final String earninglist = "earning";

  static final String counting = "counting";

  static final String paymentDetails = "paymentDetails";

  static final String completePayment = "completePayment";

/// Counceling /////////////////////////////////////////////////////////////

  static final String doctorFollowup = "doctorFollowup";
  static final String addCounceling = "addCounceling";

  static final String showCounseling = "showCounseling";

  static final String editCounceling = "editCounceling";

  static final String assignOldCounseling = "assignOldCounseling";

  static final String assignCounseling = "assignCounseling";


  /// Prescription ////////////////////////////////////////////////////


  static final String submitPrescription = "submitPrescription";

  static final String showPrescription = "showPrescription";

  static final String singlePrescription = "singlePrescription";


}