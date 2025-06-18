// import 'dart:developer';
// import 'package:fire_todo_app/view/home_screen/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/material.dart'; // Make sure you import Material

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//   GoogleSignInAccount get user => _user!;

//   Future googleLogin(BuildContext context) async {
//     try {
//       final googleUser = await googleSignIn.signIn();
//       if (googleUser == null) return; // User cancelled login

//       _user = googleUser;
//       final googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Sign in to Firebase
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       notifyListeners();

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ), // Replace login screen with HomeScreen
//       );
//       return true;
//     } catch (e) {
//       log("google login error $e");
//       return false;
//     }

//   }
// Future logOut()async{
//   await googleSignIn.disconnect();
//   FirebaseAuth.instance.signOut();
// }
// }

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fire_todo_app/view/home_screen/home_screen.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future<bool> googleLogin(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false; // User cancelled login

      _user = googleUser;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);

      notifyListeners();

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }

      return true;
    } catch (e) {
      log("Google login error: $e");
      return false;
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      // await _googleSignIn.disconnect(); 
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      //  await FirebaseAuth.instance.currentUser?.delete();
      _user = null;
      notifyListeners();

      log("User signed out successfully.");
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      log("Logout error: $e");
    }
  }

  
}
