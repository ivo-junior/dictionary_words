import 'package:dictionary_words/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class WordWidget extends StatelessWidget {
  final HomeController homeController;
  final Function onTap;
  final String word;

  const WordWidget({
    super.key,
    required this.homeController,
    required this.onTap,
    required this.word,
  });

  void goToWordPage() {
    Get.toNamed(AppRoutes.WORD_PAGE.value, arguments: word);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToWordPage();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.button.darkBlue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
          child: AutoSizeText(
            word,
            style: GoogleFonts.commissioner(
                letterSpacing: 1,
                color: AppColors.text.white80,
                fontSize: 20.0,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                fontWeight: FontWeight.w700),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
