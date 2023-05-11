
import 'package:aec_medical_doctor/pages/authentication/signin_with_mobile_number.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SharedPrefManager {

  static SharedPreferences? sharedPreferences;

  static savePrefString(String key,String value) async{
     sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences!.setString(key, value);}

   static Future<dynamic> getPrefrenceString(String key) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? val = prefs.getString(key);
     return val;}

   static savePreferenceBoolean(bool b) async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool("isLoggedIn", b);}

   static getBooleanPreferences() async{
     sharedPreferences = await SharedPreferences.getInstance();
     return sharedPreferences!.getBool("isLoggedIn");}

  static clearPrefs() async{
    sharedPreferences = await SharedPreferences.getInstance();
    Get.offAll(SignInWithMobileNumberPage(),
        transition: Transition.rightToLeftWithFade,
        duration: Duration(milliseconds: 600));
    return sharedPreferences!.clear();}
}