import 'package:benimhesabim/components/expenseCart.dart';
import 'package:benimhesabim/components/expenseTile.dart';
import 'package:benimhesabim/components/inComeCart.dart';
import 'package:benimhesabim/components/inComeTile.dart';
import 'package:benimhesabim/screens/selectProcView.dart';
import 'package:benimhesabim/screens/recentProcView.dart';
import 'package:benimhesabim/utils/moneyManager.dart';
import 'package:benimhesabim/utils/settings.dart';
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  AddSelect(widget.name))).whenComplete(() {setState(() {

          });});
        },
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: const Icon(Icons.add,size: 32.0),
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
                return  Center(child: Text(Settings.proccessNotFoundText));
              }
              MoneyManger.getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [

                            const SizedBox(width: 8.0),
                            Text("${Settings.welcomeText}, ${widget.name}",
                            style: const TextStyle(
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
                    margin: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.0)
                        )
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 8.0
                      ),
                      child: Column(
                        children: [
                          Text(
                            Settings.totalBalanceText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0
                            ),
                          ),
                          Text(
                            MoneyManger.totalBalanceStr(MoneyManger.totalBalance),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 22.0,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          const SizedBox(height: 12,),
                          Padding(padding: const EdgeInsets.all(8.0),
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
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      Settings.recentProccessText,
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
                        return ExpenseTile(dataAtIndex["amount"],dataAtIndex["name"],dataAtIndex["date"],dataAtIndex["category"]);
                      else
                        return InComeTile(dataAtIndex["amount"],dataAtIndex["name"],dataAtIndex["date"],dataAtIndex["category"]);

                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child:ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RecentProcView()));
                      },
                      child:  Text(Settings.moreViewText),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(secondaryColor)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            SizedBox(width: 8.0,height: 55,),
                          ],
                        ),
                      ],
                    ),
                  ),



                ],
              );
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
      )
    );
  }

}

