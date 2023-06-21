import 'illuminare_log_event.dart';

class IlluminareOutputLog {
  final IlluminareLogLevel level;
  final List<String> lines;

  IlluminareOutputLog(this.level, this.lines);
}
