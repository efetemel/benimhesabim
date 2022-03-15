import 'package:benimhesabim/components/expenseCart.dart';
import 'package:benimhesabim/components/expenseTile.dart';
import 'package:benimhesabim/components/inComeCart.dart';
import 'package:benimhesabim/components/inComeTile.dart';
import 'package:benimhesabim/screens/addTransactionView.dart';
import 'package:benimhesabim/screens/recentProcView.dart';
import 'package:benimhesabim/utils/moneyManager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  String name;

  HomeScreen(this.name, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  MoneyManger moneyManger = MoneyManger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTransaction())).whenComplete(() {setState(() {

          });});
        },
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Icon(Icons.add,size: 32.0),
      ),
      body: SafeArea(
        child: FutureBuilder<Map>(
          future: MoneyManger.dbHelper.fetch(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if(snapshot.hasError)
              return Center(child: CircularProgressIndicator());
            if(snapshot.hasData){
              if(snapshot.data!.isEmpty){
                return Center(child: Text("Henüz işlem yok!"));
              }
              MoneyManger.getTotalBalance(snapshot.data!);

              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [

                            SizedBox(width: 8.0),
                            Text("Hoşgeldin, ${widget.name}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),)
                          ],
                        ),

                      ],
                    ),
                  ),
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
                            MoneyManger.totalBalanceStr(MoneyManger.totalBalance),
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
                              InComeCart(MoneyManger.getInComeTotalMount(snapshot.data!)),
                              ExpenseCart(MoneyManger.getExpenseTotalMount(snapshot.data!))
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
                    itemCount: snapshot.data!.length >= 5  ? 5 : snapshot.data!.length,
                    itemBuilder: (context,index){
                      Map dataAtIndex = snapshot.data![index];
                      if(dataAtIndex['type'] == "Gider")
                        return ExpenseTile(dataAtIndex["amount"],dataAtIndex["name"],dataAtIndex["date"]);
                      else
                        return InComeTile(dataAtIndex["amount"],dataAtIndex["name"],dataAtIndex["date"]);

                    },
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child:ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecentProcView()));
                      },
                      child: Text("Daha Fazla Göster"),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(secondaryColor)),),
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

}

