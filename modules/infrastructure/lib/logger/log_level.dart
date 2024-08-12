/// [LogLevel]s to control logging output.
///
/// Logging can be enabled to include all levels above certain [LogLevel].
enum LogLevel {
  all(0),
  trace(1),
  debug(2),
  info(3),
  warning(4),
  error(5),
  fatal(6),
  off(10);

  final int value;

  const LogLevel(this.value);
}
