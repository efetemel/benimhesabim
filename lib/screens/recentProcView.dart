import 'package:benimhesabim/components/expenseCart.dart';
import 'package:benimhesabim/components/inComeCart.dart';
import 'package:flutter/material.dart';
import '../components/expenseTile.dart';
import '../components/inComeTile.dart';
import '../constants.dart';
import '../utils/moneyManager.dart';

class RecentProcView extends StatefulWidget {
  const RecentProcView({Key? key}) : super(key: key);
  
  @override
  State<RecentProcView> createState() => _RecentProcViewState();
}

class _RecentProcViewState extends State<RecentProcView> {

  MoneyManger moneyManger = MoneyManger();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("İşlem Geçmişi"),),
        body: SafeArea(
            child: FutureBuilder<Map>(
              future: MoneyManger.dbHelper.fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                if (snapshot.hasError)
                  return Center(child: CircularProgressIndicator());
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text("Henüz işlem yok!"));
                  }
                  MoneyManger.getTotalBalance(snapshot.data!);
                  return ListView(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.9,
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
                                MoneyManger.totalBalanceStr(
                                    MoneyManger.totalBalance),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 12,),
                              Padding(padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    InComeCart(
                                        MoneyManger.getInComeTotalMount(
                                            snapshot.data!)),
                                    ExpenseCart(
                                        MoneyManger.getExpenseTotalMount(
                                            snapshot.data!))
                                  ],
                                ),),
                            ],
                          ),
                        ),

                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map dataAtIndex = snapshot.data![index];
                          if(dataAtIndex['type'] == "Gider")
                            return ExpenseTile(dataAtIndex["amount"],dataAtIndex["name"],dataAtIndex["date"],dataAtIndex["category"]);
                          else
                            return InComeTile(dataAtIndex["amount"],dataAtIndex["name"],dataAtIndex["date"],dataAtIndex["category"]);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                          ],
                        ),
                      ),

                    ],
                  );
                }
                else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
        )
    );
  }
}