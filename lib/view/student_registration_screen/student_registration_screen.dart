import 'package:fire_todo_app/controller/phone_number_otp_authentication/phone_number_otp_authentication.dart';
import 'package:fire_todo_app/view/student_registration_screen/widgets/register_form_fields.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentRegistrationScreen extends StatelessWidget {
  const StudentRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<PhoneNumberOtpAuthentication>(context);
 
    return Scaffold(
      backgroundColor: seckcolor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            authProvider.setLoading(false);

            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text("Add Student Record"),
        titleTextStyle: const TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 20, right: 20, top: 80),
          child:RegisterFormFields()
        ),
      ),
    );
  }
}
