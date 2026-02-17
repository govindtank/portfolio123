import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final bool showShadow;
  final double elevation;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isInteractive;
  final bool showOverlay;
  final Color? overlayColor;
  final double overlayOpacity;
  final bool showRippleEffect;
  final Color? rippleColor;
  final BorderRadius? rippleBorderRadius;
  final bool isGlassmorphic;
  final double glassmorphicIntensity;
  final double glassmorphicBlur;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;
  final Offset? animationOffset;

  const CustomCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.showShadow = true,
    this.elevation = 2.0,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius = 10.0,
    this.shadowSpreadRadius = 0.0,
    this.gradient,
    this.onTap,
    this.onLongPress,
    this.isInteractive = true,
    this.showOverlay = false,
    this.overlayColor,
    this.overlayOpacity = 0.1,
    this.showRippleEffect = true,
    this.rippleColor,
    this.rippleBorderRadius,
    this.isGlassmorphic = false,
    this.glassmorphicIntensity = 0.2,
    this.glassmorphicBlur = 4.0,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.animationOffset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Determine card color based on theme and props
    Color cardColor = color ?? 
        (isGlassmorphic 
            ? Colors.white.withOpacity(0.1) 
            : (color ?? theme.cardColor));
    
    // Create the base card
    Widget card = AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isGlassmorphic ? null : cardColor,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(16.0),
        border: showBorder
            ? Border.all(
                color: borderColor ?? theme.dividerColor,
                width: borderWidth,
              )
            : null,
        boxShadow: showShadow && !isGlassmorphic
            ? [
                BoxShadow(
                  color: (shadowColor ?? 
                      (isDark ? Colors.black : Colors.grey.withOpacity(0.3))),
                  offset: shadowOffset ?? const Offset(0, 4),
                  blurRadius: shadowBlurRadius,
                  spreadRadius: shadowSpreadRadius,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16.0),
        child: Stack(
          children: [
            // Glassmorphic effect
            if (isGlassmorphic)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(glassmorphicIntensity),
                      Colors.white.withOpacity(glassmorphicIntensity * 0.3),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1.0,
                  ),
                  borderRadius: borderRadius ?? BorderRadius.circular(16.0),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: glassmorphicBlur,
                    sigmaY: glassmorphicBlur,
                  ),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            
            // Content
            Padding(
              padding: padding ?? const EdgeInsets.all(16.0),
              child: child,
            ),
            
            // Overlay
            if (showOverlay)
              Container(
                decoration: BoxDecoration(
                  color: (overlayColor ?? theme.primaryColor)
                      .withOpacity(overlayOpacity),
                  borderRadius: borderRadius ?? BorderRadius.circular(16.0),
                ),
              ),
                
            // Ripple effect
            if (isInteractive && onTap != null && showRippleEffect)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    onLongPress: onLongPress,
                    borderRadius: rippleBorderRadius ?? 
                        (borderRadius as BorderRadius?) ?? 
                        BorderRadius.circular(16.0),
                    splashColor: rippleColor ?? theme.primaryColor.withOpacity(0.2),
                    highlightColor: rippleColor ?? theme.primaryColor.withOpacity(0.1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    // Add animation if enabled
    if (animate) {
      return TweenAnimationBuilder<Offset>(
        tween: Tween<Offset>(
          begin: animationOffset ?? const Offset(0, 20),
          end: Offset.zero,
        ),
        duration: animationDuration,
        curve: animationCurve,
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: Opacity(
              opacity: offset.dy == 0 ? 1.0 : 0.0 + (1 - (offset.dy / 20)),
              child: child,
            ),
          );
        },
        child: card,
      );
    }

    return card;
  }
}

class AnimatedCustomCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final bool showShadow;
  final double elevation;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isInteractive;
  final bool showOverlay;
  final Color? overlayColor;
  final double overlayOpacity;
  final bool showRippleEffect;
  final Color? rippleColor;
  final BorderRadius? rippleBorderRadius;
  final bool isGlassmorphic;
  final double glassmorphicIntensity;
  final double glassmorphicBlur;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;
  final Offset? animationOffset;
  final Duration hoverAnimationDuration;
  final Curve hoverAnimationCurve;
  final double hoverElevation;
  final double hoverScale;
  final Offset? hoverOffset;
  final bool showHoverEffect;

  const AnimatedCustomCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.showShadow = true,
    this.elevation = 2.0,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlurRadius = 10.0,
    this.shadowSpreadRadius = 0.0,
    this.gradient,
    this.onTap,
    this.onLongPress,
    this.isInteractive = true,
    this.showOverlay = false,
    this.overlayColor,
    this.overlayOpacity = 0.1,
    this.showRippleEffect = true,
    this.rippleColor,
    this.rippleBorderRadius,
    this.isGlassmorphic = false,
    this.glassmorphicIntensity = 0.2,
    this.glassmorphicBlur = 4.0,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.animationOffset,
    this.hoverAnimationDuration = const Duration(milliseconds: 200),
    this.hoverAnimationCurve = Curves.easeInOut,
    this.hoverElevation = 8.0,
    this.hoverScale = 1.02,
    this.hoverOffset,
    this.showHoverEffect = true,
  });

  @override
  State<AnimatedCustomCard> createState() => _AnimatedCustomCardState();
}

class _AnimatedCustomCardState extends State<AnimatedCustomCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  bool _isTapped = false;
  late final AnimationController _hoverController;
  late final AnimationController _tapController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _elevationAnimation;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    
    _hoverController = AnimationController(
      vsync: this,
      duration: widget.hoverAnimationDuration,
    );
    
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: widget.hoverAnimationCurve,
    ));
    
    _elevationAnimation = Tween<double>(
      begin: widget.elevation,
      end: widget.hoverElevation,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: widget.hoverAnimationCurve,
    ));
    
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: widget.hoverOffset ?? const Offset(0, -4),
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: widget.hoverAnimationCurve,
    ));
    
    // Handle initial animation if needed
    if (widget.animate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _hoverController.forward();
      });
    }
  }
  
  @override
  void dispose() {
    _hoverController.dispose();
    _tapController.dispose();
    super.dispose();
  }
  
  Future<void> _handleTapDown(TapDownDetails details) async {
    if (!widget.isInteractive) return;
    
    setState(() {
      _isTapped = true;
    });
    
    await _tapController.forward();
    await _tapController.reverse();
    
    if (mounted) {
      setState(() {
        _isTapped = false;
      });
    }
    
    widget.onTap?.call();
  }
  
  void _handleHover(bool isHovered) {
    if (!widget.showHoverEffect || !widget.isInteractive) return;
    
    setState(() {
      _isHovered = isHovered;
    });
    
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTapDown: widget.onTap != null ? _handleTapDown : null,
        onLongPress: widget.onLongPress,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: Listenable.merge([_hoverController, _tapController]),
          builder: (context, child) {
            double scale = _scaleAnimation.value;
            double elevation = _elevationAnimation.value;
            Offset offset = _offsetAnimation.value;
            
            // Apply tap effect
            if (_isTapped) {
              scale *= 0.98;
            }
            
            return Transform.scale(
              scale: scale,
              child: Transform.translate(
                offset: offset,
                child: CustomCard(
                  width: widget.width,
                  height: widget.height,
                  padding: widget.padding,
                  margin: widget.margin,
                  borderRadius: widget.borderRadius,
                  color: widget.color,
                  showBorder: widget.showBorder,
                  borderColor: widget.borderColor,
                  borderWidth: widget.borderWidth,
                  showShadow: widget.showShadow,
                  elevation: elevation,
                  shadowColor: widget.shadowColor,
                  shadowOffset: widget.shadowOffset,
                  shadowBlurRadius: widget.shadowBlurRadius,
                  shadowSpreadRadius: widget.shadowSpreadRadius,
                  gradient: widget.gradient,
                  onTap: widget.onTap,
                  onLongPress: widget.onLongPress,
                  isInteractive: widget.isInteractive,
                  showOverlay: widget.showOverlay || _isHovered,
                  overlayColor: widget.overlayColor,
                  overlayOpacity: widget.overlayOpacity,
                  showRippleEffect: widget.showRippleEffect,
                  rippleColor: widget.rippleColor,
                  rippleBorderRadius: widget.rippleBorderRadius,
                  isGlassmorphic: widget.isGlassmorphic,
                  glassmorphicIntensity: widget.glassmorphicIntensity,
                  glassmorphicBlur: widget.glassmorphicBlur,
                  animate: widget.animate,
                  animationDuration: widget.animationDuration,
                  animationCurve: widget.animationCurve,
                  animationOffset: widget.animationOffset,
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
