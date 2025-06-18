// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return const Center(
//                   child: Text("Something Went Wrong"),
//                 );
//               } else if (snapshot.hasData) {
//                 return Container(
//                   color:const Color.fromARGB(255, 213, 87, 108),
//                   width: double.infinity,
//                   height: double.infinity,
//                   child
//                 );
//               } else {
//                 return Container(
//                   color: Colors.blue,
//                   width: double.infinity,
//                   height: double.infinity,
//                 );
//               }
//             }));
//   }
// }
import 'package:fire_todo_app/controller/google_sign_in_provider.dart';
import 'package:fire_todo_app/controller/phone_number_otp_authentication/phone_number_otp_authentication.dart';
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
     final authProvider = Provider.of<PhoneNumberOtpAuthentication>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          authProvider.setLoading(false);

        }, icon: const Icon(Icons.arrow_back)),
        title: const Text("Home"),
        actions: [
          AppOutlinedButton(
              icon: const Icon(Icons.logout),
              function: ()async {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
              await provider.logOut(context);
              }),
        ],
      ),
      floatingActionButton: IconButton.outlined(
        iconSize: 50,
        color: seckcolor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const StudentRegistrationScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
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
              child: ListView.separated(itemBuilder: (context, index) => ListTile(
                leading: Text("hi"),
              ), separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount:10),
            );
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
