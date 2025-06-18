import 'dart:developer';

import 'package:fire_todo_app/controller/phone_number_otp_authentication/phone_number_otp_authentication.dart';
import 'package:fire_todo_app/view/phone_Screen/otp_screen.dart';
import 'package:fire_todo_app/widgets/app_elevated_button.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String phoneNumber = "";
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final authProvider = Provider.of<PhoneNumberOtpAuthentication>(context);
    //  final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: firstkcolor,
        title: const Text(
          'Phone Login',
          style: TextStyle(color: textColor),
        ),
      ),
      body: Stack(children: [
        Container(
          color: seckcolor,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: firstkcolor,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Welcome Back 👋",
                            style: TextStyle(
                              fontSize: 24,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Add your phone number. We'll send you a verification code so we know you're real.",
                            style: TextStyle(
                              fontSize: 15,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Phone Field
                  IntlPhoneField(
                    // disableLengthCheck: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Phone Number",
                      hintStyle: const TextStyle(color: textColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber.trim();
                    },
                    validator: (value) {
                      if (value == null || value.number.trim().isEmpty) {
                        return "Please enter your phone number";
                      }
                      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(pattern);

                      if (!regExp.hasMatch(value.number.trim())) {
                        return "Please enter a valid phone number";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Send OTP Button
                  Center(
                    child: AppElevatedButton(
                      text: "Get Otp",
                      function: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          authProvider.createAccountWithPhoneNumber(
                              phoneNumber, context);
                        }
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (ctx) => const OtpScreen()),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (authProvider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),

      ]),
    );
  }
}
