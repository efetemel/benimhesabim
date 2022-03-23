import 'package:benimhesabim/screens/transactions/addTransactionExpenseView.dart';
import 'package:benimhesabim/screens/transactions/addTransactionInComeView.dart';
import 'package:benimhesabim/utils/settings.dart';
import 'package:flutter/material.dart';

class TransactionProcView extends StatelessWidget {

  String name;


  TransactionProcView(this.name);

  handleAddInCome(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransaction(name)));
  }
  handleAddExpense(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransactionExpenseView(name)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(Settings.balanceProccessText_)),
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              "₺ +",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: Text(Settings.addInComeTransactionText),
            onTap: () {handleAddInCome(context);},
          ),
          ListTile(
            leading: Text(
              "₺ -",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: Text(Settings.addExpenseTransactionText),
            onTap: () {handleAddExpense(context);},
          ),
        ],
      ),
    );
  }
}
