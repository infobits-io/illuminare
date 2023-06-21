import 'illuminare.dart';
import 'illuminare_log_event.dart';

/// The class for logging to the Illuminare Service
class IlluminareLogger {
  /// Log at verbose level
  ///
  /// [message] A descriptive message
  static void verbose(dynamic message) {
    Illuminare.instance.recordLog(IlluminareLogLevel.verbose, message);
  }

  /// Log at debug level
  ///
  /// [message] A descriptive message
  static void debug(dynamic message) {
    Illuminare.instance.recordLog(IlluminareLogLevel.debug, message);
  }

  /// Log at info level
  ///
  /// [message] A descriptive message
  static void info(dynamic message) {
    Illuminare.instance.recordLog(IlluminareLogLevel.info, message);
  }

  /// Log at warn level
  ///
  /// [message] A descriptive message
  static void warn(dynamic message) {
    Illuminare.instance.recordLog(IlluminareLogLevel.warning, message);
  }

  /// Log at error level
  ///
  /// [message] A descriptive message
  static void error(dynamic message) {
    Illuminare.instance.recordLog(IlluminareLogLevel.error, message);
  }

  /// Log at fatal level
  ///
  /// [message] A descriptive message
  static void fatal(dynamic message) {
    Illuminare.instance.recordLog(IlluminareLogLevel.fatal, message);
  }
}
