// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'package:dictionary_words/global_components/theme/app_colors.dart';

class ShimmerDefalt extends StatelessWidget {
  const ShimmerDefalt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      alignment: Alignment.center,
      child: Shimmer.fromColors(
        baseColor: AppColors.blueViolet,
        highlightColor: Colors.grey[300]!,
        child: Text(
          'Carregando...',
          style: GoogleFonts.commissioner(
              color: AppColors.text.darkBlue,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
