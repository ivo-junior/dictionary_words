import 'package:auto_size_text/auto_size_text.dart';
import 'package:dictionary_words/features/word/presentation/controllers/word_controller.dart';
import 'package:dictionary_words/global_components/buttons/custom_button.dart';
import 'package:dictionary_words/global_components/shimmer.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WordPage extends GetView<WordController> {
  const WordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordController>(
      builder: (_) {
        if (controller.isLoading) {
          return const ShimmerDefalt();
        } else {
          return Scaffold(
              backgroundColor: AppColors.areiaHome,
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.darkBlue,
                            size: 32,
                          ),
                          onPressed: () => Get.back(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: AppColors.darkBlue,
                            size: 32,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.darkBlue),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      width: Get.width - 30,
                      padding: EdgeInsets.symmetric(vertical: Get.height / 8),
                      child: Column(
                        children: [
                          AutoSizeText(
                            controller.wordModel.word ?? "---",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.commissioner(
                                color: AppColors.text.darkBlue,
                                height: 2,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          AutoSizeText(
                            controller.wordModel.word ?? "---000000",
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.commissioner(
                                color: AppColors.text.darkBlue,
                                height: 2,
                                fontSize: 26,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      children: [
                        const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.play_circle,
                            color: AppColors.darkBlue,
                          ),
                          iconSize: 68,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.button.gray_4,
                                ),
                                height: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.blueViolet,
                                ),
                                height: 8,
                                width: 50,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Text(
                          "Meadings",
                          style: GoogleFonts.commissioner(
                              color: AppColors.text.darkBlue,
                              height: 2,
                              fontSize: 26,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Text(
                            "123456",
                            style: GoogleFonts.commissioner(
                                color: AppColors.text.darkBlue,
                                height: 2,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                            onPressed: () {},
                            label: "Voltar",
                            isDisabled: true),
                        CustomButton(onPressed: () {}, label: "Próximo"),
                      ],
                    )
                  ],
                ),
              ));
        }
      },
    );
  }
}
