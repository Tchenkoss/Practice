import 'dart:async';
import 'package:flutter/material.dart';
import 'package:powereact/screen/homescreen.dart';
import 'package:powereact/screen/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required String title});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? loggedInEmail;

  void isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('email');
    setState(() {
      loggedInEmail = token;
    });

    if (loggedInEmail != null && mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () => isLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/Pwrlogo.png'),
      ),
    );
  }
}
