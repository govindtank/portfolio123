import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationUtils {
  // Animation paths
  static const String loadingAnimation = 'assets/animations/loading_animation.json';
  
  // Animation widgets
  static Widget buildLoadingAnimation({
    double? width,
    double? height,
    bool repeat = true,
    bool reverse = false,
    double? aspectRatio,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    String? package,
    void Function(LottieComposition)? onLoaded,
    Key? key,
    AssetBundle? bundle,
    bool addRepaintBoundary = true,
    FilterQuality filterQuality = FilterQuality.low,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      loadingAnimation,
      width: width,
      height: height,
      repeat: repeat,
      reverse: reverse,
      frameRate: FrameRate.max,
      animate: true,
      fit: fit,
      alignment: alignment,
      package: package,
      onLoaded: onLoaded,
      key: key,
      bundle: bundle,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  // Pre-cache animations
  static Future<void> precacheAnimations(BuildContext context) async {
    await precacheAsset(
      context,
      const AssetImage(loadingAnimation),
    );
  }

  // Helper method to pre-cache assets
  static Future<void> precacheAsset(
    BuildContext context,
    ImageProvider provider, {
    ImageErrorListener? onError,
  }) async {
    return await precacheImage(
      provider,
      context,
      onError: onError ?? (_, __) {},
    );
  }
}
