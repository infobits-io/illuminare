import '../illuminare_log_output.dart';
import 'illuminare_log_output.dart';

/// Logs simultaneously to multiple [IlluminareLogOutput] outputs.
class MultiOutput extends IlluminareLogOutput {
  late List<IlluminareLogOutput> _outputs;

  MultiOutput(List<IlluminareLogOutput?>? outputs) {
    _outputs = _normalizeOutputs(outputs);
  }
  List<IlluminareLogOutput> _normalizeOutputs(
      List<IlluminareLogOutput?>? outputs) {
    final normalizedOutputs = <IlluminareLogOutput>[];

    if (outputs != null) {
      for (final output in outputs) {
        if (output != null) {
          normalizedOutputs.add(output);
        }
      }
    }

    return normalizedOutputs;
  }

  @override
  void init() {
    for (var o in _outputs) {
      o.init();
    }
  }

  @override
  void output(IlluminareOutputLog output) {
    for (var o in _outputs) {
      o.output(output);
    }
  }

  @override
  void destroy() {
    for (var o in _outputs) {
      o.destroy();
    }
  }
}
