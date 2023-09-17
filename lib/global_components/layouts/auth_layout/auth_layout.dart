// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/global_components/layouts/auth_layout/auth_layout_animation_controller.dart';
import 'package:dictionary_words/global_components/layouts/auth_layout/widgets/auth_layout_bottom_sheet.dart';

class AuthLayout extends StatelessWidget {
  Widget child;

  AuthLayout({Key? key, required this.child}) : super(key: key);

  final _animationController =
      Get.put(AuthLayoutAnimationController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GetX<AuthLayoutAnimationController>(builder: (_) {
        return AnimatedContainer(
          alignment: Alignment.topCenter,
          height: (Get.height * (_animationController.dynamicImageScale.value)),
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          onEnd: () {
            if (_animationController.dynamicImageScale.value !=
                MAX_IMAGE_SIZE) {
              _animationController.dynamicImageScale.value = 1.0;
            } else {
              _animationController.dynamicImageScale.value;
            }
            if (_animationController.dragRatio.value == 1.0) {
              _animationController.handeVisibleText(true);
            } else {
              _animationController.handeVisibleText(false);
            }
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.only(
                    bottom: _animationController.dragRatio.value >
                            MIN_SHEET_HEIGHT
                        ? ((Get.height / 2) *
                                (_animationController.dragRatio.value * 0.01)) *
                            55
                        : 0),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(97, 43, 214, 0.00),
                      Color(0xFF250075),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1],
                    tileMode: TileMode.clamp,
                  ),
                ),
              )
            ],
          ),
        );
      }),
      Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              double percent = (notification.extent.toPrecision(2) -
                      notification.minExtent.toPrecision(2)) /
                  (notification.maxExtent.toPrecision(2) -
                      notification.minExtent.toPrecision(2));
              final dragRatio = percent.toPrecision(2);
              _animationController.updateDragRatio(dragRatio);
              _animationController.updateFontSize(dragRatio);
              _animationController.handleNotchAnimation(dragRatio);
              _animationController.updateImageSize(dragRatio);
              return true;
            },
            child: AuthLayoutBottomSheet(
              child: child,
            )),
      )
    ]);
  }
}
