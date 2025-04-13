import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:file_saver/file_saver.dart';
import 'package:jellyflix/services/download_service.dart';
import 'package:universal_io/io.dart';
import 'package:path/path.dart' show join;  // Add this import

class JfxLogger {
  late Logger _logger;
  static const _logFileName = "jellyflix-log";
  static const _logFileExtension = ".txt";
  final MemoryOutput _memoryOutput = MemoryOutput();

  JfxLogger() {
    buildLogger();
  }

  void buildLogger({bool alwaysLog = false}) {
    if (kDebugMode) {
      _logger = Logger(
        printer: LogfmtPrinter(),
      );
    } else {
      _logger = Logger(
        printer: LogfmtPrinter(),
        output: _memoryOutput,
        filter: alwaysLog ? ProductionFilter() : null,
      );
    }
  }

  void alwaysLog() {
    buildLogger(alwaysLog: true);
  }

  void resetLogger() {
    buildLogger();
  }

  void info(String message) {
    _logger.i(message);
  }

  void error(String message, {dynamic error}) {
    _logger.e(message, error: error);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void debug(String message) {
    _logger.d(message);
  }

  void verbose(String message) {
    _logger.t(message);
  }

  void critical(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  Future<void> exportLog() async {
    _logger.i("Exporting log to file");

    var downloadDir = await DownloadService.getDownloadDirectory();
    var logBytes = Uint8List.fromList(_memoryOutput.toString().codeUnits);
    var logFile = File(join(downloadDir, 
        "${_logFileName}_${DateTime.now().toIso8601String().replaceAll(":", "-")}$_logFileExtension"));
    
    await logFile.writeAsBytes(logBytes);
    _logger.i("Log exported to: ${logFile.path}");
  }
}
