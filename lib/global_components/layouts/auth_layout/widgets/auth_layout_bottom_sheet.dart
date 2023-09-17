import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/global_components/layouts/auth_layout/auth_layout_animation_controller.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

// ignore: must_be_immutable
class AuthLayoutBottomSheet extends StatelessWidget {
  Widget child;

  AuthLayoutBottomSheet({super.key, required this.child});

  final AuthLayoutAnimationController _animationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: MIN_SHEET_HEIGHT,
        minChildSize: MIN_SHEET_HEIGHT,
        maxChildSize: MAX_SHEET_HEIGHT,
        snap: true,
        snapSizes: const [
          MIN_SHEET_HEIGHT,
        ],
        controller: _animationController.draggableController,
        builder: (context, scrollController) {
          _animationController.scrollController = scrollController;
          return Container(
              decoration: const BoxDecoration(
                color: AppColors.white80,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Material(
                  type: MaterialType.transparency,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 0),
                      child: CustomScrollView(
                          // physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          slivers: [
                            SliverToBoxAdapter(
                                child: UnconstrainedBox(
                                    child: Container(
                              width: 100,
                              height: 5,
                              margin: const EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                  color: AppColors.white50,
                                  border: Border.all(
                                    color: AppColors.white50,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                            ))),
                            GetBuilder<AuthLayoutAnimationController>(
                              builder: (_) => SliverFillRemaining(
                                fillOverscroll: true,
                                hasScrollBody: false,
                                child: AnimatedOpacity(
                                  duration: Duration.zero,
                                  opacity: _animationController.dragRatio.value,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 0, left: 5, right: 5),
                                      child: child),
                                ),
                              ),
                            )
                          ]))));
        });
  }
}
