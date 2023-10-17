import 'package:flutter/material.dart';
import 'package:yolo/helper/functions.dart';
import 'package:yolo/views/hometest.dart';
import 'package:yolo/views/home.dart';
import 'package:yolo/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yolo/views/splash.dart'; // Import Firebase Core


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase.initializeApp()
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: (_isLoggedin ?? false) ? Quiz() : SignIn(),
      home: SignIn(),
    );
  }
}