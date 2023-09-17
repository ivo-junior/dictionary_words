import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:dictionary_words/global_components/buttons/custom_text_button.dart';
import 'package:dictionary_words/global_components/custom_alert.dart';
import 'package:dictionary_words/global_components/inputs/custom_email_input.dart';
import 'package:dictionary_words/global_components/labels/forms_subtitle.dart';
import 'package:dictionary_words/global_components/labels/forms_title.dart';
import 'package:dictionary_words/global_components/buttons/custom_button.dart';

import '../../../../../global_components/theme/app_colors.dart';
import '../controllers/forgot_password_email_controller.dart';

class ForgotPasswordEmailForms extends StatelessWidget {
  ForgotPasswordEmailForms({super.key});

  final ForgotPasswordEmailController _forgotPasswordEmailController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _forgotPasswordEmailController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormsTitle('Esqueci a senha'),
            const SizedBox(height: 28),
            const FormsSubtitle(
              """Insira no campo abaixo o seu email e siga as intruções para redefinir a sua senha.""",
              align: TextAlign.start,
            ),
            GetX<ForgotPasswordEmailController>(
              builder: (_) =>
                  _forgotPasswordEmailController.errorMessage.value.isNotEmpty
                      ? Column(children: [
                          const SizedBox(height: 28),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              CustomAlert(_forgotPasswordEmailController
                                  .errorMessage.value),
                              IconButton(
                                onPressed: () => _forgotPasswordEmailController
                                    .resetDefaultState(),
                                icon: const Icon(Icons.close),
                                color: AppColors.alert.redText,
                              )
                            ],
                          )
                        ])
                      : const SizedBox.shrink(),
            ),
            const SizedBox(height: 28),
            CustomEmailInput(
              controller: _forgotPasswordEmailController.emailController,
            ),
            const SizedBox(height: 73),
            GetBuilder<ForgotPasswordEmailController>(
              builder: (_) => CustomButton(
                isLoading: _forgotPasswordEmailController.buttonPressed,
                label: 'Enviar código',
                onPressed: () async {
                  if (!_forgotPasswordEmailController.buttonPressed) {
                    _forgotPasswordEmailController.handleButtonPressed(true);
                    await _forgotPasswordEmailController.submit();
                    _forgotPasswordEmailController.handleButtonPressed(false);
                  }
                },
              ),
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
                  onPressed: () => Get.back(),
                )
              ],
            )
          ],
        ));
  }
}
