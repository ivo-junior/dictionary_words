// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double MAX_FONT_SIZE = 50;
const double MIN_FONT_SIZE = 30;
const double MAX_IMAGE_SIZE = 0.8;
const double MIN_IMAGE_SIZE = 1;
const double TEXT_POSITION_OFFSET = 0.013;
const double MIN_SHEET_HEIGHT = 0.06;
const double MAX_SHEET_HEIGHT = 0.62;
const double MIN_SHEET_IMAGE_HEIGHT = 0.1;
const double MAX_SHEET_IMAGE_HEIGHT = 0.8;
const double MAX_BOBBLING_ANIMATION_HEIGHT = MIN_SHEET_HEIGHT + 0.02;

class AuthLayoutAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  DraggableScrollableController draggableController =
      DraggableScrollableController();
  late ScrollController scrollController;
  late AnimationController notchAnimationController;
  late Animation<double> notchAnimation;
  late String image;

  RxBool isVisibleText = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    notchAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 670,
      ),
    )..repeat(reverse: true);
    notchAnimation =
        CurvedAnimation(parent: notchAnimationController, curve: Curves.ease);
    image = "assets/backgrounds/login_background.png";
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 500), () {
      handleBobblingAnimation();
    });
  }

  @override
  void onClose() {
    draggableController.dispose();
    scrollController.dispose();
    notchAnimationController.dispose();
    resetValues();
    super.onClose();
  }

  void handeVisibleText(bool status) {
    isVisibleText.value = status;
    update();
  }

  final dynamicFontSize = RxDouble(MAX_FONT_SIZE);
  final dynamicImageScale = RxDouble(1.0);
  final dragRatio = RxDouble(0);

  void updateDragRatio(double currentDragRatio) {
    dragRatio.value = currentDragRatio;
    update();
  }

  void resetValues() {
    dynamicFontSize.value = MAX_FONT_SIZE;
    dynamicImageScale.value = 1.0;
    dragRatio.value = 0;
  }

  void updateFontSize(double currentDragRatio) {
    // A animação do notch trabalha na faixa de 0 a 0.1, nessa faixa a fonte não haverá resize
    if (currentDragRatio > MIN_SHEET_HEIGHT + 0.02) {
      // (0, 50)
      double denormalizedFontSize =
          (MAX_FONT_SIZE * (currentDragRatio - 1)).abs().toInt().toDouble();
      // (30, 50)
      double formattedRange = changeRangeToMatchFontSize(denormalizedFontSize);
      dynamicFontSize.value = formattedRange.abs().toInt().toDouble();
    }
  }

  void updateImageSize(double currentDragRatio) {
    // A animação do notch trabalha na faixa de 0 a 0.1, nessa faixa a fonte não haverá resize
    if (currentDragRatio > MIN_SHEET_IMAGE_HEIGHT + 0.02) {
      // (0, 50)

      double denormalizedFontSize = (MAX_IMAGE_SIZE * (currentDragRatio)).abs();
      // (30, 50)
      double formattedRange = changeRangeToMatchImageSize(denormalizedFontSize);

      dynamicImageScale.value =
          formattedRange >= 0.9 ? 1.0 : formattedRange.abs();
    }
  }

  double changeRangeToMatchImageSize(double value) {
    double oldValueRange = MAX_IMAGE_SIZE - 0;
    double newValueRange = MAX_IMAGE_SIZE - MIN_IMAGE_SIZE;
    double newValue = (((value - 0) * newValueRange) / oldValueRange) +
        MIN_IMAGE_SIZE; // converter para um novo range
    return newValue;
  }

  double changeRangeToMatchFontSize(double value) {
    double oldValueRange = MAX_FONT_SIZE - 0;
    double newValueRange = MAX_FONT_SIZE - MIN_FONT_SIZE;
    double newValue = (((value - 0) * newValueRange) / oldValueRange) +
        MIN_FONT_SIZE; // converter para um novo range
    return newValue;
  }

  void handleNotchAnimation(double currentDragRatio) async {
    if (dragRatio.value == 0) {
      notchAnimationController.repeat(reverse: true);
      handleBobblingAnimation();
    } else if (dragRatio.value >= MIN_SHEET_HEIGHT) {
      notchAnimationController.forward();
      // } else if (dragRatio.value >= MIN_SHEET_IMAGE_HEIGHT) {
      //   notchAnimationController.forward();
    }
  }

  void handleBobblingAnimation() {
    draggableController
        .animateTo(MAX_BOBBLING_ANIMATION_HEIGHT,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.bounceIn)
        .whenComplete(() async {
      draggableController.animateTo(MIN_SHEET_HEIGHT,
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut);
    });
  }

  void resetSheetScrollPosition() async {
    await scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
  }
}
