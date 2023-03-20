import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pigalukuadmin/screens/home_screen.dart';
import 'package:pigalukuadmin/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash-screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) {
        if (user == null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
        }
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
