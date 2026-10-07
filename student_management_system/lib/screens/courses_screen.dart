import 'package:flutter/material.dart';
import '../models/student.dart';
import '../theme.dart';

class CoursesScreen extends StatelessWidget {
  final List<Student> students;
  const CoursesScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<Student>>{};
    for (final student in students) {
      grouped.putIfAbsent(student.course, () => []).add(student);
    }
    final entries = grouped.entries.toList()..sort((a, b) => b.value.length.compareTo(a.value.length));
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Courses & programs', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('See enrollment levels and student activity across every program.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 850 ? 3 : MediaQuery.of(context).size.width > 550 ? 2 : 1,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.35,
          ),
          itemCount: entries.length,
          itemBuilder: (_, index) {
            final entry = entries[index];
            final active = entry.value.where((s) => s.status == 'Active').length;
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    CircleAvatar(backgroundColor: teal.withOpacity(.12), foregroundColor: teal, child: const Icon(Icons.school_outlined)),
                    const Spacer(),
                    Text('${entry.value.length} enrolled', style: const TextStyle(fontWeight: FontWeight.bold, color: teal)),
                  ]),
                  const Spacer(),
                  Text(entry.key, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(entry.value.first.department, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(value: entry.value.isEmpty ? 0 : active / entry.value.length, color: teal, backgroundColor: teal.withOpacity(.12)),
                  const SizedBox(height: 5),
                  Text('$active active students', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
              ),
            );
          },
        ),
        if (entries.isEmpty) const Padding(padding: EdgeInsets.all(30), child: Center(child: Text('No courses have enrollment yet.'))),
      ]),
    );
  }
}
