import 'illuminare_trace.dart';

enum IlluminareLogLevel { verbose, debug, info, warning, error, fatal }

class IlluminareLogEvent {
  final IlluminareLogLevel level;
  final dynamic message;
  final dynamic exception;
  final String? information;
  final List<IlluminareTrace>? stackTrace;
  final DateTime loggedAt = DateTime.now();

  IlluminareLogEvent({
    required this.level,
    required this.message,
    required this.exception,
    required this.information,
    required this.stackTrace,
  });
}
