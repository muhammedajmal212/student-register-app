import 'package:fire_todo_app/controller/email_password_authentication/email_password_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fire_todo_app/widgets/app_elevated_button.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:fire_todo_app/widgets/app_text_formfield.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final RegExp passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&#+=._-]{6,}$');
  late bool isPassword;
  late bool isConfirmPassword;
  @override
  void initState() {
    isPassword = true;
    isConfirmPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF673AB7),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Registration Screen",
            style: TextStyle(
                fontSize: 24, color: textColor, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              width: double.infinity,
              height: size.height * 0.35,
              decoration: const BoxDecoration(color: firstkcolor),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome 👋",
                        style: TextStyle(
                            fontSize: 24,
                            color: textColor,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "Add your phone number. We'll send you a verification code.",
                      style: TextStyle(
                          fontSize: 15,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: size.height * 0.35,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - size.height * 0.35,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppTextFormField(
                                boolValue: false,
                                controller: emailController,
                                name: "Email",
                                prefixIcon: const Icon(Icons.mail),
                                formfieldColor: wcolor,
                                validatorFunction: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter an email";
                                  } else if (!emailRegex.hasMatch(value)) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              AppTextFormField(
                                boolValue: isPassword,
                                controller: passwordController,
                                name: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                sufixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPassword = !isPassword;
                                      });
                                    },
                                    icon: Icon(isPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                formfieldColor: wcolor,
                                validatorFunction: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a password";
                                  } else if (!passwordRegex.hasMatch(value)) {
                                    return "Password must be at least 6 characters,\ninclude letters and numbers";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              AppTextFormField(
                                boolValue: isConfirmPassword,
                                controller: confirmPasswordController,
                                name: "Confirm Password",
                                prefixIcon: const Icon(Icons.lock),
                                sufixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isConfirmPassword = !isConfirmPassword;
                                      });
                                    },
                                    icon: Icon(isConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                formfieldColor: wcolor,
                                validatorFunction: (value) {
                                  if (value != passwordController.text) {
                                    return "Passwords do not match";
                                  } else if (value == null || value.isEmpty) {
                                    return "Please Confirm Your Password";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 60, right: 60),
                                child: AppElevatedButton(
                                  text: "Register Now",
                                  function: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      Provider.of<EmailPasswordAuthentication>(
                                              context,
                                              listen: false)
                                          .createAccount(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                        context,
                                      );
                                    }
                                    // if (_formKey.currentState?.validate() ??
                                    //     false) {
                                    //   Provider.of<EmailPasswordAuthentication>(
                                    //       context,
                                    //       listen: false);
                                    //   EmailPasswordAuthentication()
                                    //       .createAccount(
                                    //           emailController.text.trim(),
                                    //           passwordController.text.trim(),
                                    //           context);
                                    // }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
