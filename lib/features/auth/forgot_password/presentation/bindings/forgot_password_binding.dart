import 'package:get/get.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/controllers/forgot_password_change_password_controller.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/controllers/forgot_password_confirm_code_controller.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/controllers/forgot_password_email_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordEmailController>(
      () => ForgotPasswordEmailController(),
    );
    Get.lazyPut<ForgotPasswordConfirmCodeController>(
      () => ForgotPasswordConfirmCodeController(),
    );
    Get.lazyPut<ForgotPasswordChangePasswordController>(
      () => ForgotPasswordChangePasswordController(),
    );
  }
}
