// ignore_for_file: constant_identifier_names

enum AuthRoutes {
  LOGIN('/login'),

  SIGNUP('/signup'),
  SIGNUP_SUCESS('/signup-sucess'),

  FORGOT_PASSWORD_EMAIL('/forgot-password-email'),
  FORGOT_PASSWORD_CODE_VERIFY('/forgot-password-code-verify'),
  FORGOT_PASSWORD_CHANGE_PASSWORD('/forgot-password-change-password'),
  FORGOT_PASSWORD_SUCESS('/forgot-password-sucess');

  const AuthRoutes(this.value);
  final String value;
}
