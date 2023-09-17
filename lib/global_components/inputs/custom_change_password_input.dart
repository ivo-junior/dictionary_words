import 'package:dictionary_words/global_components/global_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dictionary_words/global_components/inputs/custom_input.dart';

class CustomChangePasswordInput extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final TextEditingController? newPasswordController;
  final TextEditingController? oldPasswordController;
  final String? errorText;
  final void Function(String)? onChanged;
  final bool filled;
  final bool border;

  const CustomChangePasswordInput(
      {super.key,
      this.controller,
      this.newPasswordController,
      this.oldPasswordController,
      this.enabled = true,
      this.errorText,
      this.onChanged,
      this.filled = false,
      this.border = true});

  String? handleValidation(String? password) {
    if (newPasswordController == null) {
      return validatePassword(password);
    }
    return validateEqualPassword(password, newPasswordController!.text);
  }

  String handleInputLabel() {
    if (oldPasswordController != null) {
      return 'Senha';
    }
    if (newPasswordController == null) {
      return 'Nova senha';
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
      filled: filled,
      border: border,
      onChanged: onChanged,
      enabled: enabled,
      label: handleInputLabel(),
      errorText: errorText,
    );
  }
}
