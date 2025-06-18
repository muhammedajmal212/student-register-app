import 'package:fire_todo_app/view/home_screen/home_screen.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailPasswordAuthentication extends ChangeNotifier {
  Future<void> createAccount(
      dynamic email, dynamic password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("password is too weak");
      } else if (e.code == "email-already-in-use") {
        print("The account already exists");
      }
      showSnackbar(context, e.message!);
    }
  }

  void loginWithEmail(
      BuildContext context, dynamic email, dynamic password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }

      showSnackbar(context, e.message ?? 'Login failed');
    }
  }

  Future<bool> resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackbar(context, "Password reset link sent to your email.");
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message ?? "An error occurred");
      return false;
    }
  }
}
