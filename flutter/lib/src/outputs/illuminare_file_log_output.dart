import 'dart:convert';
import 'dart:io';

import '../illuminare_log_output.dart';
import 'illuminare_log_output.dart';

class IlluminareFileLogOutput extends IlluminareLogOutput {
  final File file;
  final bool overrideExisting;
  final Encoding encoding;
  IOSink? _sink;

  IlluminareFileLogOutput({
    required this.file,
    this.overrideExisting = false,
    this.encoding = utf8,
  });

  @override
  void init() {
    _sink = file.openWrite(
      mode: overrideExisting ? FileMode.writeOnly : FileMode.writeOnlyAppend,
      encoding: encoding,
    );
  }

  @override
  void output(IlluminareOutputLog output) {
    _sink?.writeAll(output.lines, '\n');
    _sink?.writeln();
  }

  @override
  void destroy() async {
    await _sink?.flush();
    await _sink?.close();
  }
}
