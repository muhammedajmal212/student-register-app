import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                children: [
                  Checkbox(
                    checkColor: const Color(0xFF673AB7),
                    activeColor: Colors.white,
                    value: true,
                    onChanged: (value) {},
                  ),
                  const Text(
                    "Remember me",
                    style: TextStyle(fontSize: 15, color: wcolor),
                  ),
                ],
              );
  }
}