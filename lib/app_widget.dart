// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dictionary_words/core/routes/app_pages.dart';
import 'package:dictionary_words/global_components/layouts/global_layout/global_layout.dart';
import 'package:dictionary_words/global_components/layouts/global_layout/global_layout_controller.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _globalLayoutController = Get.put(GlobalLayoutController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      title: 'dictionary_words',
      routingCallback: (value) =>
          _globalLayoutController.setCurrentRoute(value),
      builder: (context, child) {
        return GlobalLayout(child: child!);
      },
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppPages.INITIAL,
    );
  }
}
