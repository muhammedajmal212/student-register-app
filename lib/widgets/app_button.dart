import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? function;
  final String text;

  const AppButton({super.key, required this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: wcolor),
          onPressed: function,
          child: Text(
            text,
            style:const TextStyle(color: textColor),
          )),
    );
  }
}
