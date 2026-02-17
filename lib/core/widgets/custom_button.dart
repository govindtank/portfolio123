import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum ButtonType {
  primary,
  secondary,
  text,
  outlined,
  danger,
  success,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool disabled;
  final IconData? icon;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? customColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool hasShadow;
  final bool isFullWidth;
  final bool isRounded;
  final bool isUppercase;
  final double elevation;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.disabled = false,
    this.icon,
    this.width,
    this.height = 48.0,
    this.borderRadius = 12.0,
    this.padding,
    this.customColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.hasShadow = true,
    this.isFullWidth = false,
    this.isRounded = false,
    this.isUppercase = false,
    this.elevation = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Determine button colors based on type and state
    Color backgroundColor;
    Color borderColor = Colors.transparent;
    Color textColor = this.textColor ?? Colors.white;
    Color? overlayColor;
    
    switch (type) {
      case ButtonType.primary:
        backgroundColor = customColor ?? theme.colorScheme.primary;
        overlayColor = Colors.white.withOpacity(0.2);
        break;
      case ButtonType.secondary:
        backgroundColor = customColor ?? theme.colorScheme.secondary;
        overlayColor = Colors.white.withOpacity(0.2);
        break;
      case ButtonType.text:
        backgroundColor = Colors.transparent;
        textColor = customColor ?? theme.colorScheme.primary;
        overlayColor = (customColor ?? theme.colorScheme.primary).withOpacity(0.1);
        break;
      case ButtonType.outlined:
        backgroundColor = Colors.transparent;
        borderColor = customColor ?? theme.colorScheme.primary;
        textColor = customColor ?? theme.colorScheme.primary;
        overlayColor = (customColor ?? theme.colorScheme.primary).withOpacity(0.1);
        break;
      case ButtonType.danger:
        backgroundColor = customColor ?? AppColors.error;
        overlayColor = Colors.white.withOpacity(0.2);
        break;
      case ButtonType.success:
        backgroundColor = customColor ?? AppColors.success;
        overlayColor = Colors.white.withOpacity(0.2);
        break;
    }

    // Handle disabled state
    if (disabled || isLoading) {
      backgroundColor = isDark ? Colors.grey[700]! : Colors.grey[400]!;
      textColor = isDark ? Colors.white70 : Colors.white;
      overlayColor = null;
    }

    // Calculate button width
    final double buttonWidth = isFullWidth
        ? double.infinity
        : width ?? (isRounded ? height : null) ?? 200.0;

    // Build button content
    Widget buttonContent = isLoading
        ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                type == ButtonType.text || type == ButtonType.outlined
                    ? textColor
                    : Colors.white,
              ),
              strokeWidth: 2.5,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: (fontSize ?? 16.0) * 1.2,
                  color: textColor,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  isUppercase ? text.toUpperCase() : text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize ?? 16.0,
                    fontWeight: fontWeight ?? FontWeight.w600,
                    letterSpacing: isUppercase ? 1.0 : 0.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

    // Return the appropriate button type
    if (type == ButtonType.text) {
      return TextButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          minimumSize: Size(buttonWidth, height),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRounded ? height / 2 : borderRadius),
          ),
          overlayColor: overlayColor,
        ),
        child: buttonContent,
      );
    } else if (type == ButtonType.outlined) {
      return OutlinedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          side: BorderSide(
            color: disabled ? Colors.grey : borderColor,
            width: 1.5,
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          minimumSize: Size(buttonWidth, height),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRounded ? height / 2 : borderRadius),
          ),
          elevation: hasShadow ? elevation : 0,
          shadowColor: backgroundColor.withOpacity(0.3),
          overlayColor: overlayColor,
        ),
        child: buttonContent,
      );
    } else {
      return ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          minimumSize: Size(buttonWidth, height),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRounded ? height / 2 : borderRadius),
          ),
          elevation: hasShadow ? elevation : 0,
          shadowColor: backgroundColor.withOpacity(0.3),
          overlayColor: overlayColor,
        ),
        child: buttonContent,
      );
    }
  }
}

class AnimatedCustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool disabled;
  final IconData? icon;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? customColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool hasShadow;
  final bool isFullWidth;
  final bool isRounded;
  final bool isUppercase;
  final double elevation;
  final Duration animationDuration;
  final Curve animationCurve;
  final double scaleBegin;
  final double scaleEnd;

  const AnimatedCustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.disabled = false,
    this.icon,
    this.width,
    this.height = 48.0,
    this.borderRadius = 12.0,
    this.padding,
    this.customColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.hasShadow = true,
    this.isFullWidth = false,
    this.isRounded = false,
    this.isUppercase = false,
    this.elevation = 2.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.scaleBegin = 1.0,
    this.scaleEnd = 0.95,
  });

  @override
  State<AnimatedCustomButton> createState() => _AnimatedCustomButtonState();
}

class _AnimatedCustomButtonState extends State<AnimatedCustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation = Tween<double>(
      begin: widget.scaleBegin,
      end: widget.scaleEnd,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onTapDown(TapDownDetails details) async {
    if (!widget.disabled && !widget.isLoading) {
      await _controller.forward();
    }
  }

  Future<void> _onTapUp(TapUpDetails details) async {
    if (!widget.disabled && !widget.isLoading) {
      await _controller.reverse();
      widget.onPressed();
    }
  }

  Future<void> _onTapCancel() async {
    if (!widget.disabled && !widget.isLoading) {
      await _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: CustomButton(
          text: widget.text,
          onPressed: widget.onPressed,
          type: widget.type,
          isLoading: widget.isLoading,
          disabled: widget.disabled,
          icon: widget.icon,
          width: widget.width,
          height: widget.height,
          borderRadius: widget.borderRadius,
          padding: widget.padding,
          customColor: widget.customColor,
          textColor: widget.textColor,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          hasShadow: widget.hasShadow,
          isFullWidth: widget.isFullWidth,
          isRounded: widget.isRounded,
          isUppercase: widget.isUppercase,
          elevation: widget.elevation,
        ),
      ),
    );
  }
}
