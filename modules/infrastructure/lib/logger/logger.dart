import 'log_level.dart';

abstract class Logger {
  /// Initializes logger.
  Future<void> init();

  /// Log a message at level [LogLevel.debug].
  void d(String message);

  /// Log a message at level [LogLevel.info].
  void i(String message);

  /// Log a message at level [LogLevel.warning].
  void w(String message);

  /// Log a message at level [LogLevel.error].
  void e(String message);

  /// Log a message at level [LogLevel.fatal].
  void f(String message);

  /// Log a [message] with [level].
  void log(String message, LogLevel level);

  /// Deinitializes the logger.
  Future<void> deinit();
}