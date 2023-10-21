import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Przenoszenie do ekranu powitalnego po 2 sekundach.
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ));
    });

    return const Scaffold(
      body: Center(
        child: Text("Evently",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
