import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag] ' : '';
      print('${DateTime.now().toIso8601String()} $logTag$message');
    }
  }

  static void error(String message, {String? tag}) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag ERROR] ' : '[ERROR] ';
      print('${DateTime.now().toIso8601String()} $logTag$message');
    }
  }

  static void warn(String message, {String? tag}) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag WARN] ' : '[WARN] ';
      print('${DateTime.now().toIso8601String()} $logTag$message');
    }
  }

  static void apiResponse(String message, {String? tag}) {
    if (kDebugMode) {
      final logTag = tag != null ? '[$tag API] ' : '[API] ';
      print('${DateTime.now().toIso8601String()} $logTag$message');
    }
  }
}
