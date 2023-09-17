// ignore_for_file: constant_identifier_names

const MIN_PASSWORD_LENGTH = 8;

String? validateNickname(String? value) {
  if (value == null || value.isEmpty) {
    return 'Digite seu Nome';
  }
  if (value.length < 3) {
    return 'Seu nome deve ter no mínimo 3 caracteres';
  }
  return null;
}

String? validateEmail(String? value) {
  String emailRegexPattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  final RegExp emailRegex = RegExp(emailRegexPattern);

  if (value == null || !emailRegex.hasMatch(value)) {
    return 'Digite um email válido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Digite a senha';
  }
  if (value.length < MIN_PASSWORD_LENGTH) {
    return 'A senha deve conter no mínimo $MIN_PASSWORD_LENGTH caracteres';
  }
  return null;
}

String? validateEqualPassword(String? newPassword, String? confirmPassword) {
  if ((newPassword == null || newPassword.isEmpty) ||
      (confirmPassword == null || confirmPassword.isEmpty)) {
    return 'Senhas não coincidem';
  }
  if (confirmPassword.length < MIN_PASSWORD_LENGTH) {
    return 'A senha deve conter no mínimo $MIN_PASSWORD_LENGTH caracteres';
  }
  if (newPassword != confirmPassword) {
    return 'Senhas não coincidem';
  }
  return null;
}
