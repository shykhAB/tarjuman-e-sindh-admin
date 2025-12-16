import 'dart:developer';
import 'package:flutter/foundation.dart';

class Log {

  static debug(String message, {required String tag, String name=''}){
    if(kDebugMode){
      log("────────────────────$name> $message", name: tag);
    }
  }

  static error(String error, {required String tag, String message=''}){
    if(kDebugMode){
      log(message, name: tag, error: '────────────────────> $error');
    }
  }

  static errorWithTrace(String error, {required String tag, required StackTrace? stackTrace}){
    if(kDebugMode){
      log("", stackTrace: stackTrace, name: tag, error: '────────────────────> $error');
    }
  }


}