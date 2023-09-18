import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';

class ForgotPasswordChangePasswordController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final errorMessage = RxString('');

  final passwordController = TextEditingController();
  final observablePassword = RxString('');
  final confirmPasswordController = TextEditingController();


  final String email = Get.arguments[0];
  final String code = Get.arguments[1];
  final FirebaseAuth _auth = Get.arguments[2];

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void goToSucessPage() {
    Get.offAllNamed(AuthRoutes.FORGOT_PASSWORD_SUCESS.value);
  }

  void resetDefaultState() {
    errorMessage.value = '';
  }

  void updatePasswordObservable() {
    observablePassword.value = passwordController.value.text;
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      errorMessage.value = '';
      try {
        await _auth.confirmPasswordReset(
            code: code, newPassword: confirmPasswordController.text);
        goToSucessPage();
        formKey.currentState!.reset();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'expired-action-code') {
          errorMessage.value = 'Endereço de email não é válido.';
        } else if (e.code == 'invalid-action-code') {
          errorMessage.value = 'Código inválido.';
        } else if (e.code == 'user-disabled') {
          errorMessage.value = 'Usuário desativado.';
        } else if (e.code == 'user-not-found') {
          errorMessage.value = 'Usuário não encontrado.';
        } else if (e.code == 'weak-password') {
          errorMessage.value = 'Senha fraca.';
        }
        update();
      }
    }
  }
}
