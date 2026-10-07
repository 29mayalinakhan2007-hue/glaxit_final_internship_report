import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'theme.dart';

void main() => runApp(const CampusflowApp());

class CampusflowApp extends StatefulWidget { const CampusflowApp({super.key}); @override State<CampusflowApp> createState() => _AppState(); }
class _AppState extends State<CampusflowApp> {
  Map<String, String>? user;
  @override Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, title: 'Campusflow', theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: const Color(0xfff5f8f7), colorScheme: ColorScheme.fromSeed(seedColor: teal), fontFamily: 'Arial'), home: user == null ? LoginPage(onLogin: (u) => setState(() => user = u)) : HomePage(user: user!, onLogout: () => setState(() => user = null)));
}
