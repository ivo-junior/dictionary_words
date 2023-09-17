import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';
import 'package:dictionary_words/global_components/layouts/auth_layout/auth_layout_animation_controller.dart';

class ForgotPasswordConfirmCodeController extends GetxController {
  final codeConfirm = RxString('');
  final errorMessage = RxString('');

  final AuthLayoutAnimationController _animationController = Get.find();

  final FirebaseAuth _auth = Get.arguments;

  final String email = Get.arguments;

  RxBool isButtonPressed = RxBool(false);

  void handleButtonPressed(bool state) {
    isButtonPressed.value = state;
    update();
  }

  void setConfirmCode(String value) {
    errorMessage.value = '';
    codeConfirm.value = value;
  }

  void backToLoginPage() {
    Get.close(2);
    _animationController.resetSheetScrollPosition();
  }

  void resetDefaultState() {
    errorMessage.value = '';
  }

  void goToChangePasswordPage() {
    Get.offAllNamed(AuthRoutes.FORGOT_PASSWORD_CHANGE_PASSWORD.value,
        arguments: [email, codeConfirm.value, _auth]);
    _animationController.resetSheetScrollPosition();
  }

  Future<void> submit() async {
    try {
      String resultEmail =
          await _auth.verifyPasswordResetCode(codeConfirm.value);
      if (resultEmail != '') {
        goToChangePasswordPage();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'expired-action-code') {
        errorMessage.value = 'Código expirado.';
      } else if (e.code == 'invalid-action-code') {
        errorMessage.value = 'Código inválido.';
      } else if (e.code == 'user-disabled') {
        errorMessage.value = 'Usuário desativado.';
      } else if (e.code == 'user-not-found') {
        errorMessage.value = 'Usuário não encontrado.';
      }
      update();
    }
  }
}
