import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

// ignore: must_be_immutable
class FormFieldDate extends StatelessWidget {
  const FormFieldDate({
    Key? key,
    required this.hint,
    required this.controller,
    this.onChanged,
    this.enabled = true,
    this.keyboard = TextInputType.text,
    this.focusNode,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;
  final bool enabled;
  final Function(String value)? onChanged;
  final TextInputType keyboard;
  final FocusNode? focusNode;

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
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
        LengthLimitingTextInputFormatter(10),
        _DateInputFormatter(),
      ],
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    int selectionIndex = newValue.selection.end;

    String unmaskedText = newValue.text.replaceAll('/', '');

    for (int i = 0; i < unmaskedText.length; i++) {
      if (i == 2 || i == 4) {
        newText.write('/');
        if (selectionIndex >= i) {
          selectionIndex += 1;
        }
      }
      newText.write(unmaskedText[i]);
    }

    if (selectionIndex > newText.length) {
      selectionIndex = newText.length;
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
