import 'package:hive/hive.dart';

class DbHelper{
   late Box box;

   DbHelper(){
     openBox();
   }

   openBox(){
     box = Hive.box('benimhesabim');
   }

   Future addData(double amount,DateTime date,String name,String type) async{
     var value = {
       'amount':amount,
       'date':date,
       'name':name,
       'type':type
     };
     box.add(value);
   }

   Future<Map> fetch(){
     if(box.values.isEmpty){
       return Future.value({});
     }
     else{
       return Future.value(box.toMap());
     }
   }
}