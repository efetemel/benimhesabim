import 'package:benimhesabim/utils/moneyManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/settings.dart';
import '../../utils/snackBar.dart';

class AddInComeCategory extends StatefulWidget {
  const AddInComeCategory({Key? key}) : super(key: key);

  @override
  State<AddInComeCategory> createState() => _AddInComeCategoryState();
}

class _AddInComeCategoryState extends State<AddInComeCategory> {

  TextEditingController categoryName = TextEditingController();
  MoneyManger moneyManger = MoneyManger();

  handleAddInComeCategory(BuildContext context) async{
    if(categoryName.text.isNotEmpty && categoryName.text.length >= 2){
      var category = MoneyManger.dbHelper.getInComeCategoryQ(categoryName.text);
      if(category == null){
        MoneyManger.dbHelper.addInComeCategory(categoryName.text);
        setState(() {

        });
        Navigator.pop(context);
        return ScaffoldMessenger.of(context).showSnackBar(SnackBarUtil().snackBarSetup(
            Settings.addedCategoryText, Settings.okButtonText, () {},
            Colors.white));
      }
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBarUtil().snackBarSetup(
              Settings.categoryIsExistText, Settings.okButtonText, () {},
              Colors.white));
    }
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBarUtil().snackBarSetup(
            Settings.emptyFieldsText, Settings.okButtonText, () {},
            Colors.white));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Settings.addInComeCategoryText)),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(decoration: InputDecoration(hintText: Settings.addCategoryHintText),controller: categoryName),
              SizedBox(height: 35),
              SizedBox(
                  child:ElevatedButton(
                      onPressed: (){handleAddInComeCategory(context);},
                      child: Text(Settings.addButtonText))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
