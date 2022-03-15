import 'package:flutter/material.dart';
import '../utils/moneyManager.dart';

class InComeCart extends StatelessWidget {
  double value;

  InComeCart(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20.0)
          ),
          padding: const EdgeInsets.all(6.0),
          child: Icon(Icons.arrow_downward,
              size: 28.0,
              color: Colors.green[700]),
          margin: const EdgeInsets.only(
              right: 8.0
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Aylık Gelir",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70
              ),),
            Text(
              MoneyManger.totalBalanceStr(value),
              style: const TextStyle(
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
