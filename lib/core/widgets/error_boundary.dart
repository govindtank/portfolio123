import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'custom_button.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final bool showErrorDetails;
  final String? customErrorMessage;
  final VoidCallback? onRetry;
  final bool showRetryButton;
  final String retryButtonText;
  final bool showReportButton;
  final String reportButtonText;
  final Future<void> Function()? onReportError;
  final bool showCopyButton;
  final String copyButtonText;
  final bool showStackTraces;
  final bool showErrorWidget;
  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
    VoidCallback? onRetry,
  )? errorBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.showErrorDetails = true,
    this.customErrorMessage,
    this.onRetry,
    this.showRetryButton = true,
    this.retryButtonText = 'Retry',
    this.showReportButton = false,
    this.reportButtonText = 'Report Error',
    this.onReportError,
    this.showCopyButton = true,
    this.copyButtonText = 'Copy Error',
    this.showStackTraces = !kReleaseMode,
    this.showErrorWidget = true,
    this.errorBuilder,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;
  bool _isReporting = false;
  bool _hasCopied = false;

  @override
  void initState() {
    super.initState();
  }

  void didCatchError(Object error, StackTrace stackTrace) {
    setState(() {
      _error = error;
      _stackTrace = stackTrace;
    });
    // Log the error
    debugPrint('ErrorBoundary caught error: $error\n$stackTrace');
  }

  void _handleRetry() {
    setState(() {
      _error = null;
      _stackTrace = null;
      _hasCopied = false;
    });
    widget.onRetry?.call();
  }

  Future<void> _handleReportError() async {
    if (widget.onReportError == null) return;
    
    setState(() => _isReporting = true);
    try {
      await widget.onReportError!();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error reported successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to report error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isReporting = false);
      }
    }
  }

  Future<void> _copyErrorToClipboard() async {
    final errorDetails = _getErrorDetails();
    await Clipboard.setData(ClipboardData(text: errorDetails));
    if (mounted) {
      setState(() => _hasCopied = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error details copied to clipboard')),
      );
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _hasCopied = false);
      }
    }
  }

  String _getErrorDetails() {
    final buffer = StringBuffer();
    buffer.writeln('Error: $_error');
    if (widget.showStackTraces && _stackTrace != null) {
      buffer.writeln('\nStack trace:');
      buffer.writeln(_stackTrace);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null && widget.showErrorWidget) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(
          context,
          _error!,
          _stackTrace,
          _handleRetry,
        );
      }
      
      return _ErrorBoundaryWidget(
        error: _error!,
        stackTrace: _stackTrace,
        showErrorDetails: widget.showErrorDetails,
        customErrorMessage: widget.customErrorMessage,
        showRetryButton: widget.showRetryButton,
        retryButtonText: widget.retryButtonText,
        showReportButton: widget.showReportButton,
        reportButtonText: widget.reportButtonText,
        showCopyButton: widget.showCopyButton,
        copyButtonText: widget.copyButtonText,
        showStackTraces: widget.showStackTraces,
        onRetry: _handleRetry,
        onReportError: widget.onReportError != null ? _handleReportError : null,
        onCopyError: _copyErrorToClipboard,
        isReporting: _isReporting,
        hasCopied: _hasCopied,
      );
    }
    
    return widget.child;
  }
}

class _ErrorBoundaryWidget extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final bool showErrorDetails;
  final String? customErrorMessage;
  final bool showRetryButton;
  final String retryButtonText;
  final bool showReportButton;
  final String reportButtonText;
  final bool showCopyButton;
  final String copyButtonText;
  final bool showStackTraces;
  final VoidCallback onRetry;
  final VoidCallback? onReportError;
  final VoidCallback? onCopyError;
  final bool isReporting;
  final bool hasCopied;

  const _ErrorBoundaryWidget({
    required this.error,
    this.stackTrace,
    this.showErrorDetails = true,
    this.customErrorMessage,
    this.showRetryButton = true,
    this.retryButtonText = 'Retry',
    this.showReportButton = false,
    this.reportButtonText = 'Report Error',
    this.showCopyButton = true,
    this.copyButtonText = 'Copy Error',
    this.showStackTraces = true,
    required this.onRetry,
    this.onReportError,
    this.onCopyError,
    this.isReporting = false,
    this.hasCopied = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Error illustration
              SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(
                  'assets/animations/error_animation.json',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.error_outline,
                    size: 120,
                    color: colorScheme.error,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Error title
              Text(
                'Oops! Something went wrong',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // Custom error message or default
              Text(
                customErrorMessage ??
                    'We encountered an error while loading this page. Please try again.',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              
              if (showErrorDetails) ..._buildErrorDetails(theme, colorScheme),
              
              const SizedBox(height: 32),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showRetryButton) ...[
                    CustomButton(
                      onPressed: onRetry,
                      text: retryButtonText,
                      icon: Icons.refresh,
                      type: ButtonType.primary,
                    ),
                    const SizedBox(width: 12),
                  ],
                  
                  if (showReportButton && onReportError != null)
                    CustomButton(
                      onPressed: isReporting ? () {} : () { if (onReportError != null) onReportError!(); },
                      text: isReporting ? 'Reporting...' : reportButtonText,
                      icon: isReporting ? Icons.hourglass_top : Icons.report_problem,
                      type: ButtonType.secondary,
                      isLoading: isReporting,
                    ),
                  
                  if (showCopyButton && onCopyError != null) ...[
                    const SizedBox(width: 12),
                    CustomButton(
                      onPressed: hasCopied ? () {} : () { if (onCopyError != null) onCopyError!(); },
                      text: hasCopied ? 'Copied!' : copyButtonText,
                      icon: hasCopied ? Icons.check : Icons.copy,
                      type: ButtonType.outlined,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildErrorDetails(ThemeData theme, ColorScheme colorScheme) {
    if (!showErrorDetails) return [];
    
    return [
      const SizedBox(height: 24),
      
      // Error details header
      Text(
        'Error Details:',
        style: theme.textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface.withOpacity(0.7),
          fontWeight: FontWeight.bold,
        ),
      ),
      
      const SizedBox(height: 8),
      
      // Error message
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.error.withOpacity(0.2)),
        ),
        child: SelectableText(
          error.toString(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface,
            fontFamily: 'monospace',
          ),
        ),
      ),
      
      // Stack trace if enabled
      if (showStackTraces && stackTrace != null) ...[
        const SizedBox(height: 12),
        
        Text(
          'Stack Trace:',
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
          ),
          child: SingleChildScrollView(
            child: SelectableText(
              stackTrace.toString(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
                fontFamily: 'monospace',
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    ];
  }
}
