import 'dbHelper.dart';

class MoneyManger{

  static DbHelper dbHelper = DbHelper();

  static DateTime today = DateTime.now();

  static double totalBalance = 0.0;
  static double totalIncome = 0.0;
  static double totalExpense = 0.0;

  static double getExpenseTotalMount(Map entireData){
    double total = 0.0;
    entireData.forEach((key, value) {
      if (value["type"] == "Gider" &&
          (value["date"] as DateTime).month == today.month) {
        total += value["amount"];
      }
    });
    return total;
  }

  static double getInComeTotalMount(Map entireData){
    double total = 0.0;
    entireData.forEach((key, value) {
      if (value["type"] == "Gelir" &&
          (value["date"] as DateTime).month == today.month) {
        total += value["amount"];
      }
    });
    return total;
  }

  static getTotalBalance(Map entireData){

    totalBalance = 0.0;
    totalIncome = 0.0;
    totalExpense = 0.0;

    entireData.forEach((key, value) {
      if(value['type'] == "Gelir"){
        totalBalance += value['amount'];
        totalIncome += value['amount'];
      }
      else{
        totalBalance -= value['amount'];
        totalExpense += value['amount'];
      }
    });
  }

  static String totalBalanceStr(double val){
    String balanceDotAfter = val.toString().split('.').last;
    String balanceDotBefore = val.toString().split('.').first;
    if(balanceDotAfter.isNotEmpty && balanceDotAfter.length >= 2){
      balanceDotAfter = balanceDotAfter.substring(0,2);
    }
    return balanceDotBefore+"."+balanceDotAfter+" TL";
  }


}