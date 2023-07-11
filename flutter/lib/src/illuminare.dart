import 'package:flutter/foundation.dart'
    show
        DiagnosticsNode,
        FlutterError,
        FlutterErrorDetails,
        PlatformDispatcher,
        kDebugMode;
import 'package:flutter/widgets.dart';
import 'package:grpc/grpc.dart';

import 'illuminare_log_event.dart';
import 'illuminare_log_output.dart';
import 'illuminare_options.dart';
import 'illuminare_trace.dart';
import 'utils.dart';

/// The main class for handling logs in Illuminare.
///
/// It has to be initialized to start working but when it has been initialized
/// it will catch errors and crashes.
///
/// You can also use the static methods to log something manually.
class Illuminare {
  static Illuminare? _instance;

  /// Gets the instance of Illuminare
  static Illuminare get instance {
    if (_instance == null) {
      throw Exception("Please initialize Illuminare");
    }

    return _instance!;
  }

  /// Log at verbose level
  ///
  /// [message] A descriptive message
  static void verbose(
    dynamic message, {
    dynamic exception,
    String? information,
  }) {
    Illuminare.instance.recordLog(
      IlluminareLogLevel.verbose,
      message,
      exception: exception,
      information: information,
    );
  }

  /// Log at debug level
  ///
  /// [message] A descriptive message
  static void debug(
    dynamic message, {
    dynamic exception,
    String? information,
  }) {
    Illuminare.instance.recordLog(
      IlluminareLogLevel.debug,
      message,
      exception: exception,
      information: information,
    );
  }

  /// Log at info level
  ///
  /// [message] A descriptive message
  static void info(
    dynamic message, {
    dynamic exception,
    String? information,
  }) {
    Illuminare.instance.recordLog(
      IlluminareLogLevel.info,
      message,
      exception: exception,
      information: information,
    );
  }

  /// Log at warn level
  ///
  /// [message] A descriptive message
  static void warn(
    dynamic message, {
    dynamic exception,
    String? information,
  }) {
    Illuminare.instance.recordLog(
      IlluminareLogLevel.warning,
      message,
      exception: exception,
      information: information,
    );
  }

  /// Log at error level
  ///
  /// [message] A descriptive message
  static void error(
    dynamic message, {
    dynamic exception,
    String? information,
  }) {
    Illuminare.instance.recordLog(
      IlluminareLogLevel.error,
      message,
      exception: exception,
      information: information,
    );
  }

  /// Log at fatal level
  ///
  /// [message] A descriptive message
  static void fatal(
    dynamic message, {
    dynamic exception,
    String? information,
  }) {
    Illuminare.instance.recordLog(
      IlluminareLogLevel.fatal,
      message,
      exception: exception,
      information: information,
    );
  }

  /// Initialize Illuminare
  ///
  /// Use [options] or [optionSelector] to set a custom option.
  /// By default [IlluminareOptions.development] is used for development
  /// and [IlluminareOptions.production] is used for production
  ///
  /// You can also set an [onLog] function to listen on logs. Logs are only
  /// sent to the [onLog] function if it passes the filter check.
  static Future<void> initialize({
    IlluminareOptions? options,
    IlluminareOptions Function()? optionSelector,
    void Function(IlluminareLogEvent logEvent)? onLog,
  }) async {
    if (options != null && optionSelector != null) {
      throw ArgumentError("You cannot use both options and optionSelector");
    }
    if (_instance != null) {
      _instance!.close();
    }

    if (options == null && optionSelector != null) {
      options = optionSelector();
    } else {
      options ??= kDebugMode
          ? IlluminareOptions.development()
          : IlluminareOptions.production();
    }

    _instance = Illuminare._create(
      options: options,
      onLog: onLog,
    );
  }

  final IlluminareOptions options;
  final void Function(IlluminareLogEvent logEvent)? onLog;

  Illuminare._create({required this.options, this.onLog}) {
    options.filter.init();
    options.printer.init();
    options.output.init();
    // Register onError handler
    FlutterError.onError = recordFlutterError;
    // Register platform error handler
    PlatformDispatcher.instance.onError = (error, stack) {
      recordError(error, stack);
      return true;
    };
    // Register error widget builder and handler
    ErrorWidget.builder = (errorDetails) {
      recordFlutterError(errorDetails);
      final errorBuilder =
          options.widgetErrorBuilder ?? IlluminareOptions.defaultErrorBuilder;
      return errorBuilder(errorDetails);
    };

    debugPrint =
        (message, {wrapWidth}) => recordLog(IlluminareLogLevel.debug, message);
  }

  bool _collectionEnabled = true;

  bool get isIlluminareCollectionEnabled {
    return _collectionEnabled;
  }

  /// Set if illuminare should collect logs
  Future<void> setIlluminareCollectionEnabled(bool enabled) async {
    _collectionEnabled = enabled;
  }

  /// Crash the app
  ///
  /// TODO: Actually crash the app
  void crash() {
    // ignore: avoid_print
    print("Crashing app");
  }

  /// Closes the logger and releases all resources.
  void close() {
    options.filter.destroy();
    options.printer.destroy();
    options.output.destroy();
  }

  /// Check for unsent reports
  ///
  /// TODO: Actually store logs
  Future<bool> checkForUnsentLogs() async {
    return false;
  }

  /// Deletes the unsent logs
  ///
  /// TODO: Actually delete the unsent logs
  Future<void> deleteUnsentLogs() async {
    // ignore: avoid_print
    print("deleteUnsentLogs");
  }

  /// Send the unsent logs
  ///
  /// TODO: Actually send the unsent logs
  Future<void> sendUnsentLogs() async {
    // ignore: avoid_print
    print("sending unsent logs");
  }

  // Future<void> setUserIdentifier(String identifier) {
  //   return;
  // }

  /// Check if the application crashed the last time it was run
  Future<bool> didCrashOnPreviousExecution() async {
    return false;
  }

  /// Record a log and send it to the server if possible
  ///
  /// TODO: Store locally if not connected to internet or if crashed
  Future<void> recordLog(
    IlluminareLogLevel level,
    dynamic message, {
    dynamic exception,
    String? information,
    List<IlluminareTrace>? stackTrace,
    bool? printDetails,
  }) async {
    final IlluminareLogEvent logEvent = IlluminareLogEvent(
      level: level,
      message: message,
      exception: exception,
      information: information,
      stackTrace: stackTrace,
    );

    // Issues with log should NOT influence
    // the main software behavior.
    try {
      if (options.filter.shouldLog(logEvent)) {
        var output = options.printer.log(logEvent);

        if (onLog != null) {
          onLog!(logEvent);
        }

        if (output.isNotEmpty) {
          var outputEvent = IlluminareOutputLog(level, output);
          options.output.output(outputEvent);
        }
      }
    } catch (e, s) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);
    }
  }

  /// Record an error and send it to the server
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<DiagnosticsNode> information = const [],
    bool fatal = false,
  }) {
    final String informationString = information.isEmpty
        ? ''
        : (StringBuffer()..writeAll(information, '\n')).toString();

    // Replace null or empty stack traces with the current stack trace.
    final StackTrace stackTrace = (stack == null || stack.toString().isEmpty)
        ? StackTrace.current
        : stack;

    // Extract stack trace
    final List<IlluminareTrace> stackTraceElements =
        getStackTraceElements(stackTrace);

    // Extract reason of the error
    String message = "App encountered an error";
    if (reason != null) {
      if (reason is ErrorDescription) {
        message = "An error occurred ${reason.toDescription()}";
      } else {
        message = reason.toString();
      }
    } else if (exception is GrpcError && exception.message != null) {
      message = exception.message!;
    }

    return recordLog(
      fatal ? IlluminareLogLevel.fatal : IlluminareLogLevel.error,
      message,
      exception: exception,
      stackTrace: stackTraceElements,
      information: informationString,
      printDetails: false,
    );
  }

  /// Record a flutter error
  /// This is used to catch exceptions in the app
  ///
  /// [FlutterErrorDetails] a object containing all information about the exception
  Future<void> recordFlutterError(
    FlutterErrorDetails flutterErrorDetails, {
    bool fatal = false,
  }) {
    return recordError(
      flutterErrorDetails.exceptionAsString(),
      flutterErrorDetails.stack,
      reason: flutterErrorDetails.context,
      information: flutterErrorDetails.informationCollector == null
          ? []
          : flutterErrorDetails.informationCollector!(),
      fatal: fatal,
    );
  }

  /// Record a fatal flutter error
  ///
  /// [FlutterErrorDetails] a object containing all information about the exception
  Future<void> recordFlutterFatalError(
      FlutterErrorDetails flutterErrorDetails) {
    return recordFlutterError(flutterErrorDetails, fatal: true);
  }
}
