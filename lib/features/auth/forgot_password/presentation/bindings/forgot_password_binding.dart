import 'package:get/get.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/controllers/forgot_password_email_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordEmailController>(
      () => ForgotPasswordEmailController(),
    );
  }
}
