import 'dart:async';

import '../illuminare_log_output.dart';
import 'illuminare_log_output.dart';

class IlluminareStreamLogOutput extends IlluminareLogOutput {
  late StreamController<List<String>> _controller;
  bool _shouldForward = false;

  IlluminareStreamLogOutput() {
    _controller = StreamController<List<String>>(
      onListen: () => _shouldForward = true,
      onPause: () => _shouldForward = false,
      onResume: () => _shouldForward = true,
      onCancel: () => _shouldForward = false,
    );
  }

  Stream<List<String>> get stream => _controller.stream;

  @override
  void output(IlluminareOutputLog output) {
    if (!_shouldForward) {
      return;
    }

    _controller.add(output.lines);
  }

  @override
  void destroy() {
    _controller.close();
  }
}
