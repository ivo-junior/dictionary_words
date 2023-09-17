// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AppColors {
  static const white80 = Color(0xffF9F5EF);
  static const white50 = Color.fromARGB(255, 207, 207, 207);
  static const correctDark = Color(0xff315D3A);
  static const areiaHome = Color(0xFFF9F5EF);
  static const greeLimon = Color(0xFFE8ECA7);
  static const darkBlue = Color(0xff333752);
  static const blueViolet = Color(0xff612BD6);

  static _Text text = _Text();
  static _Input input = _Input();
  static _Button button = _Button();
  static _Alert alert = _Alert();
  static _Gradient gradient = _Gradient();
}

class _Text {
  Color white80 = const Color(0xffF9F5EF);
  Color darkBlue = const Color(0xff333752);
  Color labelColor = const Color(0xff878AA3);
  Color orangeFish = const Color(0xffFF6666);
}

class _Input {
  Color white50 = const Color(0xffCDCED7);
  Color darkBlue = const Color(0xff333752);
  Color red = const Color(0xffFF8181);
}

class _Button {
  Color white80 = const Color(0xffF9F5EF);
  Color darkBlue = const Color(0xff333752);
  Color coral = const Color(0xffFF6666);
  Color coralLight = const Color(0xFFFF8181);
  Color grayLight = const Color(0xFFEEEEEE);
  Color gray_5 = const Color(0xFFE9E9E9);
  Color gray_6 = const Color(0xFFD1D1D6);
  Color gray_4 = const Color(0xFFD8D8F4);
}

class _Alert {
  Color redContainer = const Color(0xffF7D7DB);
  Color redText = const Color(0xff652325);
  Color yellowContainer = const Color(0xffF6F7D7);
  Color yellowText = const Color(0xff655323);
  Color greenContainer = const Color(0xffD8F7D7);
  Color greenText = const Color(0xff246523);
}

class _Gradient {
  LinearGradient loginBackground = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xff612BD6).withOpacity(0),
        const Color(0xff250075)
      ]);
}
