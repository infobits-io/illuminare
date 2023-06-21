import '../illuminare_log_output.dart';
import 'illuminare_log_output.dart';

/// Default implementation of [IlluminareLogOutput].
///
/// It sends everything to the system console.
class IlluminareConsoleLogOutput extends IlluminareLogOutput {
  const IlluminareConsoleLogOutput();

  @override
  void output(IlluminareOutputLog output) {
    // ignore: avoid_print
    output.lines.forEach(print);
  }
}
