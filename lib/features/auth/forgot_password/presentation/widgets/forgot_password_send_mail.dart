// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';
import 'package:dictionary_words/global_components/buttons/custom_text_button.dart';
import 'package:dictionary_words/global_components/labels/forms_subtitle.dart';
import 'package:dictionary_words/global_components/labels/forms_title.dart';
import 'package:dictionary_words/global_components/buttons/custom_button.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

class ForgotPasswordSendMail extends StatelessWidget {
  const ForgotPasswordSendMail({super.key});

  void backToLoginPage() async {
    Get.offAllNamed(AuthRoutes.LOGIN.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Column(
          children: [
            SizedBox(height: 28),
            Icon(
              Icons.check,
              size: 64,
              color: AppColors.greeLimon,
            ),
            SizedBox(height: 28),
            FormsTitle('Eemail enviado!'),
            SizedBox(height: 28),
            FormsSubtitle('Um email foi enviado com link para troca de senha.'),
          ],
        ),
        const SizedBox(height: 73),
        CustomButton(
          label: 'Login',
          onPressed: backToLoginPage,
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FormsSubtitle('Já tem uma conta?'),
            CustomTextButton(
              label: 'Logar',
              fontSize: 14,
              textDecoration: TextDecoration.underline,
              fontWeight: FontWeight.w400,
              onPressed: backToLoginPage,
            )
          ],
        )
      ],
    );
  }
}
