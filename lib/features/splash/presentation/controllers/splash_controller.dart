import 'dart:async';

import 'package:dictionary_words/core/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int durationAnimation = 500;

  User? usuario;

  RxBool isLoading = RxBool(true);
  RxBool first = RxBool(true);

  @override
  Future<void> onInit() async {
    super.onInit();
    _authCheck();
  }

  @override
  void onReady() {
    Timer(Duration(milliseconds: durationAnimation), () {
      first.value = false;
    });
    Timer(const Duration(milliseconds: 2500), () {
      if (isLoading.value) {
        Get.offAllNamed(AppRoutes.HOME.value, arguments: _auth);
      }
    });
    super.onReady();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading.value = (user == null) ? true : false;
    });
  }
}
