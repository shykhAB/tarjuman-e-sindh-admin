import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/* Author: Abdul Salam*/

class ToastManager {
  static final Queue<_ToastItem> _toastQueue = Queue();
  static bool _isProcessing = false;
  static Timer? _toastTimer;

  static void showToast({
    required String message,
    bool showLong = false,
  }) {
    _toastQueue.add(_ToastItem(message, showLong));
    _processQueue();
  }

  static void _processQueue() {
    if (_isProcessing || _toastQueue.isEmpty) return;

    _isProcessing = true;
    final toast = _toastQueue.removeFirst();

    Fluttertoast.showToast(
      msg: toast.message,
      toastLength: toast.showLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: toast.showLong ? 3 : 1,
      backgroundColor: const Color(0xF9454141),
      textColor: Colors.white,
      fontSize: 13.0,
    );

    _toastTimer?.cancel();

    _toastTimer = Timer(
      Duration(seconds: toast.showLong ? 3 : 1) + const Duration(milliseconds: 200),
          () {
        _isProcessing = false;
        _processQueue();
      },
    );
  }

  static void cancelAllToasts() {
    _toastQueue.clear();
    _toastTimer?.cancel();
    _isProcessing = false;
    Fluttertoast.cancel();
  }
}

class _ToastItem {
  final String message;
  final bool showLong;

  _ToastItem(this.message, this.showLong);
}