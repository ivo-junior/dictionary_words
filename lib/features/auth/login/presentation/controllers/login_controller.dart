import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';
import 'package:dictionary_words/global_components/layouts/auth_layout/auth_layout_animation_controller.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final errorMessage = RxString('');

  final isLoading = RxBool(false);

  final AuthLayoutAnimationController _authAnimationController =
      Get.put(AuthLayoutAnimationController(), permanent: true);

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
    _authAnimationController.resetSheetScrollPosition();
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
        _authAnimationController.resetValues();
        // goToTermsCondictions();
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          errorMessage.value = 'A senha é muito fraca.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage.value = 'Email já está em uso.';
        } else if (e.code == 'user-not-found') {
          errorMessage.value = 'Usuário não encontrado.';
        } else if (e.code == 'user-disabled') {
          errorMessage.value = 'Usuário desabilitado.';
        }
        isLoading.value = false;
        update();
      }
    }
  }
}
