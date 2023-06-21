import 'package:flutter/widgets.dart';

import '../illuminare.dart';
import 'error_rendering/illuminare_error_widget.dart';

typedef ErrorWidgetBuilder = Widget Function(FlutterErrorDetails details);

/// The options for Illuminare
///
/// Use the predefined options [IlluminareOptions.development]
/// or [IlluminareOptions.production]
/// or create your own
class IlluminareOptions {
  final ErrorWidgetBuilder? widgetErrorBuilder;
  final IlluminareLogFilter filter;
  final IlluminareLogPrinter printer;
  final IlluminareLogOutput output;

  IlluminareOptions({
    this.widgetErrorBuilder,
    this.filter = const IlluminareDevelopmentLogFilter(),
    this.printer = const IlluminarePrettyLogPrinter(),
    this.output = const IlluminareConsoleLogOutput(),
  });

  /// Used for development uses pretty printer for easy overview
  IlluminareOptions.development({
    this.widgetErrorBuilder,
    this.filter = const IlluminareDevelopmentLogFilter(),
    this.printer = const IlluminarePrettyLogPrinter(),
    this.output = const IlluminareConsoleLogOutput(),
  });

  /// Used for production uses simple printer
  IlluminareOptions.production({
    this.widgetErrorBuilder,
    this.filter = const IlluminareProductionLogFilter(),
    this.printer = const IlluminareSimpleLogPrinter(),
    this.output = const IlluminareConsoleLogOutput(),
  });

  // The default error widget builder
  static ErrorWidgetBuilder defaultErrorBuilder = (errorDetails) {
    String message = '';
    assert(() {
      message =
          '${errorDetails.exception.toString()}\nSee also: https://flutter.dev/docs/testing/errors';
      return true;
    }());
    final Object exception = errorDetails.exception;
    return IlluminareErrorWidget.withDetails(
        message: message, error: exception is FlutterError ? exception : null);
  };
}
