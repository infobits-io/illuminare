import 'dart:collection';

import '../illuminare_log_output.dart';
import 'illuminare_log_output.dart';

/// Buffers [OutputEvent]s.
class IlluminareMemoryOutput extends IlluminareLogOutput {
  /// Maximum events in [buffer].
  final int bufferSize;

  /// A secondary [IlluminareLogOutput] to also received events.
  final IlluminareLogOutput? secondOutput;

  /// The buffer of events.
  final ListQueue<IlluminareOutputLog> buffer;

  IlluminareMemoryOutput({this.bufferSize = 20, this.secondOutput})
      : buffer = ListQueue(bufferSize);

  @override
  void output(IlluminareOutputLog output) {
    if (buffer.length == bufferSize) {
      buffer.removeFirst();
    }

    buffer.add(output);

    secondOutput?.output(output);
  }
}
