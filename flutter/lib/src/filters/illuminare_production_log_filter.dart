import '../illuminare_log_event.dart';
import 'illuminare_log_filter.dart';

/// Prints all logs with `level >= Logger.level` even in production.
class IlluminareProductionLogFilter extends IlluminareLogFilter {
  const IlluminareProductionLogFilter({super.level = IlluminareLogLevel.info});

  @override
  bool shouldLog(IlluminareLogEvent logEvent) {
    return logEvent.level.index >= level!.index;
  }
}
