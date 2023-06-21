import '../illuminare_log_event.dart';
import 'illuminare_log_filter.dart';

/// Prints all logs with `level >= Logger.level` while in development mode (eg
/// when `assert`s are evaluated, Flutter calls this debug mode).
///
/// In release mode ALL logs are omitted.
class IlluminareDevelopmentLogFilter extends IlluminareLogFilter {
  const IlluminareDevelopmentLogFilter({
    super.level = IlluminareLogLevel.verbose,
  });

  @override
  bool shouldLog(IlluminareLogEvent logEvent) {
    var shouldLog = false;
    assert(() {
      if (logEvent.level.index >= level!.index) {
        shouldLog = true;
      }
      return true;
    }());
    return shouldLog;
  }
}
