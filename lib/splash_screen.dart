import 'package:flutter/material.dart';
import 'pokemon_list.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PokemonListPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'splashLogo',
          child: Lottie.asset(
            'assets/animations/splash_logo.json',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
