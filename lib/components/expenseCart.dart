import 'package:flutter/material.dart';
import '../utils/moneyManager.dart';

class ExpenseCart extends StatelessWidget {
  double value;

  ExpenseCart(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20.0)
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(Icons.arrow_upward,
              size: 28.0,
              color: Colors.red[700]),
          margin: EdgeInsets.only(
              right: 8.0
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Aylık Gider",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70
              ),),
            Text(
              MoneyManger.totalBalanceStr(value),
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70
              ),)
          ],
        )
      ],
    );
  }

}
