import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/custom_circular_indicator.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

enum CustomButtonTheme { primary, secondary }

class CustomButton extends StatefulWidget {
  final bool isDisabled;
  final bool isLoading;
  final String label;
  final CustomButtonTheme theme;
  final void Function() onPressed;

  const CustomButton(
      {super.key,
      this.isDisabled = false,
      this.isLoading = false,
      required this.onPressed,
      required this.label,
      this.theme = CustomButtonTheme.primary});

  @override
  State<StatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Color handleButtonColor() {
    if (widget.isLoading || widget.isDisabled) {
      return AppColors.blueViolet.withOpacity(0.5);
    } else {
      if (widget.theme == CustomButtonTheme.primary) {
        return AppColors.blueViolet;
      } else {
        return AppColors.button.white80; // definir futuramente
      }
    }
  }

  Widget handleButtonUIState() {
    if (widget.isLoading) {
      return CustomCircularIndicator(
        height: 20,
        color: widget.theme == CustomButtonTheme.primary
            ? AppColors.button.white80.withOpacity(0.5)
            : AppColors.button.white80, // definir futuramente
      );
    }
    return Text(widget.label,
        style: GoogleFonts.commissioner(
            color: widget.theme == CustomButtonTheme.primary
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: handleButtonColor(),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
            onTap: (widget.isLoading || widget.isDisabled)
                ? null
                : () => widget.onPressed(),
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 48,
                child: Center(
                  child: handleButtonUIState(),
                ))));
  }
}
