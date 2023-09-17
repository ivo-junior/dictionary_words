import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

class FormsTitle extends StatelessWidget {
  final String text;

  const FormsTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.commissioner(
            color: AppColors.text.darkBlue,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 16));
  }
}
