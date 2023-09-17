import 'package:dictionary_words/features/word/data/repository/word_repository.dart';
import 'package:dictionary_words/features/word/presentation/controllers/word_controller.dart';
import 'package:get/get.dart';

class WordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WordController>(
      () => WordController(),
    );
    Get.lazyPut<WordRepository>(
      () => WordRepository(),
    );
  }
}
