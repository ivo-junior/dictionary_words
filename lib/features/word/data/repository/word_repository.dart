import 'package:dictionary_words/features/word/data/models/word_model.dart';
import 'package:dictionary_words/features/word/data/provider/word_provider.dart';

class WordRepository {
  final WordApi api = WordApi();

  Future<WordModel> getWord(String word) async {
    WordModel wordModel;
    Map<String, dynamic> json = await api.getWord(word);
    wordModel = WordModel.fromJson(json);

    return wordModel;
  }
}
