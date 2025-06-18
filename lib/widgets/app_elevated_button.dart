import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final void Function() function;
  const AppElevatedButton(
      {super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: function,
        child: Text(
          text,
          style:const TextStyle(color: textColor),
        ),
      ),
    );
  }
}
