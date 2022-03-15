import 'package:flutter/material.dart';

import '../constants.dart';
import 'dbHelper.dart';

class MoneyManger{
  static DbHelper dbHelper = DbHelper();

  static DateTime today = DateTime.now();

  static double totalBalance = 0.0;
  static double totalIncome = 0.0;
  static double totalExpense = 0.0;

  static double getExpenseTotalMount(Map entireData){
    double total = 0.0;
    entireData.forEach((key, value) {
      if (value["type"] == "Gider" &&
          (value["date"] as DateTime).month == today.month) {
        total += value["amount"];
      }
    });
    return total;
  }

  static double getInComeTotalMount(Map entireData){
    double total = 0.0;
    entireData.forEach((key, value) {
      if (value["type"] == "Gelir" &&
          (value["date"] as DateTime).month == today.month) {
        total += value["amount"];
      }
    });
    return total;
  }

  static getTotalBalance(Map entireData){

    totalBalance = 0.0;
    totalIncome = 0.0;
    totalExpense = 0.0;

    entireData.forEach((key, value) {
      if(value['type'] == "Gelir"){
        totalBalance += value['amount'];
        totalIncome += value['amount'];
      }
      else{
        totalBalance -= value['amount'];
        totalExpense += value['amount'];
      }
    });
  }

  static String totalBalanceStr(double val){
    String balanceDotAfter = val.toString().split('.').last;
    String balanceDotBefore = val.toString().split('.').first;
    if(balanceDotAfter.isNotEmpty && balanceDotAfter.length >= 2){
      balanceDotAfter = balanceDotAfter.substring(0,2);
    }
    return balanceDotBefore+"."+balanceDotAfter+" TL";
  }

  Widget cardIncome(double value){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20.0)
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(Icons.arrow_downward,
              size: 28.0,
              color: Colors.green[700]),
          margin: EdgeInsets.only(
              right: 8.0
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Aylık Gelir",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70
              ),),
            Text(
              MoneyManger.totalBalanceStr(value),
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70
              ),)
          ],
        )
      ],
    );
  }

  Widget cardExpense(double value){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20.0)
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(Icons.arrow_upward,
              size: 28.0,
              color: Colors.red[700]),
          margin: EdgeInsets.only(
              right: 8.0
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Aylık Gider",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70
              ),),
            Text(
              MoneyManger.totalBalanceStr(value),
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70
              ),)
          ],
        )
      ],
    );
  }

  Widget expenseTile(double value,String name,DateTime time){
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

  Widget incomeTile(double value,String name,DateTime time){
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