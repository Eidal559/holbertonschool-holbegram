import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'firebase_options.dart'; // <-- This is the important part
import 'screens/login_screen.dart';

// ignore: non_constant_identifier_names
Future<void> main(dynamic DefaultFirebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Holbegram',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
