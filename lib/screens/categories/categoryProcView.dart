import 'package:benimhesabim/screens/categories/addExpenseCategory.dart';
import 'package:benimhesabim/screens/categories/addInComeCategory.dart';
import 'package:flutter/material.dart';

import '../../utils/settings.dart';

class CategoryProcView extends StatelessWidget {

  String name;


  CategoryProcView(this.name);

  handleAddInComeCategory(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddInComeCategory()));
  }

  handleAddExpenseCategory(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddExpenseCategory()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Settings.categoryProccessText_)),
      body: ListView(
        children: [
          ListTile(
            leading: const Text(
              "₺ +",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title:  Text(Settings.addInComeCategoryText),
            onTap: () {handleAddInComeCategory(context);},

          ),
          const Divider(),
          ListTile(
            leading: const Text(
              "₺ -",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            title:  Text(Settings.addExpenseCategoryText),
            onTap: () {handleAddExpenseCategory(context);},
          ),
        ],
      ),
    );
  }
}
