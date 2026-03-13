import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_data.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_provider.dart';

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
                        AppColors.primary.withOpacity(0.1),
                        AppColors.secondary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.1),
                      ]
                    : [
                        Colors.grey.shade50,
                        Colors.grey.shade100,
                        Colors.white,
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
        child,
      ],
    );
  }
}

class GlassCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(0),
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.darkSurface.withOpacity(0.8)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? AppColors.darkBorder
              : AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(20.0),
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
                _buildContactSection(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassCard(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                data.name.split(' ').map((e) => e[0]).join('').toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 20),
          Text(
            data.name,
            style: AppTextStyles.displayMedium(context, isDark: isDark),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 8),
          Text(
            data.role,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge(context, isDark: isDark)?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ).animate().fadeIn(delay: 400.ms),
          if (data.location != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 16, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  data.location!,
                  style: AppTextStyles.bodyMedium(context, isDark: isDark),
                ),
              ],
            ).animate().fadeIn(delay: 600.ms),
          ],
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: AppColors.primary),
              const SizedBox(width: 10),
              Text('About Me', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.summary,
            style: AppTextStyles.bodyLarge(context, isDark: isDark),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildSkillsSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: AppColors.primary),
            const SizedBox(width: 10),
            Text('Skills & Technologies', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: data.skills.expand((skill) {
            return skill.items.map((item) => _buildSkillChip(context, item)).toList();
          }).toList(),
        ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9)),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.8), AppColors.secondary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
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
            Icon(Icons.work, color: AppColors.primary),
            const SizedBox(width: 10),
            Text('Work Experience', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
          ],
        ),
        const SizedBox(height: 20),
        ...data.experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final exp = entry.value;
          return GlassCard(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        exp.role,
                        style: AppTextStyles.headlineLarge(context, isDark: isDark)?.copyWith(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        exp.duration,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.business, size: 16, color: AppColors.secondary),
                    const SizedBox(width: 6),
                    Text(
                      exp.company + (exp.location != null ? ' | ${exp.location}' : ''),
                      style: AppTextStyles.bodyMedium(context, isDark: isDark)?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  exp.description,
                  style: AppTextStyles.bodyMedium(context, isDark: isDark),
                ),
              ],
            ),
          ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1);
        }),
      ],
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.folder, color: AppColors.primary),
            const SizedBox(width: 10),
            Text('Featured Projects', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
          ],
        ),
        const SizedBox(height: 20),
        ...data.projects.asMap().entries.map((entry) {
          final index = entry.key;
          final project = entry.value;
          return GlassCard(
            margin: const EdgeInsets.only(bottom: 16),
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
                      IconButton(
                        icon: const Icon(Icons.open_in_new, color: AppColors.primary),
                        onPressed: () => _launchUrl(project.link!),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: AppTextStyles.bodyMedium(context, isDark: isDark),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies.map((tech) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1);
        }),
      ],
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.school, color: AppColors.primary),
            const SizedBox(width: 10),
            Text('Education', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
          ],
        ),
        const SizedBox(height: 20),
        ...data.education.map((edu) => GlassCard(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.school, color: AppColors.primary),
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
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  edu.duration,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final data = portfolioData;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.contact_mail, color: AppColors.primary),
              const SizedBox(width: 10),
              Text('Get In Touch', style: AppTextStyles.headlineMedium(context, isDark: isDark)),
            ],
          ),
          const SizedBox(height: 20),
          _buildContactRow(context, Icons.email, 'Email', data.contact.email ?? '', 'mailto:${data.contact.email}'),
          if (data.contact.phone != null)
            _buildContactRow(context, Icons.phone, 'Phone', data.contact.phone!, 'tel:${_formatPhoneNumber(data.contact.phone!)}'),
          if (data.contact.linkedin != null)
            _buildContactRow(context, Icons.business, 'LinkedIn', _extractDisplayUrl(data.contact.linkedin!), data.contact.linkedin!),
          if (data.contact.github != null)
            _buildContactRow(context, Icons.code, 'GitHub', _extractDisplayUrl(data.contact.github!), data.contact.github!),
          if (data.contact.website != null)
            _buildContactRow(context, Icons.alternate_email, 'X (Twitter)', _extractDisplayUrl(data.contact.website!), data.contact.website!),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String label, String displayValue, String url) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
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
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      displayValue,
                      style: TextStyle(
                        color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.open_in_new,
                size: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
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
