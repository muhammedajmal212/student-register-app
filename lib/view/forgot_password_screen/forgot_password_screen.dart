// import 'package:fire_todo_app/widgets/app_button.dart';
// import 'package:fire_todo_app/widgets/constants/constsnts.dart';
// import 'package:fire_todo_app/widgets/textformfield.dart';
// import 'package:flutter/material.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     final TextEditingController emailcontroller = TextEditingController();
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             Container(
//               height: screenHeight / 4,
//               width: double.infinity,
//               color: Colors.white10,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 150,
//                     child: Image.asset("asset/Forgot-password-rafiki.png"),
//                   ),
//                   const Text("Enter e-mail to receive rest link",style: TextStyle(
//                     fontSize: 15,color: textColor,
//                     fontWeight: FontWeight.bold
//                   ),)
//                 ],
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF512DA8).withOpacity(0.4),
//                       offset: const Offset(
//                           0, -4), // Negative Y = shadow appears on top
//                       blurRadius: 10,
//                       spreadRadius: 1,
//                     ),
//                   ],
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(13),
//                       topRight: Radius.circular(13)),
//                   color: seckcolor),
//               child: Column(
//                 children: [
//                   Padding(
//                       padding:
//                           const EdgeInsets.only(top: 30, left: 10, right: 10),
//                       child: AppTextFormField(
//                         controller: emailcontroller,
//                         name: "e-mail",
//                         icon: const Icon(Icons.email),
//                         formfieldColor: wcolor,
//                         validatorFunction: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter your email";
//                           } else if (!emailRegex.hasMatch(value)) {
//                             return "Please enter a valid email";
//                           }
//                           return null;
//                         },
//                       )),
//                   Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: AppButton(
//                         function: () {
//                           if (_formKey.currentState?.validate() ?? false) {
//                             return;
//                           }
//                         },
//                         text: "Reset Password",
//                       ))
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:fire_todo_app/controller/email_password_authentication/email_password_authentication.dart';
import 'package:fire_todo_app/widgets/app_button.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:fire_todo_app/widgets/app_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset:
          true, // Important to let screen adjust for keyboard
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Top static container
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                color: Colors.white10,
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image.asset("asset/Forgot-password-rafiki.png"),
                    ),
                    const Text(
                      "Enter e-mail to receive reset link",
                      style: TextStyle(
                          fontSize: 15,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Remaining space — takes rest of the screen
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF512DA8).withOpacity(0.4),
                          offset: const Offset(0, -4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18)),
                      color: seckcolor),
                  child: SingleChildScrollView(
                    // Scrolls only if needed
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 10, right: 10),
                          child: AppTextFormField(
                            boolValue: true,
                            controller: emailcontroller,
                            name: "e-mail",
                            icon: const Icon(Icons.email),
                            formfieldColor: wcolor,
                            validatorFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!emailRegex.hasMatch(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 100, right: 100),
                          child: AppButton(
                            function: ()async {
                              if (_formKey.currentState?.validate() ?? false) {
                              final authProvider=  Provider.of<EmailPasswordAuthentication>(
                                    context,
                                    listen: false);
                                    final success=await authProvider.resetPassword(context, emailcontroller.text.trim());
                                    if(success){
                                      Navigator.of(context).pop();

                                    }
                                // EmailPasswordAuthentication().resetPassword(
                                //     context, emailcontroller.text.trim());
                                // Navigator.of(context).pop();
                                // Handle password reset here
                              }
                            },
                            text: "Reset Password",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
