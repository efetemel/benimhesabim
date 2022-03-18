import 'package:flutter/material.dart';

import '../constants.dart';

class ExpenseTile extends StatelessWidget {

  double value;
  String name;
  DateTime time;
  String category;

  ExpenseTile(this.value, this.name, this.time,this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.arrow_circle_up,size: 28.0,color: Colors.red[700],),
              SizedBox(width: 4.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name",
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                  Text(
                    "İşlem Tarihi: "+time.day.toString()+"."+time.month.toString()+"."+time.year.toString(),
                    style: TextStyle(
                        fontSize: 15.0
                    ),
                  ),
                  Text(
                    "Kategori: "+category,
                    style: TextStyle(
                        fontSize: 15.0
                    ),
                  ),
                ],
              )

            ],
          ),
          Text(
            "- $value TL",
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700
            ),
          )
        ],
      ),
    );
  }
}
