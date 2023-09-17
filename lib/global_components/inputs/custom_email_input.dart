import 'package:dictionary_words/global_components/global_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dictionary_words/global_components/inputs/custom_input.dart';

class CustomEmailInput extends StatelessWidget {
  final String? initialValue;
  final bool enabled;
  final TextEditingController? controller;
  final String? errorText;
  final void Function(String)? onChanged;

  const CustomEmailInput({
    super.key,
    this.initialValue,
    this.controller,
    this.enabled = true,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      onChanged: onChanged,
      initialValue: initialValue,
      controller: controller,
      validator: (value) => validateEmail(value),
      type: TextInputType.emailAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(40),
      ],
      enabled: enabled,
      label: 'Email',
      errorText: errorText,
    );
  }
}
