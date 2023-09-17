import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/features/splash/presentation/controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(),
        child: GetX<SplashController>(builder: (context) {
          return AnimatedCrossFade(
            firstChild: const Center(),
            secondChild: const Center(
                child: Icon(
              Icons.library_books,
              color: AppColors.darkBlue,
              size: 100,
            )),
            duration: Duration(milliseconds: controller.durationAnimation),
            crossFadeState: controller.first.value
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          );
        }),
      ),
    );
  }
}
