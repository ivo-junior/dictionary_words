// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:pinput/pinput.dart';

class CustomOTPInput extends StatelessWidget {
  void Function(String) onChanged;
  CustomOTPInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      textStyle: GoogleFonts.commissioner(
        color: AppColors.blueViolet,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      constraints: const BoxConstraints(minHeight: 56, minWidth: 56),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.input.darkBlue.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(16),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.blueViolet, width: 2),
      borderRadius: BorderRadius.circular(16),
    );

    return Align(
        alignment: Alignment.center,
        child: Pinput(
          length: 5,
          crossAxisAlignment: CrossAxisAlignment.center,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: defaultPinTheme,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onChanged: onChanged,
        ));
  }
}
