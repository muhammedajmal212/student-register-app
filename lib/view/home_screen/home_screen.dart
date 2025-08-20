import 'package:fire_todo_app/controller/google_sign_in_provider.dart';
import 'package:fire_todo_app/controller/phone_number_otp_authentication/phone_number_otp_authentication.dart';
import 'package:fire_todo_app/controller/student_controller/student_controller.dart';
import 'package:fire_todo_app/view/home_screen/widgets/list_view_widget.dart';
import 'package:fire_todo_app/view/login_screen/login_screen.dart';
import 'package:fire_todo_app/view/login_screen/widgets/app_outlined_button.dart';
import 'package:fire_todo_app/view/student_registration_screen/student_registration_screen.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of<StudentController>(context, listen: false)
    //     .getStudentRecordStream();
    final authProvider = Provider.of<PhoneNumberOtpAuthentication>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              authProvider.setLoading(false);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Home"),
        actions: [
          AppOutlinedButton(
              icon: const Icon(Icons.logout),
              function: () async {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                await provider.logOut(context);
              }),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 60, // make it square
        height: 60,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(8), // change to 0 for perfect square
              side: const BorderSide(color: seckcolor, width: 2),
            ),
            backgroundColor: Colors.white,
            padding: EdgeInsets.zero, // remove extra padding
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const StudentRegistrationScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: seckcolor,
            size: 30,
          ),
        ),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.hasData) {
            return Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: const ListViewWidget());
          } else {
            // User is not signed in
            Future.microtask(() {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            });
            return const SizedBox();
          }
        },
      ),
    );
  }
}
