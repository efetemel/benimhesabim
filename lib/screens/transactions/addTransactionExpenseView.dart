

import 'package:benimhesabim/constants.dart';
import 'package:benimhesabim/screens/categories/addExpenseCategory.dart';
import 'package:benimhesabim/screens/categories/addInComeCategory.dart';
import 'package:benimhesabim/screens/homeView.dart';
import 'package:benimhesabim/utils/dbHelper.dart';
import 'package:benimhesabim/utils/settings.dart';
import 'package:benimhesabim/utils/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/moneyManager.dart';

class AddTransactionExpenseView extends StatefulWidget {
  String name;


  AddTransactionExpenseView(this.name);

  @override
  State<AddTransactionExpenseView> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransactionExpenseView> {
  final amount = TextEditingController();
  final name = TextEditingController();
  DateTime date = DateTime.now();

  List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020, 12),
        lastDate: DateTime(DateTime.now().year + 3, 12),
        helpText: Settings.selectDateText,
        cancelText: Settings.cancelText,
        confirmText: Settings.selectText,
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  List<String> expenseCategory = [];
  String dropValue = "";
  MoneyManger moneyManger = MoneyManger();

  handleAddExpenseCategory(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const AddExpenseCategory()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Settings.addExpenseTransactionText),
        ),
        body: SafeArea(
            child: FutureBuilder<Map>(
              future: MoneyManger.dbHelper.getExpenseCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                if (snapshot.hasError)
                  return Center(child: CircularProgressIndicator());
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    if (expenseCategory.isEmpty ||
                        expenseCategory.length != snapshot.data!.length) {
                      snapshot.data!.values.forEach((element) {
                        expenseCategory.add(element["name"]);
                      });
                      dropValue = expenseCategory.first.isNotEmpty
                          ? expenseCategory.first
                          : "";
                    }
                  }
                  return ListView(
                    padding: EdgeInsets.all(12.0),
                    children: [
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                            child: Text(
                              "₺",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                              child: TextFormField(
                                controller: amount,
                                decoration: InputDecoration(
                                    hintText: Settings.exmpBalanceHintText, border: InputBorder.none),
                                style: TextStyle(fontSize: 24.0),
                                keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                              )),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Icon(Icons.category)),
                          SizedBox(width: 12.0),
                          dropValue != ""
                              ? Expanded(
                              child: DropdownButton<String>(
                                value: dropValue,
                                hint: new Text(
                                  Settings.selectDateText,
                                  style: TextStyle(fontFamily: "Gotham"),
                                ),
                                items: expenseCategory.map((purposeTemp) {
                                  return new DropdownMenuItem<String>(
                                    value: purposeTemp,
                                    child: new Text(
                                      purposeTemp,
                                      style: TextStyle(fontFamily: "Gotham"),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (purpose) {
                                  setState(() {
                                    dropValue = purpose!;
                                  });
                                },
                              ))
                              : Container(
                              child: TextButton(
                                  onPressed: () {
                                    handleAddExpenseCategory(context);
                                  },
                                  child: Text(Settings.addExpenseCategoryText))),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Icon(Icons.description,
                                  size: 24, color: Colors.white)),
                          SizedBox(width: 12.0),
                          Expanded(
                              child: TextField(
                                controller: name,
                                decoration: InputDecoration(
                                    hintText: Settings.proccessNameHintText, border: InputBorder.none),
                                style: TextStyle(fontSize: 24.0),
                                maxLength: 24,
                              )),
                        ],
                      ),
                      SizedBox(
                          height: 50.0,
                          child: TextButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              style: ButtonStyle(
                                  padding:
                                  MaterialStateProperty.all(EdgeInsets.zero)),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                          BorderRadius.circular(10.0)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Icon(Icons.date_range_rounded,
                                          size: 24, color: Colors.white)),
                                  SizedBox(width: 12.0),
                                  Text("${date.day} ${months[date.month - 1]}"),
                                ],
                              ))),
                      SizedBox(height: 20.0),
                      SizedBox(
                          height: 50.0,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (amount.text.isNotEmpty &&
                                    name.text.isNotEmpty) {
                                  try {
                                    double _amount = double.parse(amount.text);
                                    await DbHelper()
                                        .addData(_amount, date, name.text, "Gider",dropValue);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomeScreen(widget.name)),
                                          (Route<dynamic> route) => false,
                                    );
                                  } catch (err) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBarUtil().snackBarSetup(
                                            Settings.invalidMoneyText,
                                            Settings.okButtonText,
                                                () {},
                                            Colors.white));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBarUtil().snackBarSetup(
                                          Settings.emptyFieldsText,
                                          Settings.okButtonText,
                                              () {},
                                          Colors.white));
                                }
                              },
                              child: Text(
                                Settings.addButtonText,
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.w600),
                              )))
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )));
  }
}
