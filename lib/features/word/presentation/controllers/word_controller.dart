import 'package:dictionary_words/core/routes/app_routes.dart';
import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/word/data/models/word_model.dart';
import 'package:dictionary_words/features/word/data/repository/word_repository.dart';
import 'package:dictionary_words/global_components/services/hive_service.dart';
import 'package:dictionary_words/global_components/snack_bar.dart';
import 'package:get/get.dart';

class WordController extends GetxController {
  bool isLoading = true;
  bool isFavorit = false;

  WordRepository wordRepository = Get.find();
  final HomeController _homeController = Get.find();
  final HiveService _hiveService = Get.find();

  String? word;
  WordModel? wordModel;
  RxInt currentCount = RxInt(0);
  Rx<Results> currentResult = Rx(Results());

  @override
  void onInit() {
    super.onInit();
    var arg = Get.arguments;

    if (arg is String) {
      word = arg;
      isFavorit = _homeController.favoriteList[word!] != null;
      initiWord();
    } else {
      wordModel = arg;
      isFavorit = _homeController.favoriteList[wordModel!.word!] != null;
      alterableResult();
      isLoading = false;
    }
  }

  void initiWord() async {
    wordModel = await wordRepository.getWord(word!);
    if (wordModel == null) {
      Get.offAndToNamed(AppRoutes.HOME.value);
      snack("Not Found", "This word not found in Word API.");
    } else {
      alterableResult();
      toogleHistory();
      isLoading = false;
      update();
    }
  }

  void toogleFavorit() {
    _homeController.toogleFavoritWord(wordModel!);
    isFavorit = !isFavorit;
    update();
  }

  Future<void> toogleHistory() async {
    if (!_homeController.historyList.keys.contains(wordModel!.word)) {
      await _hiveService.addBoxes([wordModel!.toJson()], "HistoryWords");

      _homeController.updateHistoryList();
    }

    update();
  }

  void alterableResult() {
    currentResult.value = wordModel != null && wordModel!.results != null
        ? wordModel!.results![currentCount.value]
        : Results();
  }
}
