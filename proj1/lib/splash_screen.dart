// splash_screen.dart
import 'package:flutter/material.dart';
import 'main.dart'; // Import your login page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginPage();
  }

  Future<void> _navigateToLoginPage() async {
    await Future.delayed(Duration(seconds: 3)); // Duration of the splash screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 11.09.20 AM.jpeg', // Path to your logo
          width: 300, // Adjust size as needed
          height: 300,
        ),
      ),
    );
  }
}
