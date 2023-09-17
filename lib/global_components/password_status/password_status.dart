// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/password_status/password_status_validator.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

enum PasswordStatusValidators {
  NUMBERS,
  SMALL_LETTERS,
  CAPITAL_LETTERS,
  SPECIAL_CARACTERS,
  MINIMUM_OF_8_CHARACTERS,
}

// ignore: must_be_immutable
class PasswordStatus extends StatefulWidget {
  String password;
  PasswordStatus({super.key, required this.password});

  @override
  State<PasswordStatus> createState() => _PasswordStatusState();
}

class _PasswordStatusState extends State<PasswordStatus> {
  bool isFirstInteraction = true;
  bool hasMissingFieldError = false;

  String handleLabel(PasswordStatusValidators validator) {
    switch (validator) {
      case PasswordStatusValidators.NUMBERS:
        return 'Números';
      case PasswordStatusValidators.SMALL_LETTERS:
        return 'Letras minúsculas';
      case PasswordStatusValidators.CAPITAL_LETTERS:
        return 'Letras maiúsculas';
      case PasswordStatusValidators.SPECIAL_CARACTERS:
        return 'Caracteres especiais';
      case PasswordStatusValidators.MINIMUM_OF_8_CHARACTERS:
        return 'Mínimo de 8 caracteres';
    }
  }

  bool handleValidation(PasswordStatusValidators validator) {
    switch (validator) {
      case PasswordStatusValidators.NUMBERS:
        return hasNumber(widget.password);
      case PasswordStatusValidators.SMALL_LETTERS:
        return hasLowerCase(widget.password);
      case PasswordStatusValidators.CAPITAL_LETTERS:
        return hasUpperCase(widget.password);
      case PasswordStatusValidators.SPECIAL_CARACTERS:
        return hasSpecialChar(widget.password);
      case PasswordStatusValidators.MINIMUM_OF_8_CHARACTERS:
        return hasMinLength(widget.password, 8);
    }
  }

  void handleAllValidators() {
    hasMissingFieldError = false;
    for (var validator in PasswordStatusValidators.values) {
      final isValid = handleValidation(validator);
      if (!isValid) hasMissingFieldError = true;
      continue;
    }
    setState(() {});
  }

  Widget generatePasswordInfo(PasswordStatusValidators validator) {
    final isValid = handleValidation(validator);
    return FormField<bool>(validator: (_) {
      isFirstInteraction = false;
      handleAllValidators();
      if (!isValid) {
        return 'Campo não correspondente';
      }
      return null;
    }, builder: (_) {
      return Row(
        children: [
          Icon(
            !isValid ? Icons.check : Icons.check_circle_outline,
            color: isValid
                ? AppColors.correctDark
                : AppColors.text.labelColor.withOpacity(0.8),
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            handleLabel(validator),
            style: GoogleFonts.commissioner(
              color: isValid
                  ? AppColors.correctDark
                  : AppColors.text.labelColor.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isFirstInteraction) {
      handleAllValidators();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          height: 80,
          child: GridView.count(
              childAspectRatio: (1 / .15),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              crossAxisCount: 2,
              children: [
                generatePasswordInfo(PasswordStatusValidators.NUMBERS),
                generatePasswordInfo(
                    PasswordStatusValidators.SPECIAL_CARACTERS),
                generatePasswordInfo(PasswordStatusValidators.CAPITAL_LETTERS),
                generatePasswordInfo(
                    PasswordStatusValidators.MINIMUM_OF_8_CHARACTERS),
                generatePasswordInfo(PasswordStatusValidators.SMALL_LETTERS),
              ])),
      if (hasMissingFieldError) ...[
        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('Sua senha deve corresponder aos itens acima',
                style: GoogleFonts.commissioner(
                  color: AppColors.input.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                )))
      ]
    ]);
  }
}
