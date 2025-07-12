import 'package:fire_todo_app/controller/student_controller/student_controller.dart';
import 'package:fire_todo_app/model/student_details_model.dart';
import 'package:fire_todo_app/widgets/app_button.dart';
import 'package:fire_todo_app/widgets/app_text_formfield.dart';
import 'package:fire_todo_app/widgets/constants/constsnts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegisterFormFields extends StatelessWidget {
  const RegisterFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController studentName = TextEditingController();
    TextEditingController studentClass = TextEditingController();
    TextEditingController studentAge = TextEditingController();
    TextEditingController studentDomain = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextFormField(
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Student Name";
                }
                return null;
              },
              boolValue: false,
              controller: studentName,
              name: "name :  ",
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 11, left: 11),
                child: FaIcon(
                  FontAwesomeIcons.user,
                  size: 20,
                ),
              ),
              formfieldColor: wcolor),
          const SizedBox(
            height: 10,
          ),
          AppTextFormField(
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Class";
                }
                return null;
              },
              boolValue: false,
              controller: studentClass,
              name: "class :  ",
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 11, left: 11),
                child: FaIcon(
                  FontAwesomeIcons.graduationCap,
                  size: 20,
                ),
              ),
              formfieldColor: wcolor),
          const SizedBox(
            height: 10,
          ),
          AppTextFormField(
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Age";
                }
                return null;
              },
              boolValue: false,
              controller: studentAge,
              name: "age :  ",
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 11, left: 11),
                child: FaIcon(
                  FontAwesomeIcons.calendar,
                  size: 20,
                ),
              ),
              formfieldColor: wcolor),
          const SizedBox(
            height: 10,
          ),
          AppTextFormField(
              validatorFunction: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Domain";
                }
                return null;
              },
              boolValue: false,
              controller: studentDomain,
              name: "domain :  ",
              prefixIcon: const Padding(
                padding: EdgeInsets.only(top: 11, left: 11),
                child: FaIcon(
                  FontAwesomeIcons.book,
                  size: 20,
                ),
              ),
              formfieldColor: wcolor),
          const SizedBox(
            height: 20,
          ),
          AppButton(
              function: () {
                if (formKey.currentState!.validate()) {
                  final studentDetails = StudentDetailsModel(
                      name: studentName.text.toString(),
                      age: studentAge.text.toString(),
                      domain: studentDomain.text.toString(),
                      standard: studentClass.text.toString());
                  Provider.of<StudentController>(context, listen: false)
                      .addStudent(studentDetails);
                  Navigator.of(context).pop();
                }
              },
              text: "Register")
        ],
      ),
    );
  }
}
