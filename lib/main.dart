import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const ReLeafApp());
}

class ReLeafApp extends StatelessWidget {
  const ReLeafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeaf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4CAF50)),
        fontFamily: 'Arial',
      ),
      home: const LoginScreen(),
    );
  }
}
