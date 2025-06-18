import 'package:fire_todo_app/controller/phone_number_otp_authentication/phone_number_otp_authentication.dart';
import 'package:fire_todo_app/widgets/app_button.dart';
import 'package:fire_todo_app/widgets/app_text_formfield.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class StudentRegistrationScreen extends StatelessWidget {
  
  const StudentRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
       final authProvider = Provider.of<PhoneNumberOtpAuthentication>(context);
    TextEditingController studentName = TextEditingController();
    TextEditingController studentClass = TextEditingController();
    TextEditingController studentAge = TextEditingController();
    TextEditingController studentDomain = TextEditingController();

    return Scaffold(
      backgroundColor: seckcolor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          authProvider.setLoading(false);
          
          Navigator.of(context).pop();
          

        }, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const Text("Add Student Record"),
        titleTextStyle: const TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
          child: Column(
            children: [
              AppTextFormField(
                boolValue: false,
                  controller: studentName,
                  name: "name :  ",
                  icon: const Padding(
                      padding: EdgeInsets.only(top: 11, left: 11),
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        size: 20,
                      )),
                  formfieldColor: wcolor),
              const SizedBox(
                height: 10,
              ),
              AppTextFormField(
                boolValue: false,
                  controller: studentClass,
                  name: "class :  ",
                  icon: const Padding(
                      padding: EdgeInsets.only(top: 11, left: 11),
                      child: FaIcon(
                        FontAwesomeIcons.graduationCap,
                        size: 20,
                      )),
                  formfieldColor: wcolor),
              const SizedBox(
                height: 10,
              ),
              AppTextFormField(
                boolValue: false,
                  controller: studentAge,
                  name: "age :  ",
                  icon: const Padding(
                      padding: EdgeInsets.only(top: 11, left: 11),
                      child: FaIcon(
                        FontAwesomeIcons.calendar,
                        size: 20,
                      )),
                  formfieldColor: wcolor),
              const SizedBox(
                height: 10,
              ),
              AppTextFormField(
                boolValue: false,
                  controller: studentDomain,
                  name: "domain :  ",
                  icon: const Padding(
                      padding: EdgeInsets.only(top: 11, left: 11),
                      child: FaIcon(
                        FontAwesomeIcons.book,
                        size: 20,
                      )),
                  formfieldColor: wcolor),
              const SizedBox(
                height: 20,
              ),
              AppButton(function: () {}, text: "Register")
            ],
          ),
        ),
      ),
    );
  }
}
