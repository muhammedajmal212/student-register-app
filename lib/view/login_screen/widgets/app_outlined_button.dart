import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final void Function()? function;

  final Widget icon;
  const AppOutlinedButton({
    super.key,
    required this.icon,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1, color: wcolor)),
        onPressed:function,
        child: icon);
  }
}
