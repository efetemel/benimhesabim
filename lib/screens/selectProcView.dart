import 'package:benimhesabim/screens/categories/categoryProcView.dart';
import 'package:benimhesabim/screens/transactions/transactionProcView.dart';
import 'package:benimhesabim/screens/transactions/addTransactionInComeView.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
class AddSelect extends StatelessWidget {
  const AddSelect({Key? key}) : super(key: key);


  handleCategory(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoryProcView()));
  }

  handleTransaction(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TransactionProcView()));

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("İşlem seç")),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Container(
          height: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){
                  handleCategory(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(24.0)
                        )
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.category,size: 32),
                        SizedBox(height: 5),
                        Text(
                          "Kategori\n İşlemleri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22.0
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){
                  handleTransaction(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(24.0)
                        )
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "₺",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Bakiye\n İşlemleri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22.0
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
