import 'package:benimhesabim/screens/homeScreen.dart';
import 'package:benimhesabim/utils/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WelcomeScreen extends StatelessWidget {

  TextEditingController name = TextEditingController();


  handleLogin(context) async{
    final prefs = await SharedPreferences.getInstance();

    if(name.text.isNotEmpty){
      await prefs.setBool('firstOpen', false);
      await prefs.setString('name', name.text);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(name.text)),
            (Route<dynamic> route) => false,
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBarUtil().snackBarSetup("Lütfen adınızı giriniz", "Tamam", () { }, Colors.white));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("Selam",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold)),
                SizedBox(height: 5,),
                Text("Benim Hesabım uygulamasına hoşgeldiniz.",style: TextStyle(fontSize: 20),textAlign: TextAlign.center),
                SizedBox(height: 5,),
              ],
            ),
            Column(
              children: [
                Text("Size hitap edebilmemiz için adınızı söyler misiniz?",style: TextStyle(fontSize: 20),textAlign: TextAlign.center),
                SizedBox(height: 5),
                TextField(controller: name,decoration: InputDecoration(hintText: "Örn. Ahmet")),
                SizedBox(height: 20),
                ElevatedButton(onPressed: (){handleLogin(context);}, child: Text("Tamam"))
              ],
            ),
            Text("2022 FROM BENIM HESABIM",style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}
