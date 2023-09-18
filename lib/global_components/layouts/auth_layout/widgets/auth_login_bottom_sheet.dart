// ignore_for_file: must_be_immutable

import 'package:dictionary_words/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:get/get.dart';

class AuthLoginBottomSheet extends StatelessWidget {
  Widget child;

  AuthLoginBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
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
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                  child: UnconstrainedBox(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => Get.offNamed(AppRoutes.HOME.value),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.darkBlue,
                        ),
                        iconSize: 36,
                      ))),
              SliverPadding(padding: EdgeInsets.only(top: Get.height * 0.15)),
              SliverFillRemaining(
                fillOverscroll: true,
                hasScrollBody: false,
                child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 40, left: 5, right: 5),
                    child: child),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
