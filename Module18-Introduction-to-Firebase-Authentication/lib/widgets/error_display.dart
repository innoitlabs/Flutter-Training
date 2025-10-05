import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';

class ErrorDisplay extends StatelessWidget {
  final AuthProvider authProvider;
  final VoidCallback? onRetry;

  const ErrorDisplay({
    Key? key,
    required this.authProvider,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (authProvider.errorMessage == null) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getErrorColor(authProvider.errorType).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getErrorColor(authProvider.errorType).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getErrorIcon(authProvider.errorType),
                color: _getErrorColor(authProvider.errorType),
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getErrorTitle(authProvider.errorType),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _getErrorColor(authProvider.errorType),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 20),
                onPressed: () => authProvider.clearError(),
                color: _getErrorColor(authProvider.errorType),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            authProvider.errorMessage!,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          if (onRetry != null && _isRetryable(authProvider.errorType)) ...[
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getErrorColor(authProvider.errorType),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Try Again'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getErrorColor(AuthErrorType? errorType) {
    switch (errorType) {
      case AuthErrorType.network:
      case AuthErrorType.timeout:
        return Colors.orange;
      case AuthErrorType.firebaseAuth:
        return Colors.red;
      case AuthErrorType.validation:
        return Colors.amber;
      default:
        return Colors.red;
    }
  }

  IconData _getErrorIcon(AuthErrorType? errorType) {
    switch (errorType) {
      case AuthErrorType.network:
        return Icons.wifi_off;
      case AuthErrorType.timeout:
        return Icons.timer_off;
      case AuthErrorType.firebaseAuth:
        return Icons.error_outline;
      case AuthErrorType.validation:
        return Icons.warning_outlined;
      default:
        return Icons.error_outline;
    }
  }

  String _getErrorTitle(AuthErrorType? errorType) {
    switch (errorType) {
      case AuthErrorType.network:
        return 'Connection Error';
      case AuthErrorType.timeout:
        return 'Request Timeout';
      case AuthErrorType.firebaseAuth:
        return 'Authentication Error';
      case AuthErrorType.validation:
        return 'Validation Error';
      default:
        return 'Error';
    }
  }

  bool _isRetryable(AuthErrorType? errorType) {
    return errorType == AuthErrorType.network || 
           errorType == AuthErrorType.timeout;
  }
}
