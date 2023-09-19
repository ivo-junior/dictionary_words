// ignore_for_file: constant_identifier_names

import 'package:dictionary_words/features/auth/forgot_password/presentation/widgets/forgot_password_send_mail.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/auth_routes.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/bindings/forgot_password_binding.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/widgets/forgot_password_email_forms.dart';
import 'package:dictionary_words/features/auth/forgot_password/presentation/widgets/forgot_password_sucess.dart';
import 'package:dictionary_words/features/auth/login/presentation/bindings/login_binding.dart';
import 'package:dictionary_words/features/auth/login/presentation/widgets/login_forms.dart';
import 'package:dictionary_words/features/auth/signup/presentation/bindings/signup_binding.dart';
import 'package:dictionary_words/features/auth/signup/presentation/widgets/signup_forms.dart';
import 'package:dictionary_words/features/auth/signup/presentation/widgets/signup_sucess.dart';

class AuthPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AuthRoutes.LOGIN.value,
        page: () => LoginForms(),
        transition: Transition.upToDown,
        binding: LoginBinding()),
    GetPage(
        name: AuthRoutes.SIGNUP.value,
        page: () => SignUpForms(),
        binding: SignUpBinding(),
        transition: Transition.upToDown),
    GetPage(
        name: AuthRoutes.SIGNUP_SUCESS.value,
        page: () => const SignUpSucess(),
        transition: Transition.upToDown),
    GetPage(
        name: AuthRoutes.FORGOT_PASSWORD_EMAIL.value,
        page: () => ForgotPasswordEmailForms(),
        binding: ForgotPasswordBinding(),
        transition: Transition.upToDown),
    GetPage(
        name: AuthRoutes.FORGOT_PASSWORD_SEND_EMAIL.value,
        page: () => const ForgotPasswordSendMail(),
        transition: Transition.upToDown),
    GetPage(
        name: AuthRoutes.FORGOT_PASSWORD_SUCESS.value,
        page: () => const ForgotPasswordSucess(),
        transition: Transition.upToDown),
  ];
}
