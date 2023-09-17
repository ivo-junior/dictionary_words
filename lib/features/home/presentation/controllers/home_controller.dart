// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum HomeRoutes {
  HOME('/home');

  const HomeRoutes(this.value);
  final String value;
}

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);
  late ScrollController scrollController = ScrollController();

  bool isLoading = false;
  bool hasInternet = true;

  String? name = "";

  var currentRoutBodyChild = RxString(HomeRoutes.HOME.value);

  FirebaseAuth? auth = Get.arguments;
  User? user;

  final wordsQuery = FirebaseDatabase.instance.ref();

  @override
  void onInit() {
    super.onInit();
    auth ??= FirebaseAuth.instance;
    user = auth!.currentUser;
  }

  @override
  void onClose() {
    super.onClose();
    _timerResponse?.cancel();
  }

  void handleIsLoading(bool status) {
    isLoading = status;
    update();
  }

  void handleHasInternet(bool status) {
    hasInternet = status;
    update();
  }

  Timer? _timerResponse;

  void changeRoutBodyChild(String route) {
    currentRoutBodyChild.value = route;
    update();
  }
}
