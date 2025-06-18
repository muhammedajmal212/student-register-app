import 'package:flutter/material.dart';

class FirstPartScreen extends StatelessWidget {
  const FirstPartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
            height: screenHeight / 2.5,
            color: const Color(0xFFEDE7F6),
            width: double.infinity,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Color(0xFF673AB7),
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Login to your account",
                  style: TextStyle(
                    color: Color(0xFF673AB7),
                  ),
                )
              ],
            ),
          );
  }
}