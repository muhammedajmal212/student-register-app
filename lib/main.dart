import 'package:fire_todo_app/controller/email_password_authentication/email_password_authentication.dart';
import 'package:fire_todo_app/controller/google_sign_in_provider.dart';
import 'package:fire_todo_app/controller/phone_number_otp_authentication/phone_number_otp_authentication.dart';
import 'package:fire_todo_app/view/home_screen/home_screen.dart';
import 'package:fire_todo_app/view/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fire_todo_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.setLanguageCode("en");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) => EmailPasswordAuthentication(),
        ),
        ChangeNotifierProvider(create: (context)=>PhoneNumberOtpAuthentication())

      ],
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home:
                  snapshot.hasData ? const HomeScreen() : const LoginScreen());
        },
      ),
    );
  }
}
