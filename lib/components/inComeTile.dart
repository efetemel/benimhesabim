import 'package:flutter/material.dart';

import '../constants.dart';

class InComeTile extends StatelessWidget {

  double value;
  String name;
  String category;
  DateTime time;

  InComeTile(this.value, this.name, this.time,this.category, {Key? key}) : super(key: key);

  List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(time.day.toString(),style: TextStyle(fontSize: 22)),
            Text(months[time.month-1]),
          ],
        ),
        title: Text(name,style: TextStyle(fontWeight: FontWeight.w700),),
        subtitle: Text("Kategori: "+category,style: TextStyle(color: Colors.white),),
        trailing: Text("+"+value.toString()+" TL",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.green[500])),
      )
    );
  }
}