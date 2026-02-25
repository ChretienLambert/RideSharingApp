import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Log levels for categorizing log messages
enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

/// A comprehensive logging utility for the ride-sharing app
/// Logs messages to console in debug mode and can be extended
/// to send logs to remote services in production.
class AppLogger {
  static const String _appName = 'RideSharingApp';
  static bool _enableConsoleLogs = true;
  static LogLevel _minLogLevel = LogLevel.debug;

  /// Initialize the logger with configuration
  static void initialize({
    bool enableConsoleLogs = true,
    LogLevel minLogLevel = LogLevel.debug,
  }) {
    _enableConsoleLogs = enableConsoleLogs;
    _minLogLevel = minLogLevel;
    info('Logger initialized', tag: 'AppLogger');
  }

  /// Log a debug message
  static void debug(String message, {String? tag, Object? data}) {
    _log(LogLevel.debug, message, tag: tag, data: data);
  }

  /// Log an info message
  static void info(String message, {String? tag, Object? data}) {
    _log(LogLevel.info, message, tag: tag, data: data);
  }

  /// Log a warning message
  static void warning(String message,
      {String? tag, Object? data, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message,
        tag: tag, data: data, stackTrace: stackTrace);
  }

  /// Log an error message
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Object? data,
  }) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Log a fatal error message
  static void fatal(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Object? data,
  }) {
    _log(
      LogLevel.fatal,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Internal logging method
  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Object? data,
  }) {
    // Check if we should log this level
    if (level.index < _minLogLevel.index) {
      return;
    }

    final timestamp = DateTime.now().toIso8601String();
    final levelName = level.name.toUpperCase();
    final tagName = tag ?? 'General';

    // Build log entry
    final logEntry = StringBuffer();
    logEntry.writeln('[$timestamp] $_appName | $levelName | $tagName');
    logEntry.writeln('  Message: $message');

    if (error != null) {
      logEntry.writeln('  Error: $error');
    }

    if (stackTrace != null) {
      logEntry.writeln('  StackTrace:\n$stackTrace');
    }

    if (data != null) {
      logEntry.writeln('  Data: $data');
    }

    // Log to console in debug mode
    if (_enableConsoleLogs && kDebugMode) {
      // Use different colors for different log levels
      final coloredMessage = _getColoredLog(level, logEntry.toString());
      debugPrint(coloredMessage);
    }

    if (!kDebugMode && level.index >= LogLevel.error.index) {
      _sendToRemoteLogging(logEntry.toString(), level,
          error: error, stackTrace: stackTrace);
    }
  }

  /// Get colored log output for console
  static String _getColoredLog(LogLevel level, String message) {
    // ANSI color codes for terminal output
    const reset = '\x1B[0m';
    const red = '\x1B[31m';
    const green = '\x1B[32m';
    const yellow = '\x1B[33m';
    const blue = '\x1B[34m';
    const magenta = '\x1B[35m';

    String color;
    switch (level) {
      case LogLevel.debug:
        color = blue;
        break;
      case LogLevel.info:
        color = green;
        break;
      case LogLevel.warning:
        color = yellow;
        break;
      case LogLevel.error:
        color = red;
        break;
      case LogLevel.fatal:
        color = magenta;
        break;
    }

    return '$color$message$reset';
  }

  /// Send log to remote logging service (simplified version)
  static void _sendToRemoteLogging(
    String logEntry,
    LogLevel level, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    try {
      // Remote logging service removed due to dependency issues
      // In production, consider adding proper error tracking service

      if (kDebugMode) {
        debugPrint('[$level] AppLogger: $logEntry');
        if (error != null) {
          debugPrint('Error: $error');
          if (stackTrace != null) {
            debugPrint('StackTrace: $stackTrace');
          }
        }
      }
    } catch (e) {
      // Silently fail to avoid logging loops
      // Remote logging failures shouldn't crash the app
    }
  }

  /// Log navigation events
  static void logNavigation(String fromRoute, String toRoute,
      {Map<String, dynamic>? arguments}) {
    info(
      'Navigation: $fromRoute → $toRoute',
      tag: 'Navigation',
      data: arguments,
    );
  }

  /// Log user actions
  static void logUserAction(String action, {Map<String, dynamic>? metadata}) {
    info(
      'User Action: $action',
      tag: 'UserAction',
      data: metadata,
    );
  }

  /// Log API calls
  static void logApiCall(
    String method,
    String endpoint, {
    Map<String, dynamic>? requestData,
    dynamic responseData,
    int? statusCode,
    Duration? duration,
  }) {
    final data = <String, dynamic>{
      'method': method,
      'endpoint': endpoint,
      if (requestData != null) 'request': requestData,
      if (responseData != null) 'response': responseData,
      if (statusCode != null) 'statusCode': statusCode,
      if (duration != null) 'durationMs': duration.inMilliseconds,
    };

    if (statusCode != null && statusCode >= 400) {
      error(
        'API Error: $method $endpoint - Status $statusCode',
        tag: 'API',
        data: data,
      );
    } else {
      debug(
        'API Call: $method $endpoint',
        tag: 'API',
        data: data,
      );
    }
  }

  /// Log authentication events
  static void logAuth(String event,
      {String? userId, bool success = true, String? error}) {
    final data = <String, dynamic>{
      'event': event,
      if (userId != null) 'userId': userId,
      'success': success,
      if (error != null) 'error': error,
    };

    if (success) {
      info('Auth Event: $event', tag: 'Auth', data: data);
    } else {
      AppLogger.error('Auth Failed: $event', tag: 'Auth', data: data);
    }
  }

  /// Log widget lifecycle events
  static void logWidgetLifecycle(String widgetName, String lifecycleEvent) {
    debug(
      'Widget Lifecycle: $widgetName - $lifecycleEvent',
      tag: 'Widget',
    );
  }

  /// Log performance metrics
  static void logPerformance(String operation, Duration duration,
      {Map<String, dynamic>? metadata}) {
    info(
      'Performance: $operation took ${duration.inMilliseconds}ms',
      tag: 'Performance',
      data: {'durationMs': duration.inMilliseconds, ...?metadata},
    );
  }
}

/// Extension to easily log errors from Futures
extension FutureLogging<T> on Future<T> {
  /// Log errors when the future completes with an error
  Future<T> logErrors(String operation, {String? tag}) {
    return catchError((error, stackTrace) {
      AppLogger.error(
        'Future error in $operation',
        tag: tag ?? 'Future',
        error: error,
        stackTrace: stackTrace,
      );
      throw error;
    });
  }
}

/// Mixin for logging in State classes
mixin LoggingMixin<T extends StatefulWidget> on State<T> {
  String get widgetName => T.toString();

  @override
  void initState() {
    super.initState();
    AppLogger.logWidgetLifecycle(widgetName, 'initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppLogger.logWidgetLifecycle(widgetName, 'didChangeDependencies');
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    AppLogger.logWidgetLifecycle(widgetName, 'didUpdateWidget');
  }

  @override
  void dispose() {
    AppLogger.logWidgetLifecycle(widgetName, 'dispose');
    super.dispose();
  }
}
