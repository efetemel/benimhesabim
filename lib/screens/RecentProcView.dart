import 'package:benimhesabim/components/addTransaction.dart';
import 'package:benimhesabim/models/expense.dart';
import 'package:benimhesabim/screens/RecentProcView.dart';
import 'package:benimhesabim/utils/dbHelper.dart';
import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class RecentProcView extends StatefulWidget {


  @override
  State<RecentProcView> createState() => _RecentProcViewState();
}

class _RecentProcViewState extends State<RecentProcView> {

  DbHelper dbHelper = DbHelper();

  DateTime today = DateTime.now();

  double totalBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  List<FlSpot> dataSetExpense = [];
  List<FlSpot> dataSetInCome = [];

  List<FlSpot> getExpensePlotPoints(Map entireData){

    dataSetExpense = [];
    entireData.forEach((key, value) {
      if(value["type"] == "Gider" && (value["date"] as DateTime).month == today.month){
        dataSetExpense.add(
            FlSpot(
              (value["date"] as DateTime).day.toDouble(),
              (value["amount"] as double).toDouble(),
            )
        );
      }
    });

    return dataSetExpense;
  }

  double getExpenseTotalMount(Map entireData){
    double total = 0.0;
    entireData.forEach((key, value) {
      if (value["type"] == "Gider" &&
          (value["date"] as DateTime).month == today.month) {
        total += value["amount"];
      }
    });
    return total;
  }

  double getInComeTotalMount(Map entireData){
    double total = 0.0;
    entireData.forEach((key, value) {
      if (value["type"] == "Gelir" &&
          (value["date"] as DateTime).month == today.month) {
        total += value["amount"];
      }
    });
    return total;
  }

  List<FlSpot> getInComePlotPoints(Map entireData){

    dataSetInCome = [];
    entireData.forEach((key, value) {
      if(value["type"] == "Gelir" && (value["date"] as DateTime).month == today.month){
        dataSetInCome.add(
            FlSpot(
              (value["date"] as DateTime).day.toDouble(),
              (value["amount"] as double).toDouble(),
            )
        );
      }
    });

    return dataSetInCome;
  }

  getTotalBalance(Map entireData){

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("İşlem Geçmişi"),),
        body: SafeArea(
            child: FutureBuilder<Map>(
              future: dbHelper.fetch(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                if(snapshot.hasError)
                  return Center(child: CircularProgressIndicator());
                if(snapshot.hasData){
                  if(snapshot.data!.isEmpty){
                    return Center(child: Text("Henüz işlem yok!"));
                  }
                  getTotalBalance(snapshot.data!);
                  getExpensePlotPoints(snapshot.data!);
                  getInComePlotPoints(snapshot.data!);
                  return ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(24.0)
                              )
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 8.0
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Toplam Bakiye",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22.0
                                ),
                              ),
                              Text(
                                Decimal.parse(totalBalance.toString()).toString() + " TL",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 12,),
                              Padding(padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    cardIncome(getInComeTotalMount(snapshot.data!)),
                                    cardExpense(getExpenseTotalMount(snapshot.data!))
                                  ],
                                ),)
                            ],
                          ),
                        ),

                      ),


                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Son İşlemler",
                          style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          Map dataAtIndex = snapshot.data![index];
                          if(dataAtIndex['type'] == "Gider")
                            return expenseTile(dataAtIndex["amount"],dataAtIndex["name"],dataAtIndex["date"]);
                          else
                            return incomeTile(dataAtIndex["amount"],dataAtIndex["name"],dataAtIndex["date"]);

                        },
                      ),


                    ],
                  );
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
        )
    );
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
              Decimal.parse(totalIncome.toString()).toString() + " TL",
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
              Decimal.parse(totalExpense.toString()).toString() + " TL",
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
                    time.hour.toString()+":"+time.minute.toString()+" " +time.day.toString()+"."+time.month.toString()+"."+time.year.toString(),
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
                    time.hour.toString()+":"+time.minute.toString()+" " +time.day.toString()+"."+time.month.toString()+"."+time.year.toString(),
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


//https://youtu.be/VOWy5-zTeWk?t=4790