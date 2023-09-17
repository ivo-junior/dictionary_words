bool hasNumber(String str) {
  final numberRegex = RegExp(r'\d');
  return numberRegex.firstMatch(str) != null;
}

bool hasSpecialChar(String str) {
  final specialCharRegex =
      RegExp(r"""[!@#\$%\^&\*\(\)\-_=+\[\]{};:\'",.<>/?\\|]""");
  return specialCharRegex.firstMatch(str) != null;
}

bool hasUpperCase(String str) {
  final upperCaseRegex = RegExp(r'[A-Z]');
  return upperCaseRegex.firstMatch(str) != null;
}

bool hasLowerCase(String str) {
  final lowerCaseRegex = RegExp(r'[a-z]');
  return lowerCaseRegex.firstMatch(str) != null;
}

bool hasMinLength(String str, int minLength) {
  return str.length >= minLength;
}
