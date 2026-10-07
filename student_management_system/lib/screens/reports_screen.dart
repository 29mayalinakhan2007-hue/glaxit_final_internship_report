import 'package:flutter/material.dart';
import '../models/student.dart';
import '../theme.dart';

class ReportsScreen extends StatelessWidget {
  final List<Student> students;
  const ReportsScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    final active = students.where((s) => s.status == 'Active').length;
    final inactive = students.length - active;
    final departments = <String, int>{};
    for (final student in students) {
      departments[student.department] = (departments[student.department] ?? 0) + 1;
    }
    final sortedDepartments = departments.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Reports & insights', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('A clear view of enrollment health across your campus.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.3,
          children: [
            _stat('Total students', '${students.length}', Icons.people_outline, teal),
            _stat('Active students', '$active', Icons.trending_up, Colors.green),
            _stat('Inactive students', '$inactive', Icons.pause_circle_outline, Colors.orange),
            _stat('Programs', '${students.map((s) => s.course).toSet().length}', Icons.school_outlined, Colors.blue),
          ],
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Enrollment by department', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              if (sortedDepartments.isEmpty) const Text('No enrollment data available.'),
              ...sortedDepartments.map((entry) {
                final ratio = students.isEmpty ? 0.0 : entry.value / students.length;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [Expanded(child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600))), Text('${entry.value} students', style: const TextStyle(color: Colors.grey))]),
                    const SizedBox(height: 7),
                    LinearProgressIndicator(value: ratio, minHeight: 9, borderRadius: BorderRadius.circular(8), color: teal, backgroundColor: teal.withOpacity(.12)),
                  ]),
                );
              }),
            ]),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Status distribution', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _statusRow('Active', active, students.length, Colors.green),
              const SizedBox(height: 12),
              _statusRow('Inactive', inactive, students.length, Colors.orange),
              const SizedBox(height: 12),
              Text('Report generated from the current local student directory.', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _stat(String label, String value, IconData icon, Color color) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: color), const Spacer(), Text(value, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold)), Text(label, style: const TextStyle(fontWeight: FontWeight.w600))])));

  Widget _statusRow(String label, int value, int total, Color color) {
    final ratio = total == 0 ? 0.0 : value / total;
    return Row(children: [SizedBox(width: 75, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))), Expanded(child: LinearProgressIndicator(value: ratio, minHeight: 10, borderRadius: BorderRadius.circular(8), color: color, backgroundColor: color.withOpacity(.12))), const SizedBox(width: 12), Text('$value')]);
  }
}
