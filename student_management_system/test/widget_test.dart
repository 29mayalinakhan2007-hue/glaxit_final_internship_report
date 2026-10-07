import 'package:flutter_test/flutter_test.dart';
import 'package:campusflow_student_management/main.dart';

void main() {
  testWidgets('shows the Campusflow login screen', (tester) async {
    await tester.pumpWidget(const CampusflowApp());

    expect(find.text('campusflow'), findsWidgets);
    expect(find.text('Sign in to your workspace'), findsOneWidget);
    expect(find.text('Explore demo workspace'), findsOneWidget);
  });
}
