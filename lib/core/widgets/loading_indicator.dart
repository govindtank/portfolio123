import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum LoadingIndicatorSize {
  small(24.0),
  medium(36.0),
  large(48.0),
  xlarge(64.0);

  final double size;

  const LoadingIndicatorSize(this.size);
}

class LoadingIndicator extends StatelessWidget {
  final LoadingIndicatorSize size;
  final Color? color;
  final double strokeWidth;
  final String? message;
  final bool showBackground;
  final Color? backgroundColor;
  final double backgroundOpacity;
  final bool isCircular;
  final double? customSize;
  final Animation<Color?>? valueColor;
  final bool useAdaptive;
  final double? radius;
  final bool showMessageBelow;
  final TextStyle? messageStyle;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;
  final bool centerInScreen;
  final bool showPercentage;
  final double? value;
  final String? semanticsLabel;
  final String? semanticsValue;
  final Color? backgroundColorMaterial;
  final double? minHeight;
  final double? minWidth;
  final EdgeInsetsGeometry? padding;
  final bool isLinear;
  final double? valueLinear;
  final Color? valueColorLinear;
  final Color? backgroundColorLinear;
  final double? minHeightLinear;
  final double? minWidthLinear;
  final BorderRadiusGeometry? borderRadiusLinear;
  final bool isExpanded;
  final BorderRadius? borderRadius;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final bool showShadow;
  final double elevation;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final bool isPulsing;
  final bool isRotating;
  final bool isBouncing;
  final bool isSliding;
  final bool isFading;
  final bool isScaling;
  final bool isDots;
  final int dotCount;
  final double dotSize;
  final double dotSpacing;
  final Color? dotColor;
  final Duration dotAnimationDuration;
  final Curve dotAnimationCurve;
  final bool isStaggeredDots;
  final bool isPulseDots;
  final bool isWaveDots;
  final bool isCircleDots;
  final bool isCustomAnimation;
  final Widget? customAnimation;

  const LoadingIndicator({
    super.key,
    this.size = LoadingIndicatorSize.medium,
    this.color,
    this.strokeWidth = 4.0,
    this.message,
    this.showBackground = false,
    this.backgroundColor,
    this.backgroundOpacity = 0.8,
    this.isCircular = true,
    this.customSize,
    this.valueColor,
    this.useAdaptive = true,
    this.radius,
    this.showMessageBelow = true,
    this.messageStyle,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 8.0,
    this.centerInScreen = false,
    this.showPercentage = false,
    this.value,
    this.semanticsLabel,
    this.semanticsValue,
    this.backgroundColorMaterial,
    this.minHeight,
    this.minWidth,
    this.padding,
    this.isLinear = false,
    this.valueLinear,
    this.valueColorLinear,
    this.backgroundColorLinear,
    this.minHeightLinear,
    this.minWidthLinear,
    this.borderRadiusLinear,
    this.isExpanded = false,
    this.borderRadius,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.showShadow = false,
    this.elevation = 2.0,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius = 4.0,
    this.shadowSpreadRadius = 0.0,
    this.isPulsing = false,
    this.isRotating = false,
    this.isBouncing = false,
    this.isSliding = false,
    this.isFading = false,
    this.isScaling = false,
    this.isDots = false,
    this.dotCount = 3,
    this.dotSize = 8.0,
    this.dotSpacing = 4.0,
    this.dotColor,
    this.dotAnimationDuration = const Duration(milliseconds: 800),
    this.dotAnimationCurve = Curves.easeInOut,
    this.isStaggeredDots = false,
    this.isPulseDots = false,
    this.isWaveDots = false,
    this.isCircleDots = false,
    this.isCustomAnimation = false,
    this.customAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveColor = color ?? theme.colorScheme.primary;
    final effectiveBackgroundColor =
        backgroundColor ?? (isDark ? Colors.black54 : Colors.white);
    final effectiveSize = customSize ?? size.size;
    final effectiveMessageStyle = messageStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: isDark ? Colors.white70 : Colors.black87,
        );

    Widget indicator;

    if (isCustomAnimation && customAnimation != null) {
      indicator = customAnimation!;
    } else if (isCircular) {
      indicator = SizedBox(
        width: effectiveSize,
        height: effectiveSize,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth,
          valueColor:
              valueColor ?? AlwaysStoppedAnimation<Color>(effectiveColor),
          backgroundColor: backgroundColorMaterial,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        ),
      );
    } else if (isLinear) {
      indicator = LinearProgressIndicator(
        value: valueLinear,
        backgroundColor: backgroundColorLinear,
        valueColor: valueColor ?? AlwaysStoppedAnimation<Color>(effectiveColor),
        minHeight: minHeightLinear,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
      );
    } else if (isDots) {
      indicator = _buildDotsIndicator(effectiveColor);
    } else {
      // Default to circular progress indicator
      indicator = SizedBox(
        width: effectiveSize,
        height: effectiveSize,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth,
          valueColor:
              valueColor ?? AlwaysStoppedAnimation<Color>(effectiveColor),
          backgroundColor: backgroundColorMaterial,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        ),
      );
    }

    // Apply animations
    if (isPulsing) {
      indicator = _buildPulsingAnimation(indicator);
    }

    if (isRotating) {
      indicator = _buildRotatingAnimation(indicator);
    }

    if (isBouncing) {
      indicator = _buildBouncingAnimation(indicator);
    }

    if (isSliding) {
      indicator = _buildSlidingAnimation(indicator);
    }

    if (isFading) {
      indicator = _buildFadingAnimation(indicator);
    }

    if (isScaling) {
      indicator = _buildScalingAnimation(indicator);
    }

    // Add message if provided
    if (message != null) {
      final messageWidget = Text(
        message!,
        style: effectiveMessageStyle,
        textAlign: TextAlign.center,
      );

      if (showMessageBelow) {
        indicator = Column(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            indicator,
            SizedBox(height: spacing),
            messageWidget,
          ],
        );
      } else {
        indicator = Row(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            indicator,
            SizedBox(width: spacing),
            messageWidget,
          ],
        );
      }
    }

    // Add background if needed
    if (showBackground) {
      indicator = Container(
        padding: padding ?? const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: effectiveBackgroundColor.withOpacity(backgroundOpacity),
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
          border: showBorder
              ? Border.all(
                  color: borderColor ?? theme.dividerColor,
                  width: borderWidth,
                )
              : null,
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: (shadowColor ?? Colors.black).withOpacity(0.1),
                    blurRadius: shadowBlurRadius,
                    spreadRadius: shadowSpreadRadius,
                    offset: shadowOffset ?? const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: indicator,
      );
    }

    // Center in screen if needed
    if (centerInScreen) {
      indicator = Center(
        child: indicator,
      );
    }

    // Apply minimum dimensions if provided
    if (minHeight != null || minWidth != null) {
      indicator = ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minHeight ?? 0.0,
          minWidth: minWidth ?? 0.0,
        ),
        child: indicator,
      );
    }

    // Apply expanded if needed
    if (isExpanded) {
      indicator = Expanded(
        child: indicator,
      );
    }

    return indicator;
  }

  Widget _buildPulsingAnimation(Widget child) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.3, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
    );
  }

  Widget _buildRotatingAnimation(Widget child) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: AnimationController(
            vsync: _RotatingAnimationProxy(),
            duration: const Duration(seconds: 1),
          )..repeat(),
          curve: Curves.linear,
        ),
      ),
      child: child,
    );
  }

  Widget _buildBouncingAnimation(Widget child) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 10.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, -value),
          child: child,
        );
      },
    );
  }

  Widget _buildSlidingAnimation(Widget child) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
    );
  }

  Widget _buildFadingAnimation(Widget child) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
    );
  }

  Widget _buildScalingAnimation(Widget child) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
    );
  }

  Widget _buildDotsIndicator(Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dotCount, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: dotSpacing / 2),
          child: AnimatedDot(
            color: dotColor ?? color,
            size: dotSize,
            delay: index * 200,
            isPulse: isPulseDots,
            isWave: isWaveDots,
            isCircle: isCircleDots,
            isStaggered: isStaggeredDots,
          ),
        );
      }),
    );
  }
}

class _RotatingAnimationProxy implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

class AnimatedDot extends StatefulWidget {
  final Color color;
  final double size;
  final int delay;
  final bool isPulse;
  final bool isWave;
  final bool isCircle;
  final bool isStaggered;

  const AnimatedDot({
    required this.color,
    required this.size,
    required this.delay,
    this.isPulse = false,
    this.isWave = false,
    this.isCircle = false,
    this.isStaggered = false,
  });

  @override
  State<AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500 + widget.delay),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double size = widget.size;
        double opacity = 1.0;
        double offsetY = 0.0;

        if (widget.isPulse) {
          size = widget.size * (0.5 + 0.5 * _animation.value);
          opacity = 0.5 + 0.5 * _animation.value;
        } else if (widget.isWave) {
          offsetY = -10.0 * _animation.value;
        } else if (widget.isStaggered) {
          size = widget.size * (0.5 + 0.5 * _animation.value);
        }

        return Transform.translate(
          offset: Offset(0, offsetY),
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: widget.color,
                shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
                borderRadius:
                    widget.isCircle ? null : BorderRadius.circular(size / 2),
              ),
            ),
          ),
        );
      },
    );
  }
}
