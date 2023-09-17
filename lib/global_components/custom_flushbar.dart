import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
enum FlusbarType { ERROR, WARNING, SUCESS, INFO }

Color _handleFlushbarTypeColor(FlusbarType flusbarType) {
  if (flusbarType == FlusbarType.ERROR) {
    return Colors.red.shade300;
  } else if (flusbarType == FlusbarType.WARNING) {
    return Colors.orange.shade300;
  } else if (flusbarType == FlusbarType.SUCESS) {
    return Colors.green.shade300;
  }
  return Colors.blue.shade300;
}

Icon _handleFlushbarTypeIcon(FlusbarType flusbarType) {
  if (flusbarType == FlusbarType.ERROR) {
    return const Icon(
      Icons.error_outline,
      size: 24,
      color: Colors.red,
    );
  } else if (flusbarType == FlusbarType.WARNING) {
    return const Icon(
      Icons.warning,
      size: 24,
      color: Colors.orange,
    );
  } else if (flusbarType == FlusbarType.SUCESS) {
    return const Icon(
      Icons.check_circle_rounded,
      size: 24,
      color: Colors.green,
    );
  }
  return const Icon(
    Icons.info_outline,
    size: 24,
    color: Colors.blue,
  );
}

void showCustomFlushbar({
  required FlusbarType flusbarType,
  String? title,
  String? message,
  Widget? mainButton,
}) {
  Flushbar(
    titleText: (title != null && title.isNotEmpty)
        ? Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          )
        : null,
    messageText: (message != null && message.isNotEmpty)
        ? Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          )
        : null,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.all(8),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    borderRadius: BorderRadius.circular(5),
    animationDuration: const Duration(milliseconds: 700),
    boxShadows: const [BoxShadow(color: Colors.black38, blurRadius: 2)],
    backgroundColor: const Color.fromARGB(255, 236, 236, 236),
    duration: const Duration(seconds: 3),
    leftBarIndicatorColor: _handleFlushbarTypeColor(flusbarType),
    icon: _handleFlushbarTypeIcon(flusbarType),
    mainButton: mainButton,
  ).show(Get.context!);
}
