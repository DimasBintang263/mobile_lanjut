import 'package:flutter/material.dart';
import 'package:tugas_apikasi/auth/login.dart';
import 'package:tugas_apikasi/auth/lupa_password.dart';
import 'package:tugas_apikasi/auth/register.dart';
import 'package:tugas_apikasi/dashboard/akun.dart';
import 'package:tugas_apikasi/dashboard/home.dart';
import 'package:tugas_apikasi/dashboard/profil.dart';
import 'package:tugas_apikasi/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Responsi 2024',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(),
      routes: {
        '/home': (context) => const HomePage(), 
        '/login': (context) => const LoginPage(), 
        '/register': (context) => const RegisterPage(), 
        '/password': (context) => const ForgotPasswordPage(),
        '/akun': (context) => const AccountPage(),  
        '/profil': (context) => ProfilePage(), 
      },
    );
  }
}
