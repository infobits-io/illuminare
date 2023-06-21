class IlluminareTrace {
  String file;
  String? className;
  String? method;
  int? line;
  int? column;

  IlluminareTrace({
    required this.file,
    this.className,
    this.method,
    this.line,
    this.column,
  });
}
