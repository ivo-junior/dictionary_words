import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/word/data/models/word_model.dart';
import 'package:dictionary_words/features/word/data/repository/word_repository.dart';
import 'package:dictionary_words/global_components/snack_bar.dart';
import 'package:get/get.dart';

class WordController extends GetxController {
  bool isLoading = true;
  bool isFavorit = false;
  WordModel? wordModel = WordModel();

  WordRepository wordRepository = Get.find();
  final HomeController _homeController = Get.find();

  final String word = Get.arguments;

  RxInt currentCount = RxInt(0);
  Rx<Results> currentResult = Rx(Results());

  @override
  void onInit() {
    super.onInit();

    initiWord();
  }

  void initiWord() async {
    wordModel = await wordRepository.getWord(word);
    if (wordModel == null) {
      Get.back();
      snack("Not Found", "This word not found in Word API.");
    }
    isFavorit = _homeController.favoriteList.contains(wordModel!.word!);
    alterableResult();
    isLoading = false;
    update();
  }

  void toogleFavorit() {
    _homeController.toogleFavoritWord(wordModel!.word!);
    isFavorit = !isFavorit;
    update();
  }

  void alterableResult() {
    currentResult.value =
        wordModel != null ? wordModel!.results![currentCount.value] : Results();
  }
}
