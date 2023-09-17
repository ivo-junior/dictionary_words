import 'package:dictionary_words/global_components/global_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dictionary_words/global_components/inputs/custom_input.dart';

class CustomPasswordInput extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final TextEditingController? newPasswordController;
  final String? errorText;
  final void Function(String)? onChanged;

  const CustomPasswordInput(
      {super.key,
      this.controller,
      this.newPasswordController,
      this.enabled = true,
      this.errorText,
      this.onChanged});

  String? handleValidation(String? password) {
    if (newPasswordController == null) {
      return validatePassword(password);
    }
    return validateEqualPassword(password, newPasswordController!.text);
  }

  String handleInputLabel() {
    if (newPasswordController == null) {
      return 'Senha';
    }
    return 'Repetir senha';
  }

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: controller,
      validator: (value) => handleValidation(value),
      type: TextInputType.visiblePassword,
      isObscureText: true,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      onChanged: onChanged,
      enabled: enabled,
      label: handleInputLabel(),
      errorText: errorText,
    );
  }
}
