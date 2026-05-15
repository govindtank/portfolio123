import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

import 'home_page.dart';
import '../services/visitor_counter_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final VisitorCounterService _visitorCounterService = VisitorCounterService();
  late AnimationController _orbitController;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _initializeAndNavigate();
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  Future<void> _initializeAndNavigate() async {
    _visitorCounterService.incrementVisitorCount().catchError((_) {
      debugPrint('Failed to increment visitor count');
    });
    await Future.delayed(const Duration(milliseconds: 3000));
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
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF121212),
                    const Color(0xFF1A1A2E),
                    const Color(0xFF0F3460),
                  ]
                : [
                    const Color(0xFFF8F9FF),
                    const Color(0xFFE8EEFF),
                    const Color(0xFFDDE5FF),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Animated background particles
              ..._buildBackgroundParticles(isDark),
              
              // Main content
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: isMobile ? 20 : 40),
                      
                      // Profile Picture with Orbital Animation
                      SizedBox(
                        height: isMobile ? 280 : 320,
                        width: isMobile ? 280 : 320,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Orbital rings
                            _buildOrbitalRings(isDark),
                            
                            // Rotating profile picture
                            AnimatedBuilder(
                              animation: _orbitController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _orbitController.value * 2 * math.pi,
                                  child: child,
                                );
                              },
                              child: Container(
                                width: isMobile ? 180 : 220,
                                height: isMobile ? 180 : 220,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF6C63FF).withOpacity(0.6),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                    BoxShadow(
                                      color: const Color(0xFFFF6584).withOpacity(0.3),
                                      blurRadius: 60,
                                      spreadRadius: 20,
                                    ),
                                  ],
                                  border: Border.all(
                                    color: isDark
                                        ? const Color(0xFF6C63FF).withOpacity(0.5)
                                        : const Color(0xFF6C63FF).withOpacity(0.3),
                                    width: 3,
                                  ),
                                ),
                              ),
                            ).animate().scale(
                              begin: const Offset(0, 0),
                              end: const Offset(1, 1),
                              duration: 800.ms,
                              curve: Curves.elasticOut,
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: isMobile ? 30 : 50),
                      
                      // Name
                      Text(
                        'Govind Tank',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF121212),
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 600.ms, duration: 600.ms)
                          .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 600.ms),
                      
                      const SizedBox(height: 12),
                      
                      // Role with gradient text
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            const Color(0xFF6C63FF),
                            const Color(0xFFFF6584),
                            const Color(0xFF00E5FF),
                          ],
                        ).createShader(bounds),
                        child: Text(
                          'Senior Mobile Developer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 800.ms, duration: 600.ms)
                          .slideY(begin: 0.3, end: 0, delay: 800.ms, duration: 600.ms),
                      
                      const SizedBox(height: 8),
                      
                      // Tagline
                      Text(
                        'Kotlin • Flutter • Web',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF666666),
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 1000.ms, duration: 600.ms)
                          .slideY(begin: 0.3, end: 0, delay: 1000.ms, duration: 600.ms),
                      
                      SizedBox(height: isMobile ? 40 : 60),
                      
                      // Animated loading indicator
                      _buildCustomLoadingIndicator(isDark)
                          .animate()
                          .fadeIn(delay: 1200.ms, duration: 400.ms),
                      
                      SizedBox(height: isMobile ? 40 : 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundParticles(bool isDark) {
    return List.generate(5, (index) {
      final random = math.Random(index);
      final size = 20.0 + (random.nextDouble() * 40);
      final top = random.nextDouble() * 0.7;
      final left = random.nextDouble();
      
      return Positioned(
        top: MediaQuery.of(context).size.height * top,
        left: MediaQuery.of(context).size.width * left,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark
                ? const Color(0xFF6C63FF).withOpacity(0.05)
                : const Color(0xFF6C63FF).withOpacity(0.03),
          ),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(
          begin: 0,
          end: 30,
          duration: Duration(seconds: 3 + (index * 500)),
        ),
      );
    });
  }

  Widget _buildOrbitalRings(bool isDark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer ring
        Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF6C63FF).withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        // Middle ring
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFFF6584).withOpacity(0.15),
              width: 1,
            ),
          ),
        ),
        // Inner ring
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF00E5FF).withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomLoadingIndicator(bool isDark) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating outer ring
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, _) {
              return Transform.rotate(
                angle: _orbitController.value * 2 * math.pi,
                child: CustomPaint(
                  painter: LoadingRingPainter(
                    color: const Color(0xFF6C63FF),
                  ),
                  size: const Size(60, 60),
                ),
              );
            },
          ),
          // Pulsing center
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFF6584),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6584).withOpacity(0.6),
                  blurRadius: 8,
                ),
              ],
            ),
          ).animate(onPlay: (controller) => controller.repeat()).scale(
            begin: const Offset(1, 1),
            end: const Offset(1.5, 1.5),
            duration: 1500.ms,
          ),
        ],
      ),
    );
  }
}

class LoadingRingPainter extends CustomPainter {
  final Color color;

  LoadingRingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    const radius = 25.0;
    const arcAngle = 0.8; // Partial arc

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

