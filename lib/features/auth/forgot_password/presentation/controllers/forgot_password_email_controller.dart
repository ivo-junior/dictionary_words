// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';

class ForgotPasswordEmailController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final errorMessage = RxString('');

  final FirebaseAuth _auth = Get.arguments;

  bool buttonPressed = false;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void handleButtonPressed(bool state) {
    buttonPressed = state;
    update();
  }

  void goToConfirm() {
    Get.offAllNamed(AuthRoutes.FORGOT_PASSWORD_SEND_EMAIL.value);
  }

  void resetDefaultState() {
    errorMessage.value = '';
  }

  void goToLogin() {
    formKey.currentState!.reset();

    Get.offAllNamed(AuthRoutes.LOGIN.value, arguments: _auth);
  }

  Future<void> submit() async {
    errorMessage.value = '';
    if (formKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(email: emailController.text);
        goToConfirm();
        formKey.currentState!.reset();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'auth/invalid-email') {
          errorMessage.value = 'Endereço de email não é válido.';
        } else if (e.code == 'auth/missing-android-pkg-name' ||
            e.code == 'auth/missing-continue-uri' ||
            e.code == 'auth/missing-ios-bundle-id' ||
            e.code == 'auth/invalid-continue-uri' ||
            e.code == 'auth/unauthorized-continue-uri') {
          errorMessage.value = 'Erro interno.';
        } else if (e.code == 'auth/user-not-found') {
          errorMessage.value = 'Usuário não encontrado.';
        }
        update();
      }
    }
  }
}
