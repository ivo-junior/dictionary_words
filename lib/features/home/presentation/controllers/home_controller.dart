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
  bool isLogin = false;
  bool hasInternet = true;

  String? name = "";

  var currentRoutBodyChild = RxString(HomeRoutes.HOME.value);

  FirebaseAuth? auth = Get.arguments;
  User? user;

  final wordsRef = FirebaseDatabase.instance.ref().child("words");
  final _favoritsRef = FirebaseDatabase.instance.ref().child("favorits");

  RxMap<String, WordModel> favoriteList = RxMap({});

  RxMap<String, WordModel> historyList = RxMap({});

  final HiveService _hiveService = Get.find();

  @override
  void onInit() {
    super.onInit();
    auth ??= FirebaseAuth.instance;
    initFavoritList();
    getHistory();
    user = auth!.currentUser;
  }

  @override
  void onClose() {
    super.onClose();
    timerResponse?.cancel();
  }

  void toogleFavoritWord(WordModel word) {
    if (auth!.currentUser != null) {
      if (favoriteList[word.word] != null) {
        favoriteList.remove(word.word);
        _favoritsRef.child(auth!.currentUser!.uid).child(word.word!).remove();
      } else {
        favoriteList.addAll({word.word!: word});
        _favoritsRef
            .child(auth!.currentUser!.uid)
            .child(word.word!)
            .set(word.toJson());
      }
    }
    update();
  }

  Future<void> initFavoritList() async {
    if (auth!.currentUser != null) {
      var data = await _favoritsRef.child(auth!.currentUser!.uid).once();

      if (data.snapshot.value != null) {
        var val = data.snapshot.value as Map;

        val.forEach((key, value) {
          var w = WordModel.fromJson(value);
          favoriteList.addAll({w.word!: w});
        });
      }
    }
  }

  Future<void> updateHistoryList() async {
    var history = await _hiveService.getBoxes("HistoryWords");
    for (var w in history) {
      var wordModel = WordModel.fromJson(w);
      historyList.addAll({wordModel.word!: wordModel});
    }
  }

  Future<void> logout() async {
    await auth!.signOut();
    user = null;
    Get.back();
    update();
  }

  void handleIsLoading(bool status) {
    isLoading = status;
    update();
  }

  void handleHasInternet(bool status) {
    hasInternet = status;
    update();
  }

  Timer? timerResponse;

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
