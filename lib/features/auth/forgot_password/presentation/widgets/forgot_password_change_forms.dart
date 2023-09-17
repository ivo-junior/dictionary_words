import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/controllers/forgot_password_change_password_controller.dart';
import 'package:dictionary_words/global_components/buttons/custom_text_button.dart';
import 'package:dictionary_words/global_components/custom_alert.dart';
import 'package:dictionary_words/global_components/inputs/custom_password_input.dart';
import 'package:dictionary_words/global_components/labels/forms_subtitle.dart';
import 'package:dictionary_words/global_components/labels/forms_title.dart';
import 'package:dictionary_words/global_components/buttons/custom_button.dart';
import 'package:dictionary_words/global_components/password_status/password_status.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

class ForgotPasswordChangePasswordForms extends StatelessWidget {
  ForgotPasswordChangePasswordForms({super.key});

  final ForgotPasswordChangePasswordController
      _forgotPasswordChangePasswordController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _forgotPasswordChangePasswordController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormsTitle('Trocar senha'),
            const SizedBox(height: 28),
            const FormsSubtitle(
              """Conta validada com sucesso! Insira abaixo uma nova senha.""",
              align: TextAlign.start,
            ),
            GetX<ForgotPasswordChangePasswordController>(
              builder: (_) => _forgotPasswordChangePasswordController
                      .errorMessage.value.isNotEmpty
                  ? Column(children: [
                      const SizedBox(height: 28),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomAlert(_forgotPasswordChangePasswordController
                              .errorMessage.value),
                          IconButton(
                            onPressed: () =>
                                _forgotPasswordChangePasswordController
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
            CustomPasswordInput(
              controller:
                  _forgotPasswordChangePasswordController.passwordController,
              onChanged: (_) => _forgotPasswordChangePasswordController
                  .updatePasswordObservable(),
            ),
            const SizedBox(height: 28),
            CustomPasswordInput(
              controller: _forgotPasswordChangePasswordController
                  .confirmPasswordController,
              newPasswordController:
                  _forgotPasswordChangePasswordController.passwordController,
            ),
            const SizedBox(height: 28),
            GetX<ForgotPasswordChangePasswordController>(
              builder: (_) => PasswordStatus(
                  password: _forgotPasswordChangePasswordController
                      .observablePassword.value),
            ),
            const SizedBox(height: 28),
            CustomButton(
              label: 'Cadastrar',
              onPressed: _forgotPasswordChangePasswordController.submit,
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
                  onPressed: () => Get.offAllNamed(AuthRoutes.LOGIN.value),
                )
              ],
            )
          ],
        ));
  }
}
