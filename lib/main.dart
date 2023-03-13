import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pigalukuadmin/screens/splash_screen.dart';
import 'package:pigalukuadmin/secrets.dart';

void main() async{
  final Configurations configurations = Configurations();


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: configurations.apiKey,
      appId: configurations.appId,
      messagingSenderId: configurations.messagingSenderId,
      projectId: configurations.projectId
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Piga Luku Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: const SplashScreen(),
    );
  }
}