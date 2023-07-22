import 'package:flutter/material.dart';

class MyShowSnackBar{
  static void errorSnackBar(BuildContext context,String errorMessage){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red, // Customize the background color for errors
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        )
    );
  }
}