import 'package:benimhesabim/utils/moneyManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/snackBar.dart';

class AddExpenseCategory extends StatefulWidget {
  const AddExpenseCategory({Key? key}) : super(key: key);

  @override
  State<AddExpenseCategory> createState() => _AddCategoryCategoryState();
}

class _AddCategoryCategoryState extends State<AddExpenseCategory> {

  TextEditingController categoryName = TextEditingController();
  MoneyManger moneyManger = MoneyManger();

  handleAddInComeCategory(BuildContext context) async{
    if(categoryName.text.isNotEmpty && categoryName.text.length >= 2){
      var category = MoneyManger.dbHelper.getExpenseCategoryQ(categoryName.text);
      if(category == null){
        MoneyManger.dbHelper.addExpenseCategory(categoryName.text);
        return ScaffoldMessenger.of(context).showSnackBar(SnackBarUtil().snackBarSetup(
            "Kategori eklendi!", "Tamam", () {},
            Colors.white));
      }
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBarUtil().snackBarSetup(
              "Eklemek istediğiniz kategori mevcut!", "Tamam", () {},
              Colors.white));
    }
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtil().snackBarSetup(
            "Boş alan bırakmayınız!", "Tamam", () {},
            Colors.white));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gider kategorisi ekle")),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(decoration: InputDecoration(hintText: "Kategori adı"),controller: categoryName),
              SizedBox(height: 35),
              SizedBox(
                  child:ElevatedButton(
                      onPressed: (){handleAddInComeCategory(context);},
                      child: Text("Ekle"))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
