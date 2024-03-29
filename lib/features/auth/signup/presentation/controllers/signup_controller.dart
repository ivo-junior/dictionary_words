// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';

class SignUpController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final observablePassword = RxString('');

  final errorMessage = RxString('');
  final isLoading = RxBool(false);

  final FirebaseAuth _auth = Get.arguments;
  User? user;
  bool buttonPressed = false;

  @override
  void onClose() {
    nicknameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void handleButtonPressed(bool value) {
    buttonPressed = value;
    update();
  }

  void goToSucessPage() {
    Get.offAllNamed(AuthRoutes.SIGNUP_SUCESS.value, arguments: _auth);
  }

  void resetDefaultState() {
    FocusManager.instance.primaryFocus?.unfocus();
    errorMessage.value = '';
  }

  void backToLoginPage() {
    Get.back();
  }

  void updatePasswordObservable() {
    observablePassword.value = passwordController.value.text;
  }

  Future<void> submit() async {
    resetDefaultState();
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        user = _auth.currentUser;
        
        isLoading.value = false;
        goToSucessPage();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          errorMessage.value = 'Email já está em uso.';
        } else if (e.code == 'invalid-email') {
          errorMessage.value = 'Email inválido.';
        } else if (e.code == 'operation-not-allowed') {
          errorMessage.value = 'Email ou senhas desativados.';
        } else if (e.code == 'weak-password') {
          errorMessage.value = 'Senha fraca.';
        }
        isLoading.value = false;
      }

      update();
    }
  }
}
