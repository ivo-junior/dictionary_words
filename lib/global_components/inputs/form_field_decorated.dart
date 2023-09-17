import 'package:flutter/material.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

// ignore: must_be_immutable
class FormFieldDecorated extends StatelessWidget {
  FormFieldDecorated(
      {super.key,
      required this.hint,
      required this.controller,
      this.onChanged,
      this.enabled = true,
      this.keyboard = TextInputType.text,
      this.focusNode});

  String hint;
  TextEditingController controller;
  bool? enabled;
  Function(String value)? onChanged;
  TextInputType keyboard = TextInputType.text;
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xffCDCED7)),
        contentPadding: const EdgeInsets.fromLTRB(17, 12, 17, 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(width: 1, color: AppColors.blueViolet),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      style: TextStyle(color: AppColors.text.darkBlue, fontSize: 15),
    );
  }
}
