import 'package:fire_todo_app/view/login_screen/widgets/first_part_screen.dart';
import 'package:fire_todo_app/view/login_screen/widgets/second_part_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: screenHeight,
            ),
            const FirstPartScreen(),
            Positioned(
              top: screenHeight / 2.5 - 40,
              bottom: 0,
              left: 0,
              right: 0,
              child: const SecondPartScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
