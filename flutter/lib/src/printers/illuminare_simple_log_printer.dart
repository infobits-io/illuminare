import '../ansi_color.dart';
import '../illuminare_log_event.dart';
import 'illuminare_log_printer.dart';

/// Outputs simple log messages:
/// ```
/// [ERROR] Log message  ERROR: Error info
/// ```
class IlluminareSimpleLogPrinter extends IlluminareLogPrinter {
  static final levelPrefixes = {
    IlluminareLogLevel.verbose: '[VERBOSE]',
    IlluminareLogLevel.debug: '[DEBUG]',
    IlluminareLogLevel.info: '[INFO]',
    IlluminareLogLevel.warning: '[WARNING]',
    IlluminareLogLevel.error: '[ERROR]',
    IlluminareLogLevel.fatal: '[FATAL]',
  };

  static final levelColors = {
    IlluminareLogLevel.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    IlluminareLogLevel.debug: AnsiColor.fg(null),
    IlluminareLogLevel.info: AnsiColor.fg(12),
    IlluminareLogLevel.warning: AnsiColor.fg(208),
    IlluminareLogLevel.error: AnsiColor.fg(196),
    IlluminareLogLevel.fatal: AnsiColor.fg(199),
  };

  final bool printTime;
  final bool colors;

  const IlluminareSimpleLogPrinter(
      {this.printTime = false, this.colors = true});

  @override
  List<String> log(IlluminareLogEvent logEvent) {
    var errorStr =
        logEvent.exception != "" ? '  ERROR: ${logEvent.exception}' : '';
    var timeStr = printTime ? 'TIME: ${DateTime.now().toIso8601String()}' : '';
    return [
      '${_labelFor(logEvent.level)} $timeStr ${logEvent.message}$errorStr'
    ];
  }

  String _labelFor(IlluminareLogLevel level) {
    var prefix = levelPrefixes[level]!;
    var color = levelColors[level]!;

    return colors ? color(prefix) : prefix;
  }
}
