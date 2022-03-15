import 'package:flutter/material.dart';

import '../constants.dart';

class InComeTile extends StatelessWidget {

  double value;
  String name;
  DateTime time;

  InComeTile(this.value, this.name, this.time, {Key? key}) : super(key: key);

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
              Icon(Icons.arrow_circle_down,size: 28.0,color: Colors.green[700],),
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
                    time.day.toString()+"."+time.month.toString()+"."+time.year.toString(),
                    style: TextStyle(
                        fontSize: 15.0
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(
            "+ $value TL",
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
