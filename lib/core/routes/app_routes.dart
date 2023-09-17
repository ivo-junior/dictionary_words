// ignore_for_file: constant_identifier_names

enum AppRoutes {
  SPLASH('/splash'),
  HOME('/home'),
  WORD_PAGE('/word');

  const AppRoutes(this.value);
  final String value;
}
