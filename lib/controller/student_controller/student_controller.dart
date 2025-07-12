import 'package:fire_todo_app/model/student_details_model.dart';
import 'package:fire_todo_app/services/student_service.dart';
import 'package:flutter/material.dart';

class StudentController extends ChangeNotifier {
  StudentService studentService = StudentService();
  Future<void> addStudent(StudentDetailsModel student) async {
    await studentService.addStudent(student);
  }

  Stream<List<StudentDetailsModel>> getStudentRecordStream() {
    return studentService.getStudentRecordStream();
  }
}
