import 'package:benimhesabim/screens/homeView.dart';
import 'package:benimhesabim/screens/welcomeView.dart';
import 'package:benimhesabim/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

SharedPreferences? prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('benimhesabim');
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Benim Hesabım',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home:checkFirstOpen(),
    );
  }

  checkFirstOpen(){
    final bool? firstOpen = prefs!.getBool('firstOpen');
    final String? name = prefs!.getString('name');
    if(firstOpen == null || firstOpen == true){
      return WelcomeScreen();
    }
    return HomeScreen(name!);
  }

}