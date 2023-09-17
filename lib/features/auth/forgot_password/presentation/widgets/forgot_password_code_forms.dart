import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/controllers/forgot_password_confirm_code_controller.dart';
import 'package:dictionary_words/global_components/buttons/custom_text_button.dart';
import 'package:dictionary_words/global_components/custom_alert.dart';
import 'package:dictionary_words/global_components/custom_otp_input.dart';
import 'package:dictionary_words/global_components/labels/forms_subtitle.dart';
import 'package:dictionary_words/global_components/labels/forms_title.dart';
import 'package:dictionary_words/global_components/buttons/custom_button.dart';

import '../../../../../global_components/theme/app_colors.dart';

class ForgotPasswordCodeForms extends StatelessWidget {
  ForgotPasswordCodeForms({super.key});

  final ForgotPasswordConfirmCodeController
      _forgotPasswordConfirmCodeController = Get.find();

  void goToLoginPage() async {
    Get.offAllNamed(AuthRoutes.LOGIN.value);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 28,
      children: [
        const FormsTitle('Verificação'),
        const FormsSubtitle(
          """Um código de cinco dígitos foi enviado para o seu e-mail. Insira-o no campo abaixo para validar e trocar sua senha.""",
          size: 15,
          align: TextAlign.start,
        ),
        GetX<ForgotPasswordConfirmCodeController>(
          builder: (_) =>
              _forgotPasswordConfirmCodeController.errorMessage.value.isNotEmpty
                  ? Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomAlert(_forgotPasswordConfirmCodeController
                            .errorMessage.value),
                        IconButton(
                          onPressed: () => _forgotPasswordConfirmCodeController
                              .resetDefaultState(),
                          icon: const Icon(Icons.close),
                          color: AppColors.alert.redText,
                        )
                      ],
                    )
                  : const SizedBox.shrink(),
        ),
        CustomOTPInput(
            onChanged: (value) =>
                _forgotPasswordConfirmCodeController.setConfirmCode(value)),
        const SizedBox(
          height: 90,
        ),
        GetX<ForgotPasswordConfirmCodeController>(
            builder: (_) => CustomButton(
                  label: 'Verificar',
                  isDisabled: _forgotPasswordConfirmCodeController
                          .codeConfirm.value.length !=
                      5,
                  isLoading: _forgotPasswordConfirmCodeController
                      .isButtonPressed.value,
                  onPressed: () async {
                    if (!_forgotPasswordConfirmCodeController
                        .isButtonPressed.value) {
                      _forgotPasswordConfirmCodeController
                          .handleButtonPressed(true);
                      await _forgotPasswordConfirmCodeController.submit();
                      _forgotPasswordConfirmCodeController
                          .handleButtonPressed(false);
                    }
                  },
                )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FormsSubtitle('Já tem uma conta?'),
            CustomTextButton(
              label: 'Logar',
              fontSize: 14,
              textDecoration: TextDecoration.underline,
              fontWeight: FontWeight.w400,
              onPressed: goToLoginPage,
            )
          ],
        )
      ],
    );
  }
}
