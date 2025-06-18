import 'package:fire_todo_app/controller/phone_number_otp_authentication/phone_number_otp_authentication.dart';
import 'package:fire_todo_app/view/home_screen/home_screen.dart';
import 'package:fire_todo_app/view/student_registration_screen/student_registration_screen.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpScreen({super.key, required this.verificationId,required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<PhoneNumberOtpAuthentication>(context);
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        authProvider.setLoading(false);
        Navigator.of(context).pop();
        
      }, icon: Icon(Icons.arrow_back)),),


      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "    Verify your\n phone number",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Enter you otp code here"),
            const SizedBox(
              height: 10,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: const Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (otpCode) async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otpCode);
                  final UserCredential = await FirebaseAuth.instance
                      .signInWithCredential(credential);
                  if (UserCredential.user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Phone number verified successfully")),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (ctx) => HomeScreen()),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Verification failed: $e")),
                  );
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Didn't you receive any code?"),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: ()async {
                final authProvider = Provider.of<PhoneNumberOtpAuthentication>(context, listen: false);
                await authProvider.resendOtp(phoneNumber, context);
                
              },
              child: const Text(
                "RESEND NEW CODE",
                style: TextStyle(
                    color: textColor, fontSize: 20, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      )),
    );
  }
}
