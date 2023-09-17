// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:dictionary_words/global_components/base_url.dart';
import 'package:dictionary_words/global_components/snack_bar.dart';
import 'package:http/http.dart';

class WordApi {
  final Client httpClient = Client();

  Future<Map<String, dynamic>> getWord(String word) async {
    try {
      final headers = {
        "X-RapidAPI-Key": tokenUrlWordApi,
        "X-RapidAPI-Host": baseUrlWordApi
      };

      var uri = Uri.parse("https://$baseUrlWordApi/words/$word");

      var response = await get(uri, headers: headers);

      return json.decode(response.body);
    } on HttpException catch (error) {
      snack('Error', "Erro!, Houve um erro na consulta!");
      return {"erro": error};
    }
  }
}
