import 'package:benimhesabim/screens/transactions/addTransactionExpenseView.dart';
import 'package:benimhesabim/screens/transactions/addTransactionInComeView.dart';
import 'package:flutter/material.dart';

class CategoryProcView extends StatelessWidget {
  const CategoryProcView({Key? key}) : super(key: key);

  handleAddInCome(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTransaction()));
  }
  handleAddExpense(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTransactionExpenseView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kategori işlemleri")),
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              "₺ +",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: Text("Gelir Kategorisi ekle"),
            onTap: () {handleAddInCome(context);},

          ),
          ListTile(
            leading: Text(
              "₺ -",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: Text("Gelir Kategorisi sil"),
            onTap: () {handleAddExpense(context);},
          ),
          Divider(),
          ListTile(
            leading: Text(
              "₺ +",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: Text("Gider Kategorisi ekle"),
            onTap: () {handleAddInCome(context);},
          ),
          ListTile(
            leading: Text(
              "₺ -",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: Text("Gider Kategorisi sil"),
            onTap: () {handleAddExpense(context);},
          ),
        ],
      ),
    );
  }
}
