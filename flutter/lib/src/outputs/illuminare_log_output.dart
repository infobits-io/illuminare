import '../illuminare_log_output.dart';

/// Log output receives a [IlluminareOutputLog] from [LogPrinter] and sends it to the
/// desired destination.
///
/// This can be an output stream, a file or a network target. [IlluminareLogOutput] may
/// cache multiple log messages.
abstract class IlluminareLogOutput {
  const IlluminareLogOutput();

  void init() {}

  void output(IlluminareOutputLog output);

  void destroy() {}
}
