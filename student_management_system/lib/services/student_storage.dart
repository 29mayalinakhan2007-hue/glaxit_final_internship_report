import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';

class StudentStorage {
  static const key = 'students';

  Future<List<Student>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);

    if (raw == null) {
      final seeded = seedStudents();
      await save(seeded);
      return seeded;
    }

    return (jsonDecode(raw) as List)
        .map((item) => Student.fromJson(item))
        .toList();
  }

  Future<void> save(List<Student> students) async {
    final prefs = await SharedPreferences.getInstance();
    

    await prefs.setString(
      key,
      jsonEncode(
        students.map((student) => student.toJson()).toList(),
      ),
    );
  }

  List<Student> seedStudents() {
    return [
      // Initial student records
    ];
  }
}
