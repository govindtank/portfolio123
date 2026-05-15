import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_data.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_provider.dart';
import '../core/widgets/custom_card.dart';
import '../services/github_service.dart';
import '../models/github_project.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedContainer(
            duration: const Duration(seconds: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      ]
                    : [
                        AppColors.background,
                        AppColors.surfaceVariant,
                        const Color(0xFFB8C5D6),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat()).shimmer(
            duration: 10000.ms,
            size: 2.0,
          ),
        ),
        // Floating geometric shapes
        Positioned(
          top: 100,
          left: 50,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(begin: 0, end: 20, duration: 2000.ms),
        ),
        Positioned(
          top: 200,
          right: 100,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveX(begin: 0, end: 15, duration: 1500.ms),
        ),
        Positioned(
          bottom: 150,
          left: 200,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2500.ms),
        ),
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}

class GlassCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  double _rotationX = 0;
  double _rotationY = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _rotationY = (event.localPosition.dx - 150) / 150 * 0.1;
          _rotationX = (event.localPosition.dy - 150) / 150 * -0.1;
        });
      },
      onExit: (event) {
        setState(() {
          _rotationX = 0;
          _rotationY = 0;
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotationX)
          ..rotateY(_rotationY),
        alignment: FractionalOffset.center,
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin ?? const EdgeInsets.all(0),
          padding: widget.padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurface.withOpacity(0.8)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? AppColors.darkBorder
                  : const Color(0xFF8FA3BF),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.2),
                blurRadius: 28,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: isDark
                    ? Colors.transparent
                    : const Color(0xFFA8B8CC).withOpacity(0.4),
                blurRadius: 0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Govind Tank'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return DropdownButton<String>(
                  value: themeProvider.accentName,
                  dropdownColor: Theme.of(context).cardColor,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  underline: const SizedBox(),
                  icon: Icon(Icons.palette, color: Theme.of(context).colorScheme.onSurface),
                  items: ThemeProvider.accentColors.keys.map((String name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      themeProvider.setAccent(newValue);
                    }
                  },
                );
              },
            ),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  onPressed: themeProvider.toggleTheme,
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 40,
              vertical: 20,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(context),
                    const SizedBox(height: 40),
                    _buildAboutSection(context),
                    const SizedBox(height: 40),
                    _buildSkillsSection(context),
                    const SizedBox(height: 40),
                    _buildExperienceSection(context),
                    const SizedBox(height: 40),
                    _buildProjectsSection(context),
                    const SizedBox(height: 40),
                    _buildEducationSection(context),
                    const SizedBox(height: 40),
                    _buildGithubSection(context),
                    const SizedBox(height: 40),
                    _buildContactSection(context),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      alignment: Alignment.center,
      child: AnimatedCustomCard(
        padding: EdgeInsets.all(isMobile ? 20 : 30),
        isGlassmorphic: true,
        glassmorphicIntensity: 0.1,
        glassmorphicBlur: 8.0,
        showHoverEffect: true,
        hoverScale: 1.02,
        hoverElevation: 8.0,
        animationDuration: const Duration(milliseconds: 400),
        hoverAnimationDuration: const Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Profile Picture with glow effect
            Stack(
              alignment: Alignment.center,
              children: [
                // Glow background
                Container(
                  width: isMobile ? 140 : 160,
                  height: isMobile ? 140 : 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                      BoxShadow(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                        blurRadius: 50,
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                ).animate(onPlay: (controller) => controller.repeat()).scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                  duration: 2000.ms,
                ),

                // Profile image
                Container(
                  width: isMobile ? 130 : 150,
                  height: isMobile ? 130 : 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ).animate()
                    .fadeIn(duration: 600.ms)
                    .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0), duration: 700.ms, curve: Curves.elasticOut),
              ],
            ),

            SizedBox(height: isMobile ? 16 : 20),

            // Name
            Text(
              data.name,
              textAlign: TextAlign.center,
              style: AppTextStyles.displayMedium(context, isDark: isDark)?.copyWith(
                fontSize: isMobile ? 24 : 32,
              ),
            ).animate()
                .fadeIn(delay: 300.ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0, delay: 300.ms, duration: 600.ms),

            SizedBox(height: isMobile ? 6 : 8),

            // Role with typewriter effect (improved)
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                ).createShader(bounds),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      data.role,
                      textAlign: TextAlign.center,
                      textStyle: AppTextStyles.bodyLarge(context, isDark: isDark)?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 13 : 16,
                      ),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                ),
              ).animate()
                  .fadeIn(delay: 500.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, delay: 500.ms, duration: 600.ms),
            ),

            if (data.location != null) ...[
              SizedBox(height: isMobile ? 10 : 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data.location!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium(context, isDark: isDark)?.copyWith(
                      fontSize: isMobile ? 12 : 14,
                    ),
                  ),
                ],
              ).animate()
                  .fadeIn(delay: 700.ms, duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, delay: 700.ms, duration: 600.ms),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedCustomCard(
      showHoverEffect: true,
      hoverScale: 1.01,
      hoverElevation: 6.0,
      isGlassmorphic: true,
      glassmorphicIntensity: 0.05,
      glassmorphicBlur: 6.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 10),
              Text('About Me', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
            ],
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

          const SizedBox(height: 16),

          Text(
            data.summary,
            style: AppTextStyles.bodyLarge(context, isDark: isDark),
            textAlign: TextAlign.justify,
          ).animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideX(begin: -0.1, delay: 200.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final skillList = data.skills.expand((skill) => skill.items).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text('Skills & Technologies', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
          ],
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

        const SizedBox(height: 20),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skillList.asMap().entries.map((entry) {
            return _buildSkillChip(context, entry.value, entry.key);
          }).toList(),
        ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.85, 0.85), duration: 600.ms),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Builder(
      builder: (context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {},
        child: AnimatedCustomCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          borderRadius: BorderRadius.circular(20),
          isGlassmorphic: false,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.secondary.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          showBorder: true,
          borderColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          borderWidth: 1,
          showShadow: true,
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          shadowBlurRadius: 12,
          shadowOffset: const Offset(0, 4),
          showHoverEffect: true,
          hoverScale: 1.05,
          hoverElevation: 4.0,
          child: Text(
            skill,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 40 * index)).scale(
        begin: const Offset(0, 0),
        end: const Offset(1, 1),
        delay: Duration(milliseconds: 40 * index),
        duration: 400.ms,
        curve: Curves.elasticOut,
      );
  }

  Widget _buildExperienceSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.work, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text('Work Experience', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
          ],
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

        const SizedBox(height: 20),

        ...data.experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final exp = entry.value;
          return Builder(
      builder: (context) => AnimatedCustomCard(
            margin: const EdgeInsets.only(bottom: 16),
            showHoverEffect: true,
            hoverScale: 1.02,
            hoverElevation: 6.0,
            isGlassmorphic: true,
            glassmorphicIntensity: 0.05,
            glassmorphicBlur: 6.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        exp.role,
                        style: AppTextStyles.headlineLarge(context, isDark: isDark)?.copyWith(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        exp.duration,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.business, size: 16, color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(width: 6),
                    Text(
                      exp.company + (exp.location != null ? ' | ${exp.location}' : ''),
                      style: AppTextStyles.bodyMedium(context, isDark: isDark)?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  exp.description,
                  style: AppTextStyles.bodyMedium(context, isDark: isDark),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
    ).animate()
      .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 600.ms)
      .slideX(begin: 0.1, delay: Duration(milliseconds: 100 * index), duration: 600.ms);
        }),
      ],
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.folder, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text('Featured Projects', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
          ],
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

        const SizedBox(height: 20),

        isMobile
            ? Column(
                children: data.projects.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildProjectCard(context, entry.value, entry.key),
                  );
                }).toList(),
              )
            : SizedBox(
                height: 320,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: data.projects.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _buildProjectCard(context, entry.value, entry.key),
                    );
                  }).toList(),
                ),
              ),
      ],
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Builder(
      builder: (context) => AnimatedCustomCard(
        width: isMobile ? double.infinity : 300,
        margin: EdgeInsets.zero,
        showHoverEffect: true,
        hoverScale: 1.03,
        hoverElevation: 8.0,
        isGlassmorphic: true,
        glassmorphicIntensity: 0.05,
        glassmorphicBlur: 6.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: AppTextStyles.headlineLarge(context, isDark: isDark)?.copyWith(fontSize: 18),
                  ),
                ),
                if (project.link != null)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: IconButton(
                      icon: Icon(Icons.open_in_new, color: Theme.of(context).colorScheme.primary),
                      onPressed: () => _launchUrl(project.link!),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              project.description,
              style: AppTextStyles.bodyMedium(context, isDark: isDark),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies.map((tech) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 600.ms)
      .slideX(begin: 0.2, delay: Duration(milliseconds: 100 * index), duration: 600.ms);
  }

  Widget _buildEducationSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.school, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text('Education', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
          ],
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

        const SizedBox(height: 20),

        ...data.education.asMap().entries.map((entry) {
          final index = entry.key;
          final edu = entry.value;
          return Builder(
      builder: (context) => AnimatedCustomCard(
            margin: const EdgeInsets.only(bottom: 12),
            showHoverEffect: true,
            hoverScale: 1.02,
            hoverElevation: 6.0,
            isGlassmorphic: true,
            glassmorphicIntensity: 0.05,
            glassmorphicBlur: 6.0,
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.school, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edu.degree,
                        style: AppTextStyles.bodyLarge(context, isDark: isDark)?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        edu.institution,
                        style: AppTextStyles.bodyMedium(context, isDark: isDark),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    edu.duration,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
    ).animate()
      .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 600.ms)
      .slideX(begin: -0.1, delay: Duration(milliseconds: 100 * index), duration: 600.ms);
        }),
      ],
    );
  }

  Widget _buildGithubSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Builder(
      builder: (context) => AnimatedCustomCard(
        showHoverEffect: true,
        hoverScale: 1.01,
        hoverElevation: 4.0,
        isGlassmorphic: true,
        glassmorphicIntensity: 0.05,
        glassmorphicBlur: 6.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.code, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text('GitHub Projects', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
              ],
            ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

            const SizedBox(height: 20),

            FutureBuilder<List<GithubProject>>(
              future: GithubService().fetchRecentRepos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Error loading projects: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('No projects found.'),
                  );
                } else {
                  final projects = snapshot.data!;
                  return Column(
                    children: projects.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildGithubProjectCard(context, entry.value, entry.key),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildGithubProjectCard(BuildContext context, GithubProject project, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Builder(
      builder: (context) => AnimatedCustomCard(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(12.0),
        showHoverEffect: true,
        hoverScale: 1.02,
        hoverElevation: 4.0,
        isGlassmorphic: true,
        glassmorphicIntensity: 0.03,
        glassmorphicBlur: 4.0,
        onTap: () => _launchUrl(project.htmlUrl),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.code, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: AppTextStyles.bodyLarge(context, isDark: isDark)?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.description ?? 'No description',
                        style: AppTextStyles.bodyMedium(context, isDark: isDark),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (project.language != null) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            project.language!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.open_in_new, color: Theme.of(context).colorScheme.primary, size: 18),
              ],
            ),
        ),

    ).animate()
      .fadeIn(delay: Duration(milliseconds: 50 * index), duration: 400.ms)
      .slideX(begin: 0.1, delay: Duration(milliseconds: 50 * index), duration: 400.ms);
  }

  Widget _buildContactSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Builder(
      builder: (context) => AnimatedCustomCard(
        showHoverEffect: true,
        hoverScale: 1.01,
        hoverElevation: 4.0,
        isGlassmorphic: true,
        glassmorphicIntensity: 0.05,
        glassmorphicBlur: 6.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.contact_mail, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text('Get In Touch', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
              ],
            ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

            const SizedBox(height: 20),

            _buildContactRow(context, Icons.email, 'Email', data.contact.email ?? '', 'mailto:${data.contact.email}', 0),
            if (data.contact.phone != null)
              _buildContactRow(context, Icons.phone, 'Phone', data.contact.phone!, 'tel:${_formatPhoneNumber(data.contact.phone!)}', 1),
            if (data.contact.linkedin != null)
              _buildContactRow(context, Icons.business, 'LinkedIn', _extractDisplayUrl(data.contact.linkedin!), data.contact.linkedin!, 2),
            if (data.contact.github != null)
              _buildContactRow(context, Icons.code, 'GitHub', _extractDisplayUrl(data.contact.github!), data.contact.github!, 3),
            if (data.contact.website != null)
              _buildContactRow(context, Icons.alternate_email, 'X (Twitter)', _extractDisplayUrl(data.contact.website!), data.contact.website!, 4),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String label, String displayValue, String url, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Builder(
      builder: (context) => AnimatedCustomCard(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        showHoverEffect: true,
        hoverScale: 1.02,
        hoverElevation: 4.0,
        isGlassmorphic: true,
        glassmorphicIntensity: 0.03,
        glassmorphicBlur: 4.0,
        onTap: () => _launchUrl(url),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          displayValue,
                          style: TextStyle(
                            color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
          ),
        ),
      ).animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 400.ms)
        .slideY(begin: 0.1, delay: Duration(milliseconds: 100 * index), duration: 400.ms);
  }

  String _extractDisplayUrl(String url) {
    // Remove https:// or http:// prefix and trailing slashes
    String display = url
        .replaceAll('https://', '')
        .replaceAll('http://', '');
    if (display.endsWith('/')) {
      display = display.substring(0, display.length - 1);
    }
    return display;
  }

  String _formatPhoneNumber(String phone) {
    // Remove all spaces and special characters for tel: URL
    return phone.replaceAll(RegExp(r'[^0-9+]'), '');
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);

    // Determine the appropriate launch mode based on URL scheme
    LaunchMode mode;
    if (uri.scheme == 'mailto' || uri.scheme == 'tel') {
      // Use external application mode for email and phone
      mode = LaunchMode.externalApplication;
    } else {
      // Use external non-browser mode for web URLs
      mode = LaunchMode.externalNonBrowserApplication;
    }

    try {
      await launchUrl(uri, mode: mode);
    } catch (e) {
      debugPrint('Error launching URL: $url - $e');
    }
  }
}
