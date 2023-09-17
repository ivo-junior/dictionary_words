import 'package:dictionary_words/features/word/data/models/word_model.dart';
import 'package:dictionary_words/features/word/data/repository/word_repository.dart';
import 'package:get/get.dart';

class WordController extends GetxController {
  bool isLoading = true;
  WordModel wordModel = WordModel();

  WordRepository wordRepository = Get.find();
  final String word = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    initiWord();
  }

  initiWord() async {
    wordModel = await wordRepository.getWord(word);
    isLoading = false;
    update();
  }
}
