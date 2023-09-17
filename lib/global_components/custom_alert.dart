import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

enum AlertError { warning, error, sucess }

class CustomAlert extends StatelessWidget {
  final String text;
  final AlertError type;

  const CustomAlert(this.text, {super.key, this.type = AlertError.error});

  Color handleContainerColor() {
    switch (type) {
      case AlertError.error:
        return AppColors.alert.redContainer;
      case AlertError.warning:
        return AppColors.alert.yellowContainer;
      case AlertError.sucess:
        return AppColors.alert.greenContainer;
    }
  }

  Color handleLabelColor() {
    switch (type) {
      case AlertError.error:
        return AppColors.alert.redText;
      case AlertError.warning:
        return AppColors.alert.yellowText;
      case AlertError.sucess:
        return AppColors.alert.greenText;
    }
  }

  Icon handleIcon() {
    switch (type) {
      case AlertError.error:
        return Icon(Icons.warning_amber_rounded,
            color: AppColors.alert.redText);
      case AlertError.warning:
        return Icon(Icons.info_outline, color: AppColors.alert.yellowText);
      case AlertError.sucess:
        return Icon(Icons.check_circle_outline,
            color: AppColors.alert.greenText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: handleContainerColor(),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            handleIcon(),
            const SizedBox(
              width: 10,
            ),
            Text(text,
                style: GoogleFonts.commissioner(
                    color: handleLabelColor(),
                    fontWeight: FontWeight.w500,
                    fontSize: 14)),
          ],
        ));
  }
}
