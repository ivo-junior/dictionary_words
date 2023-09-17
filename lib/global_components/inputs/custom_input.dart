// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String label;
  final bool enabled;
  final bool isObscureText;
  final String? errorText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final MaskTextInputFormatter? maskTextInputFormatter;
  final TextInputType? type;
  final IconData? suffixIcon;
  final void Function()? suffixIconOnPressed;
  final bool filled;
  final bool border;

  const CustomInput(
      {super.key,
      this.controller,
      this.initialValue,
      required this.label,
      this.enabled = true,
      this.isObscureText = false,
      this.validator,
      this.type = TextInputType.text,
      this.onChanged,
      this.errorText,
      this.inputFormatters,
      this.maskTextInputFormatter,
      this.suffixIcon,
      this.suffixIconOnPressed,
      this.filled = false,
      this.border = true});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late TextEditingController handledController;
  AutovalidateMode? autovalidateMode;
  bool canViewPassword = true;
  double BORDER_RADIUS = 16;
  double ICON_BUTTON_SPLASH_RADIUS = 20;

  @override
  void initState() {
    handledController = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      handledController.text = widget.initialValue!;
      if (widget.maskTextInputFormatter != null) {
        handledController.text =
            widget.maskTextInputFormatter!.maskText(widget.initialValue!);
      }
    }
    if (widget.isObscureText) {
      canViewPassword = false;
    }
    super.initState();
  }

  bool inputIsValid() {
    return widget.validator!(handledController.text) == null;
  }

  IconButton? handleSuffixIcon() {
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon),
        splashRadius: ICON_BUTTON_SPLASH_RADIUS,
        onPressed: () {
          if (widget.suffixIconOnPressed != null) {
            widget.suffixIconOnPressed!();
          }
        },
      );
    }
    if (widget.isObscureText) {
      return IconButton(
        icon: Icon(
            canViewPassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.input.darkBlue),
        splashRadius: ICON_BUTTON_SPLASH_RADIUS,
        onPressed: () {
          setState(() {
            canViewPassword = !canViewPassword;
          });
        },
      );
    }
    if (handledController.text.isNotEmpty) {
      return IconButton(
        icon: Icon(inputIsValid() ? Icons.check : Icons.close,
            color: inputIsValid()
                ? AppColors.input.darkBlue
                : AppColors.input.white50),
        splashRadius: ICON_BUTTON_SPLASH_RADIUS,
        onPressed: () {
          if (!inputIsValid()) {
            setState(() {
              handledController.clear();
              if (widget.onChanged != null) {
                widget.onChanged!('');
              }
            });
          }
        },
      );
    }
    return null;
  }

  List<TextInputFormatter> handleInputFormatters() {
    List<TextInputFormatter> formattedInputFormatters = [];

    if (widget.maskTextInputFormatter != null) {
      formattedInputFormatters.add(widget.maskTextInputFormatter!);
    }
    if (widget.inputFormatters != null) {
      formattedInputFormatters.addAll(widget.inputFormatters!);
    }
    return formattedInputFormatters;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: handledController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      onChanged: ((value) {
        setState(() {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        });
      }),
      enabled: widget.enabled,
      obscureText: !canViewPassword,
      keyboardType: widget.type,
      inputFormatters: handleInputFormatters(),
      autofocus: false,
      cursorColor: AppColors.blueViolet,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: widget.filled,
          hintText: widget.label,
          hintStyle: TextStyle(color: AppColors.input.white50),
          alignLabelWithHint: true,
          errorText: widget.errorText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          suffixIcon: handleSuffixIcon(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(BORDER_RADIUS),
            borderSide: BorderSide(
              color: widget.border
                  ? AppColors.blueViolet.withOpacity(0.6)
                  : Colors.transparent,
              width: widget.border ? 2.0 : 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
              borderSide: BorderSide(
                color: widget.border
                    ? AppColors.input.white50
                    : Colors.transparent,
                width: widget.border ? 1.0 : 0,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
              borderSide: BorderSide(
                color: AppColors.input.red,
                width: 1.0,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
              borderSide: BorderSide(
                color: AppColors.input.red,
                width: 2.0,
              )),
          labelStyle: GoogleFonts.commissioner(
            color: AppColors.input.darkBlue,
            fontWeight: FontWeight.w100,
            fontSize: 14.0,
          ),
          errorStyle: GoogleFonts.commissioner(
            color: AppColors.input.red,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          )),
    );
  }
}
