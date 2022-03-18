import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:benimhesabim/constants.dart';
import 'package:benimhesabim/utils/dbHelper.dart';
import 'package:benimhesabim/utils/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/moneyManager.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

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
        helpText: "Tarih Seçin",
        cancelText: "İptal",
        confirmText: "Seç",
        initialEntryMode: DatePickerEntryMode.calendarOnly);
      if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  List<String> inComeCategory = ["test","test2"];
  String dropValue = "sa";
  MoneyManger moneyManger = MoneyManger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gelir ekle"),),
        body: SafeArea(
      child: FutureBuilder<Map>(
        future: MoneyManger.dbHelper.getInComeCategory(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
          if(snapshot.hasError)
          return Center(child: CircularProgressIndicator());
          if(snapshot.hasData) {
            if(snapshot.data!.isNotEmpty){
              print(snapshot.data);
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: Text(
                        "₺",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight
                            .bold),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                        child: TextFormField(
                          controller: amount,

                          decoration:
                          InputDecoration(
                              hintText: "Örn: 20.23", border: InputBorder.none),
                          style: TextStyle(fontSize: 24.0),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true),
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
                        child: Icon(Icons.category)
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                        child: DropdownButton(
                          value: dropValue,
                          hint: Text("Gelir Kategorisi Seçin"),
                          items: [
                            DropdownMenuItem(child: Text("sa"),value: "sa",)
                          ], onChanged: (value) {  },

                        )
                    ),
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
                        child:
                        Icon(Icons.description, size: 24, color: Colors.white)),
                    SizedBox(width: 12.0),
                    Expanded(
                        child: TextField(
                          controller: name,
                          decoration: InputDecoration(
                              hintText: "İşlem Adı", border: InputBorder.none),
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
                            padding: MaterialStateProperty.all(
                                EdgeInsets.zero)),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10.0)),
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
                          if (amount.text.isNotEmpty && name.text.isNotEmpty) {
                            try {
                              double _amount = double.parse(amount.text);
                              await DbHelper().addData(
                                  _amount, date, name.text, "Gelir");
                              Navigator.of(context).pop();
                            } catch (err) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBarUtil().snackBarSetup(
                                      "Lütfen para miktarını doğru giriniz!",
                                      "Tamam", () {}, Colors.white));
                            }
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarUtil().snackBarSetup(
                                    "Boş alan bırakmayınız!", "Tamam", () {},
                                    Colors.white));
                          }
                        },
                        child: Text(
                          "Ekle",
                          style:
                          TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        )))
              ],
            );


          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    ));
  }

  DropdownMenuItem getCategoryItem(snapshot){
    return snapshot.data!.forEach((key, value) {
      return DropdownMenuItem(child: Text("sa"));
    });
  }
}
