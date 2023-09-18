// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:dictionary_words/features/word/data/models/word_model.dart';
import 'package:dictionary_words/global_components/services/hive_service.dart';
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

  bool isLoading = true;
  bool hasInternet = true;

  String? name = "";

  var currentRoutBodyChild = RxString(HomeRoutes.HOME.value);

  FirebaseAuth? auth = Get.arguments;
  User? user;

  final wordsQuery = FirebaseDatabase.instance.ref().child("words");

  RxList<String> favoriteList = RxList([]);
  RxMap<String, WordModel> historyList = RxMap({});

  final HiveService _hiveService = Get.find();

  @override
  void onInit() {
    super.onInit();
    auth ??= FirebaseAuth.instance;
    getHistory();
    user = auth!.currentUser;
    // _hiveService.cleanBoxes("HistoryWords");
  }

  @override
  void onClose() {
    super.onClose();
    _timerResponse?.cancel();
  }

  void toogleFavoritWord(String word) {
    if (favoriteList.contains(word)) {
      favoriteList.remove(word);
    } else {
      favoriteList.add(word);
    }
    update();
  }

  Future<void> updateHistoryList() async {
    var history = await _hiveService.getBoxes("HistoryWords");
    for (var w in history) {
      var wordModel = WordModel.fromJson(w);
      historyList.addAll({wordModel.word!: wordModel});
    }
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

  void getHistory() async {
    bool exists = await _hiveService.isExists(boxName: "HistoryWords");
    if (exists) {
      updateHistoryList();
    }
    handleIsLoading(false);
  }
}
