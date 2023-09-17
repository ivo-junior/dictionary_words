import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/buttons/custom_text_button.dart';
import 'package:dictionary_words/global_components/custom_alert.dart';
import 'package:dictionary_words/global_components/inputs/custom_email_input.dart';
import 'package:dictionary_words/global_components/inputs/custom_password_input.dart';
import 'package:dictionary_words/global_components/labels/forms_subtitle.dart';
import 'package:dictionary_words/global_components/labels/forms_title.dart';
import 'package:dictionary_words/global_components/buttons/custom_button.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

import '../controllers/login_controller.dart';

class LoginForms extends StatelessWidget {
  LoginForms({super.key});

  final LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _loginController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormsTitle('Login'),
            GetX<LoginController>(
              builder: (_) => _loginController.errorMessage.value.isNotEmpty
                  ? Column(children: [
                      const SizedBox(height: 22),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomAlert(_loginController.errorMessage.value),
                          IconButton(
                            onPressed: () =>
                                _loginController.resetDefaultState(),
                            icon: const Icon(Icons.close),
                            color: AppColors.alert.redText,
                          )
                        ],
                      ),
                    ])
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
            CustomEmailInput(
              controller: _loginController.emailController,
            ),
            const SizedBox(height: 28),
            CustomPasswordInput(
              controller: _loginController.passwordController,
            ),
            Align(
              alignment: Alignment.topRight,
              child: CustomTextButton(
                label: 'Esqueci minha senha',
                height: 0.1,
                onPressed: _loginController.goToForgotPassword,
              ),
            ),
            const SizedBox(height: 10),
            GetX<LoginController>(
                builder: (_) => CustomButton(
                      isLoading: _loginController.isLoading.value,
                      label: 'Entrar',
                      onPressed: _loginController.submit,
                    )),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.center,
                child: Text(
                  'ou logar com',
                  style: GoogleFonts.commissioner(
                    color: AppColors.text.labelColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.0,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FormsSubtitle('Não tem uma conta?'),
                    CustomTextButton(
                      label: 'Criar conta',
                      fontSize: 14,
                      textDecoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400,
                      onPressed: _loginController.goToSignUp,
                    )
                  ],
                )),
          ],
        ));
  }
}
