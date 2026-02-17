import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePageWrapper(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF121212), // Dark background
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GT Logo Container with Hexagon
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: _buildGTLogo(),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(duration: 400.ms),
            const SizedBox(height: 40),
            // App Name
            const Text(
              'Govind Tank',
              style: TextStyle(
                color: Color(0xFFFFD700), // Gold color
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 500.ms)
                .slideY(begin: 0.3, end: 0, delay: 300.ms, duration: 500.ms),
            const SizedBox(height: 8),
            // Tagline
            const Text(
              'Portfolio',
              style: TextStyle(
                color: Color(0xFF00E5FF), // Cyan color
                fontSize: 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 3,
              ),
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 500.ms)
                .slideY(begin: 0.3, end: 0, delay: 500.ms, duration: 500.ms),
            const SizedBox(height: 60),
            // Loading indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xFF00E5FF).withOpacity(0.8),
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 800.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildGTLogo() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Inner circle
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFFFD700).withOpacity(0.3),
              width: 2,
            ),
          ),
        ),
        // GT Text with Gold color
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'G',
              style: TextStyle(
                color: Color(0xFFFFD700), // Gold
                fontSize: 56,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
            Text(
              'T',
              style: TextStyle(
                color: Color(0xFFFFD700), // Gold
                fontSize: 56,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ],
        ),
        // Cyan accent
        Positioned(
          top: 25,
          right: 35,
          child: Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: Color(0xFF00E5FF), // Cyan
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 40,
          child: Container(
            width: 16,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF), // Cyan
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}

// Wrapper widget to handle theme passing
class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
      isDarkMode: _isDarkMode,
      onThemeChanged: _toggleTheme,
    );
  }
}
