import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

class FormsSubtitle extends StatelessWidget {
  final String text;
  final double size;
  final TextAlign align;

  const FormsSubtitle(this.text,
      {super.key, this.size = 14, this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: GoogleFonts.commissioner(
            color: AppColors.text.darkBlue,
            fontWeight: FontWeight.w500,
            fontSize: size));
  }
}
