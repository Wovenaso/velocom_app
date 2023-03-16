import 'package:flutter/material.dart';
import 'package:velocom_app/screens/log_in.dart';
import 'package:velocom_app/screens/movil_screen.dart';
import 'package:velocom_app/screens/principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Velocom App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
