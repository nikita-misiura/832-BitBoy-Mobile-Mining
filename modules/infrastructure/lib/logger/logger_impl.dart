import 'dart:io';

import 'package:infrastructure/logger/logger_barrel.dart';
import 'package:logger/logger.dart' as l;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';



class LoggerImpl implements Logger {
  final LogEnvironment _env;

  late final l.Logger _logger;

  static late final Logger instance;

  LoggerImpl(this._env);

  @override
  Future<void> init() async {
    final logsDir = await _createLogsDirectory();

    final logsFile = await _createLogsFile(logsDir);

    _logger = switch (_env) {
      LogEnvironment.dev => l.Logger(
        level: l.Level.debug,
        output: l.ConsoleOutput(),
        printer: l.PrettyPrinter(),
        filter: l.DevelopmentFilter(),
      ),
      LogEnvironment.prod => l.Logger(
        level: l.Level.info,
        output: l.FileOutput(file: logsFile),
        printer: l.SimplePrinter(),
        filter: l.ProductionFilter(),
      ),
    };

    instance = this;
  }

  Future<Directory> _createLogsDirectory() async {
    final logsDirPath = await _getLogsDirectoryPath();

    return Directory(logsDirPath).create(recursive: true);
  }

  Future<String> _getLogsDirectoryPath() async {
    final applicationDirectory = await getApplicationCacheDirectory();

    return path.join(applicationDirectory.path, 'logs');
  }

  Future<File> _createLogsFile(Directory logsDirectory) async {
    final logsFileName = _generateLogsFileName();
    final logsFilePath = path.join(logsDirectory.path, logsFileName);

    await _cleanOldLogs();

    return File(logsFilePath);
  }

  String _generateLogsFileName() {
    final dateTime = _formatDateTime(DateTime.now());

    return 'logs_$dateTime.log';
  }

  Future<void> _cleanOldLogs() async {
    final logFiles = await _getLogFilesFromDirectory();

    if (logFiles.length < 4) return;

    logFiles.sort(
          (a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()),
    );

    await logFiles.last.delete();
  }

  Future<List<File>> _getLogFilesFromDirectory() async {
    final logsDirPath = await _getLogsDirectoryPath();
    final logFiles = Directory(logsDirPath).list();
    final files = logFiles.where((lf) => lf is File).cast<File>().toList();

    return files;
  }

  String _formatDateTime(DateTime dateTime) {
    final formattedDate = dateTime.toString().substring(0, 19);
    final dateParts = formattedDate.split(' ');
    final date = dateParts[0];
    final time = dateParts[1];

    return '$date-$time.${dateTime.millisecond}';
  }

  @override
  void d(String msg) => _logger.log(l.Level.debug, msg);

  @override
  void i(String msg) => _logger.log(l.Level.info, msg);

  @override
  void w(String msg) => _logger.log(l.Level.warning, msg);

  @override
  void e(String msg) => _logger.log(l.Level.error, msg);

  @override
  void f(String msg) => _logger.log(l.Level.fatal, msg);

  @override
  void log(String msg, LogLevel l) => _logger.log(_mapLevel(l), msg);

  l.Level _mapLevel(LogLevel level) {
    return switch (level) {
      LogLevel.all => l.Level.all,
      LogLevel.trace => l.Level.trace,
      LogLevel.debug => l.Level.debug,
      LogLevel.info => l.Level.info,
      LogLevel.warning => l.Level.warning,
      LogLevel.error => l.Level.error,
      LogLevel.fatal => l.Level.fatal,
      LogLevel.off => l.Level.off,
    };
  }

  @override
  Future<void> deinit() async {
    await _logger.close();
  }
}
