import 'illuminare_log_event.dart';

/// Output log contains the level and lines of a log event
class IlluminareOutputLog {
  final IlluminareLogLevel level;
  final List<String> lines;

  IlluminareOutputLog(this.level, this.lines);
}
