import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
 final  String text;
 const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
