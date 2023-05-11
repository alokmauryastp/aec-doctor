// @dart=2.9
import 'package:aec_medical_doctor/api/repository/chat_repo.dart';
import 'package:aec_medical_doctor/pages/dashboard/apps/upcoming_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'api/repository/profile_repo.dart';
import 'api/sharedprefrence.dart';
import 'pages/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget _default = new MyApp();
  bool status = await SharedPrefManager.getBooleanPreferences() != null;
  if(status == true){
    _default = HomePage();
  }
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ProfileRepo(),),
      ChangeNotifierProvider(
        create: (_) => ChatRepo(),),
    ],
      child: Consumer<ProfileRepo>(
        builder: (ctx, auth, _) => GetMaterialApp(theme: ThemeData(fontFamily: GoogleFonts.karla().fontFamily),
          debugShowCheckedModeBanner: false,
          home: _default,
        )
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashPage(),
    );
  }
}



