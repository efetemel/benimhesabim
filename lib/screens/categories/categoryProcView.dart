import 'package:benimhesabim/screens/categories/addExpenseCategory.dart';
import 'package:benimhesabim/screens/categories/addInComeCategory.dart';
import 'package:flutter/material.dart';

class CategoryProcView extends StatelessWidget {
  const CategoryProcView({Key? key}) : super(key: key);

  handleAddInComeCategory(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddInComeCategory()));
  }

  handleAddExpenseCategory(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddExpenseCategory()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategori işlemleri")),
      body: ListView(
        children: [
          ListTile(
            leading: const Text(
              "₺ +",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: const Text("Gelir Kategorisi ekle"),
            onTap: () {handleAddInComeCategory(context);},

          ),
          const Divider(),
          ListTile(
            leading: const Text(
              "₺ -",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title: const Text("Gider Kategorisi ekle"),
            onTap: () {handleAddExpenseCategory(context);},
          ),
        ],
      ),
    );
  }
}
