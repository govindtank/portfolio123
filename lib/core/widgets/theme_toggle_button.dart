/*
import 'package:flutter/material.dart';

import '../theme/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final Duration animationDuration;

  const ThemeToggleButton({
    Key? key,
    this.size = 24.0,
    this.activeColor,
    this.inactiveColor,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final activeColor = this.activeColor ?? theme.colorScheme.primary;
    final inactiveColor =
        this.inactiveColor ?? theme.hintColor.withOpacity(0.5);

    return AnimatedContainer(
      duration: animationDuration,
      width: size * 1.8,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Sun and Moon Icons
          AnimatedAlign(
            duration: animationDuration,
            alignment: themeProvider.isDarkMode
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: size - 4,
              height: size - 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: themeProvider.isDarkMode
                      ? [
                          const Color(0xFF8983F7),
                          const Color(0xFFA3DAFB),
                        ]
                      : [
                          const Color(0xFFFFD93B),
                          const Color(0xFFFF9400),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (themeProvider.isDarkMode
                            ? const Color(0xFFA3DAFB)
                            : const Color(0xFFFFD93B))
                        .withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                themeProvider.isDarkMode
                    ? Icons.nightlight_round
                    : Icons.wb_sunny_rounded,
                color: Colors.white,
                size: size * 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeToggleButtonWithGesture extends StatelessWidget {
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final Duration animationDuration;
  final VoidCallback? onToggle;

  const ThemeToggleButtonWithGesture({
    Key? key,
    this.size = 24.0,
    this.activeColor,
    this.inactiveColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        themeProvider.toggleTheme();
        onToggle?.call();
      },
      child: ThemeToggleButton(
        size: size,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        animationDuration: animationDuration,
      ),
    );
  }
}
*/
