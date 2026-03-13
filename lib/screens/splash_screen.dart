import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'resume_screen.dart';
import '../core/theme/theme_provider.dart';
import '../services/visitor_counter_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final VisitorCounterService _visitorCounterService = VisitorCounterService();

  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    // Increment visitor counter on app load
    await _visitorCounterService.incrementVisitorCount();

    // Navigate to home after delay
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FF),
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
                  color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: _buildGTLogo(isDark),
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
              Text(
                'Govind Tank',
                style: TextStyle(
                  color: const Color(0xFFFFD700), // Gold color
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      color: isDark ? Colors.black54 : Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 500.ms)
                  .slideY(begin: 0.3, end: 0, delay: 300.ms, duration: 500.ms),
              const SizedBox(height: 8),
              // Tagline
              Text(
                'Portfolio',
                style: TextStyle(
                  color: const Color(0xFF00E5FF), // Cyan color
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
      ),
    );
  }

  Widget _buildGTLogo(bool isDark) {
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
              color: isDark ? const Color(0xFFFFD700).withOpacity(0.3) : const Color(0xFFFFD700).withOpacity(0.5),
              width: 2,
            ),
          ),
        ),
        // GT Text with Gold color
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'G',
              style: TextStyle(
                color: const Color(0xFFFFD700), // Gold
                fontSize: 56,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
            Text(
              'T',
              style: TextStyle(
                color: const Color(0xFFFFD700), // Gold
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
