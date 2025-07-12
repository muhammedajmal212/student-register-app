import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_todo_app/model/student_details_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentService {
  Future<void> addStudent(StudentDetailsModel student) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    await FirebaseFirestore.instance.collection("StudentDetails").add({
      'uid': uid,
      'name': student.name,
      'age': student.age,
      'domain': student.domain,
      'standard': student.standard
    });
  }

  Stream<List<StudentDetailsModel>> getStudentRecordStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('StudentDetails')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return StudentDetailsModel.fromJson(doc.data());
      }).toList();
    });
  }
}
