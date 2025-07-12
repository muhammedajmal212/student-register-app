import 'package:flutter/material.dart';

const Color wcolor = Colors.white;
const Color textColor = Color(0xFF673AB7);
const Color seckcolor = Color(0xFF673AB7);
const Color firstkcolor = Color(0xFFEDE7F6);
const Color kshadow = Color(0xFFEDE7F6);

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
