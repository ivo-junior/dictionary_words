import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final TextDecoration textDecoration;
  final FontWeight fontWeight;
  final void Function() onPressed;
  final double? height;

  const CustomTextButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.fontSize = 14,
      this.textDecoration = TextDecoration.none,
      this.fontWeight = FontWeight.w700,
      this.height});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: GoogleFonts.commissioner(
          color: AppColors.blueViolet,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
      onPressed: onPressed,
      child: Text(label,
          style: TextStyle(
              height: height,
              color: AppColors.blueViolet,
              decoration: textDecoration)),
    );
  }
}
