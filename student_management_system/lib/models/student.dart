class Student {
  String id, name, rollNo, email, phone, course, enrollmentDate, status, department;
  Student({required this.id, required this.name, required this.rollNo, required this.email, required this.phone, required this.course, required this.enrollmentDate, required this.status, required this.department});
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'rollNo': rollNo, 'email': email, 'phone': phone, 'course': course, 'enrollmentDate': enrollmentDate, 'status': status, 'department': department};
  factory Student.fromJson(Map<String, dynamic> j) => Student(id: j['id'], name: j['name'], rollNo: j['rollNo'], email: j['email'], phone: j['phone'], course: j['course'], enrollmentDate: j['enrollmentDate'], status: j['status'], department: j['department']);
}

String departmentFor(String course) {
  if (course.contains('Computer Science') || course.contains('Data Science')) return 'Computer Science';
  if (course.contains('Business')) return 'Business';
  if (course.contains('Design')) return 'Design';
  if (course.contains('Information Technology')) return 'Information Technology';
  return 'General Studies';
}
String initials(String name) => name.split(' ').where((x) => x.isNotEmpty).map((x) => x[0]).take(2).join().toUpperCase();
String prettyDate(String value) { final d = DateTime.tryParse(value) ?? DateTime.now(); return '${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][d.month - 1]} ${d.day}, ${d.year}'; }
