
import 'dart:developer';

import 'log_env.dart';
import 'logger.dart';
import 'logger_impl.dart';

Logger get logger => LoggerImpl.instance;

class LoggerProvider {
  const LoggerProvider._();

  static Future<Logger> createLogger(LogEnvironment environment) async {
    final logger = LoggerImpl(environment);

    await logger.init();

    return logger;
  }
}