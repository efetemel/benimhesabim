import 'package:flutter/material.dart';

class SnackBarUtil{

  snackBarSetup(String content,String label,void Function() onPress,Color color){
    return SnackBar(
      content: Text(content),
      backgroundColor: color,
      action: SnackBarAction(
        label: label,
        onPressed: onPress,
      ),
    );
  }

}