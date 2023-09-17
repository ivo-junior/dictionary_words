import 'package:get/get.dart';
import 'package:dictionary_words/features/auth/signup/presentation/controllers/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}
