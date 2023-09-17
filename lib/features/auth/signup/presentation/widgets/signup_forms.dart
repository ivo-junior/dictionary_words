import 'package:dictionary_words/global_components/global_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/global_components/custom_alert.dart';
import 'package:dictionary_words/global_components/inputs/custom_email_input.dart';
import 'package:dictionary_words/global_components/buttons/custom_text_button.dart';
import 'package:dictionary_words/global_components/inputs/custom_password_input.dart';
import 'package:dictionary_words/global_components/labels/forms_subtitle.dart';
import 'package:dictionary_words/global_components/labels/forms_title.dart';
import 'package:dictionary_words/global_components/buttons/custom_button.dart';
import 'package:dictionary_words/global_components/inputs/custom_input.dart';
import 'package:dictionary_words/global_components/password_status/password_status.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

import '../controllers/signup_controller.dart';

class SignUpForms extends StatelessWidget {
  SignUpForms({super.key});

  final SignUpController _signupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signupController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormsTitle('Criar conta'),
            GetX<SignUpController>(
              builder: (_) => _signupController.errorMessage.value.isNotEmpty
                  ? Column(children: [
                      const SizedBox(height: 28),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomAlert(_signupController.errorMessage.value),
                          IconButton(
                            onPressed: () =>
                                _signupController.resetDefaultState(),
                            icon: const Icon(Icons.close),
                            color: AppColors.alert.redText,
                          )
                        ],
                      ),
                    ])
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 28),
            CustomInput(
              label: 'Nome',
              controller: _signupController.nicknameController,
              validator: (value) => validateNickname(value),
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
            ),
            const SizedBox(height: 22),
            CustomEmailInput(
              controller: _signupController.emailController,
            ),
            const SizedBox(height: 22),
            CustomPasswordInput(
              controller: _signupController.passwordController,
              onChanged: (_) => _signupController.updatePasswordObservable(),
            ),
            const SizedBox(height: 20),
            GetX<SignUpController>(
              builder: (_) => PasswordStatus(
                  password: _signupController.observablePassword.value),
            ),
            const SizedBox(height: 32),
            GetX<SignUpController>(
                builder: (_) => CustomButton(
                      isLoading: _signupController.isLoading.value,
                      label: 'Cadastrar',
                      onPressed: () async {
                        if (!_signupController.buttonPressed) {
                          _signupController.handleButtonPressed(true);
                          await _signupController.submit();
                          _signupController.handleButtonPressed(false);
                        }
                      },
                    )),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FormsSubtitle('Já tem uma conta?'),
                    CustomTextButton(
                      label: 'Logar',
                      fontSize: 14,
                      textDecoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400,
                      onPressed: _signupController.backToLoginPage,
                    )
                  ],
                )),
          ],
        ));
  }
}
