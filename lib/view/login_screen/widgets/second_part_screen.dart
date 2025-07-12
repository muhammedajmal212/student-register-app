import 'package:fire_todo_app/controller/email_password_authentication/email_password_authentication.dart';
import 'package:fire_todo_app/controller/google_sign_in_provider.dart';
import 'package:fire_todo_app/view/forgot_password_screen/forgot_password_screen.dart';
import 'package:fire_todo_app/view/login_screen/widgets/app_check_box.dart';
import 'package:fire_todo_app/view/login_screen/widgets/app_outlined_button.dart';
import 'package:fire_todo_app/view/phone_Screen/phone_auth_screen.dart';
import 'package:fire_todo_app/view/register_screen.dart/register_screen.dart';
import 'package:fire_todo_app/widgets/app_elevated_button.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:fire_todo_app/widgets/app_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SecondPartScreen extends StatelessWidget {
  const SecondPartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // final RegExp passwordRegex =
    //     RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$');
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{6,}$');

    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xFF303F9F),
                blurRadius: 24,
                offset: Offset(12, 12))
          ],
          color: Color(0xFF673AB7),
          borderRadius: BorderRadius.vertical(top: Radius.elliptical(30, 30))),
      width: double.infinity,
      height: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: AppTextFormField(
                boolValue: false,
                formfieldColor: wcolor,
                prefixIcon: const Icon(
                  Icons.mail,
                  color: Color(0xFF673AB7),
                ),
                controller: emailController,
                name: "Email",
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  } else if (!emailRegex.hasMatch(value)) {
                    return "please enter a valid email";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: AppTextFormField(
                boolValue: false,
                formfieldColor: wcolor,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xFF673AB7),
                ),
                controller: passwordController,
                name: "Password",
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password";
                  } else if (!passwordRegex.hasMatch(value)) {
                    return "Password must be at least 6 characters,\ninclude letters and numbers";
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppCheckBox(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ForgotPasswordScreen()));
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 15, color: wcolor),
                    ),
                  ),
                )
              ],
            ),
            AppElevatedButton(
                text: "Log in",
                function: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Provider.of<EmailPasswordAuthentication>(context,
                        listen: false);
                    EmailPasswordAuthentication().loginWithEmail(
                        context,
                        emailController.text.toString().trim(),
                        passwordController.text.toString().trim());
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(color: wcolor, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => RegisterScreen()));
                  },
                  child: const Text(
                    "Register now",
                    style: TextStyle(
                        color: wcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "or continue with",
              style: TextStyle(color: wcolor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppOutlinedButton(
                  function: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const PhoneAuthScreen()));
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.phone,
                    color: wcolor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                AppOutlinedButton(
                  function: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    await provider.googleLogin(context);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: wcolor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
