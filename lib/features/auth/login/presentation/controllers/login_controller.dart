import 'package:dictionary_words/core/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final errorMessage = RxString('');

  final isLoading = RxBool(false);

  FirebaseAuth? auth = Get.arguments;

  User? user;

  @override
  void onInit() {
    auth ??= FirebaseAuth.instance;
    super.onInit();
  }

  void resetDefaultState() {
    FocusManager.instance.primaryFocus?.unfocus();
    errorMessage.value = '';
  }

  void resetValues() {
    resetDefaultState();
    emailController.clear();
    passwordController.clear();
    formKey.currentState!.reset();
  }

  void goToSignUp() {
    resetValues();
    Get.toNamed(AuthRoutes.SIGNUP.value, arguments: auth!);
  }

  void goToForgotPassword() {
    resetValues();
    Get.toNamed(AuthRoutes.FORGOT_PASSWORD_EMAIL.value, arguments: auth!);
  }

  Future<void> submit() async {
    resetDefaultState();
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await auth!.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        user = auth!.currentUser;
        Get.offNamed(AppRoutes.HOME.value);
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {        
        if (e.code == 'invalid-email') {
          errorMessage.value = 'Email inválido.';
        } else if (e.code == 'wrong-password') {
          errorMessage.value = 'Email já está em uso.';
        } else if (e.code == 'user-not-found') {
          errorMessage.value = 'Usuário não encontrado.';
        } else if (e.code == 'user-disabled') {
          errorMessage.value = 'Usuário desabilitado.';
        } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          errorMessage.value = 'Email ou senha inválido.';
        }
        isLoading.value = false;
        update();
      }
    }
  }
}
