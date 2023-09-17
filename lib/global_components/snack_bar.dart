// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';

void snack(String title, String message, {int duration = 4}) =>
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: message,
      duration: Duration(seconds: duration),
    ));
