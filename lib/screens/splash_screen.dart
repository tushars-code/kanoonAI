import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Hide system UI for immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Set up animation
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _animationController.forward();

    // Close splash screen after 3 seconds and navigate to home screen
    Future.delayed(const Duration(seconds: 5), () {
      // Replace with your home screen or use Navigator.pushReplacement
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Your home screen widget
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF142363), // Background color from palette
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2641B7), // Logo background color
                ),
                child: const Center(
                  child: Icon(
                    Icons.gavel, // Legal-themed icon
                    size: 50,
                    color: Color(0xFFCEFBF4), // Accent color
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // App Name
              const Text(
                'KanoonAI',
                style: TextStyle(
                  color: Color(0xFFFFFFFF), // Text color
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Tagline
              const Text(
                'Your Legal Companion',
                style: TextStyle(
                  color: Color(0xFFCEFBF4), // Accent color
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
