// ignore_for_file: non_constant_identifier_names

import 'package:dictionary_words/features/word/presentation/bindings/word_binding.dart';
import 'package:dictionary_words/features/word/presentation/pages/word_page.dart';
import 'package:get/get.dart';
import 'package:dictionary_words/core/routes/app_routes.dart';
import 'package:dictionary_words/core/routes/auth_pages.dart';
import 'package:dictionary_words/features/home/presentation/bindings/home_binding.dart';
import 'package:dictionary_words/features/home/presentation/pages/home_page.dart';
import 'package:dictionary_words/features/splash/presentation/bindings/splash_binding.dart';
import 'package:dictionary_words/features/splash/presentation/pages/splash_page.dart';

class AppPages {
  static final INITIAL = AppRoutes.SPLASH.value;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.SPLASH.value,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: AppRoutes.HOME.value,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.WORD_PAGE.value,
        page: () => const WordPage(),
        binding: WordBinding()),
    ...AuthPages.pages
  ];
}
