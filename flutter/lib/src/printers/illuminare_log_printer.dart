import '../illuminare_log_event.dart';

/// An abstract handler of log events.
///
/// A log printer creates and formats the output, which is then sent to
/// [IlluminareOutputLog].
///
/// You can implement a `IlluminareLogPrinter` from scratch or extend [IlluminarePrettyLogPrinter].
abstract class IlluminareLogPrinter {
  const IlluminareLogPrinter();

  void init() {}

  /// Is called every time a new [IlluminareLogEvent] is sent and handles printing or
  /// storing the message.
  List<String> log(IlluminareLogEvent logEvent);

  void destroy() {}
}
