import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pigalukuadmin/screens/admin_users.dart';
import 'package:pigalukuadmin/screens/category_screen.dart';
import 'package:pigalukuadmin/screens/home_screen.dart';
import 'package:pigalukuadmin/screens/login_screen.dart';
import 'package:pigalukuadmin/screens/manage_banners.dart';
import 'package:pigalukuadmin/screens/notification_screen.dart';
import 'package:pigalukuadmin/screens/order_screen.dart';
import 'package:pigalukuadmin/screens/settings_screen.dart';
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
      routes: {
        HomeScreen.id:(context) => const HomeScreen(),
        LoginScreen.id:(context) => const LoginScreen(),
        SplashScreen.id:(context) => const SplashScreen(),
        BannerScreen.id:(context) => const BannerScreen(),
        CategoryScreen.id:(context) => const CategoryScreen(),
        OrderScreen.id:(context) => const OrderScreen(),
        NotificationScreen.id:(context) => const NotificationScreen(),
        AdminUsers.id:(context) => const AdminUsers(),
        SettingScreen.id:(context) => const SettingScreen()
      },
    );
  }
}