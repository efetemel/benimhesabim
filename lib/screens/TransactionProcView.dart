import 'package:benimhesabim/screens/addTransactionExpenseView.dart';
import 'package:benimhesabim/screens/addTransactionInComeView.dart';
import 'package:flutter/material.dart';

class TransactionProcView extends StatelessWidget {
  const TransactionProcView({Key? key}) : super(key: key);

  handleAddInCome(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTransaction()));
  }
  handleAddExpense(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTransactionExpenseView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bakiye işlemleri")),
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              "₺ +",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: Text("Gelir ekle"),
            onTap: () {handleAddInCome(context);},
          ),
          ListTile(
            leading: Text(
              "₺ -",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: Text("Gider ekle"),
            onTap: () {handleAddExpense(context);},
          ),
        ],
      ),
    );
  }
}
