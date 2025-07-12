import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final Widget prefixIcon;
  final Widget? sufixIcon;
  final String name;
  final Color formfieldColor;
  final TextEditingController controller;
  final String? Function(String?)? validatorFunction;
  final bool boolValue;

  const AppTextFormField(
      {super.key,
      required this.controller,
      required this.name,
      required this.prefixIcon,
      this.sufixIcon,
      required this.formfieldColor,
      this.validatorFunction,
      required this.boolValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      autocorrect: false,
      validator: validatorFunction,
      obscureText: boolValue,
      controller: controller,
      decoration: InputDecoration(
        hoverColor: seckcolor,
        errorStyle: const TextStyle(color: Colors.white),
        fillColor: formfieldColor,
        filled: true,
        suffixIcon: sufixIcon,
        prefixIcon: prefixIcon,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        hintText: name,
        hintStyle: const TextStyle(
          color: Color(0xFF673AB7),
        ),
      ),
    );
  }
}
