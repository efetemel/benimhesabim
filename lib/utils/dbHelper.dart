import 'package:hive/hive.dart';

class DbHelper{
   late Box box;
   late Box boxInCome;
   late Box boxExpense;

   DbHelper(){
     openBox();
   }

   openBox() async{
     box = Hive.box('benimhesabim');
     boxInCome = Hive.box('benimhesabimInCategory');
     boxExpense = Hive.box('benimhesabimExCategory');
   }

   Future addData(double amount,DateTime date,String name,String type,String category) async{
     var value = {
       'amount':amount,
       'date':date,
       'name':name,
       'type':type,
       'category':category
     };
     box.put(date.hour.toString()+"."+date.minute.toString()+"."+date.second.toString(),value);
   }

   Future dellData(DateTime time) async{
     box.delete(time.hour.toString()+"."+time.minute.toString()+"."+time.second.toString());
     //box.add(x);
   }

   Future<Map> fetch(){
     if(box.values.isEmpty){
       return Future.value({});
     }
     else{
       return Future.value(box.toMap());
     }
   }

   Future addInComeCategory(String name) async{
     var val = {
       'name':name,
       'date':DateTime.now()
     };
     boxInCome.add(val);

   }

   dynamic getInComeCategoryQ(String name){
     var exist = null;
     if(boxInCome.values.isEmpty){
       return null;
     }
     else{
       boxInCome.values.forEach((element) {
        if(element["name"] == name){
          exist = name;
        }
       });
       if(exist == name){
         return name;
       }
       return null;
     }
   }

   dynamic getExpenseCategoryQ(String name){
     var exist = null;
     if(boxExpense.values.isEmpty){
       return null;
     }
     else{
       boxExpense.values.forEach((element) {
         if(element["name"] == name){
           exist = name;
         }
       });
       if(exist == name){
         return name;
       }
       return null;
     }
   }

   Future<Map> getInComeCategory(){
     if(boxInCome.values.isEmpty){
       return Future.value({});
     }
     else{
       return Future.value(boxInCome.toMap());
     }
   }

   Future addExpenseCategory(String name) async{
     var val = {
       'name':name,
       'date':DateTime.now()
     };
     boxExpense.add(val);
   }

   Future<Map> getExpenseCategory(){
     if(boxExpense.values.isEmpty){
       return Future.value({});
     }
     else{
       return Future.value(boxExpense.toMap());
     }
   }
}