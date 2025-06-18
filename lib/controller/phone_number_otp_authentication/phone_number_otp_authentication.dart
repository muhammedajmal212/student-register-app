import 'package:fire_todo_app/view/phone_Screen/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumberOtpAuthentication extends ChangeNotifier {
  String? _verificationId;
  int? _resendToken;

  String? get verificationId => _verificationId;
  int? get resendToken => _resendToken;

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> createAccountWithPhoneNumber(
      String phoneNumber, BuildContext context) async {
    setLoading(true);
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          verificationCompleted: (_) => setLoading(false),
          verificationFailed: (error) {
            setLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Verification failed: ${error.message}")),
            );
          },
          codeSent: (verificationId, resendToken) {
            _verificationId = verificationId;
            _resendToken = resendToken;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => OtpScreen(
                      phoneNumber: phoneNumber,
                      verificationId: verificationId,
                    )));
          },
          codeAutoRetrievalTimeout: (verificationId) {
            _verificationId = verificationId;
          },
          forceResendingToken: _resendToken,
          phoneNumber: phoneNumber);
    } catch (e) {
      setLoading(false);
    }
  }

  Future<void> resendOtp(String phoneNumber, BuildContext context) async {
    await createAccountWithPhoneNumber(phoneNumber, context);
  }
}
