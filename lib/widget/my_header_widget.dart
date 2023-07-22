import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.title}) : super(key: key);
final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
