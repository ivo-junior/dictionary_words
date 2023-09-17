import 'package:auto_size_text/auto_size_text.dart';
import 'package:dictionary_words/features/word/presentation/controllers/word_controller.dart';
import 'package:dictionary_words/features/word/presentation/pages/widgets/informarion_element.dart';
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
        if (controller.isLoading || controller.wordModel == null) {
          return const ShimmerDefalt();
        } else {
          return Scaffold(
            backgroundColor: AppColors.areiaHome,
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
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
                          icon: Icon(
                            controller.isFavorit
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColors.darkBlue,
                            size: 32,
                          ),
                          onPressed: () => controller.toogleFavorit(),
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
                      padding: EdgeInsets.symmetric(vertical: Get.height / 15),
                      child: Column(
                        children: [
                          AutoSizeText(
                            controller.wordModel!.word ?? "Not Found",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.commissioner(
                                color: AppColors.text.darkBlue,
                                height: 2,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          AutoSizeText(
                            controller.wordModel!.pronunciation != null
                                ? controller.wordModel!.pronunciation!.all!
                                : "",
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${controller.currentCount.value + 1}/${controller.wordModel!.results!.length}",
                            style: GoogleFonts.commissioner(
                                color: AppColors.text.darkBlue,
                                height: 2,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      height: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InformationElement(
                                title: "Definition:",
                                content:
                                    controller.currentResult.value.definition!),
                            if (controller.currentResult.value.synonyms != null)
                              InformationElement(
                                  title: "Synonymus:",
                                  content: controller
                                      .currentResult.value.synonyms!
                                      .join(', ')),
                            if (controller.currentResult.value.synonyms != null)
                              InformationElement(
                                  title: "Typer Of:",
                                  content: controller
                                      .currentResult.value.typeOf!
                                      .join(', ')),
                            if (controller.currentResult.value.hasTypes != null)
                              InformationElement(
                                  title: "Has Types:",
                                  content: controller
                                      .currentResult.value.hasTypes!
                                      .join(', ')),
                            if (controller.currentResult.value.derivation !=
                                null)
                              InformationElement(
                                  title: "Derivations:",
                                  content: controller
                                      .currentResult.value.derivation!
                                      .join(', '))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                            onPressed: () {
                              controller.currentCount.value--;
                              controller.alterableResult();
                              controller.update();
                            },
                            label: "Voltar",
                            isDisabled: controller.currentCount.value == 0),
                        CustomButton(
                            onPressed: () {
                              controller.currentCount.value++;
                              controller.alterableResult();
                              controller.update();
                            },
                            isDisabled: controller.wordModel!.results == null ||
                                controller.wordModel!.results!.length == 1 ||
                                controller.currentCount.value ==
                                    controller.wordModel!.results!.length - 1,
                            label: "Próximo"),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
