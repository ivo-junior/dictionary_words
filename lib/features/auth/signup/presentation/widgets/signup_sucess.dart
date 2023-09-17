import 'package:flutter/material.dart';
import 'package:dictionary_words/global_components/labels/forms_subtitle.dart';
import 'package:dictionary_words/global_components/labels/forms_title.dart';
import 'package:dictionary_words/global_components/buttons/custom_button.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

class SignUpSucess extends StatelessWidget {
  const SignUpSucess({super.key});

  void goToHome() {}

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
              color: AppColors.blueViolet,
            ),
            SizedBox(height: 28),
            FormsTitle('Conta criada com sucesso!'),
            SizedBox(height: 28),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: FormsSubtitle('Uhuu! Sua conta foi criada com sucesso.'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 73),
        CustomButton(
          label: 'Confirmar',
          onPressed: goToHome,
        ),
      ],
    );
  }
}
