import 'package:dictionary_words/core/routes/app_routes.dart';
import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/word/data/models/word_model.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class InputSearch extends StatelessWidget {
  final HomeController homeController;
  const InputSearch({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: homeController.searchController,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.search,
            color: AppColors.darkBlue,
          ),
          hintText: 'Pesquisar',
        ),
      ),
      suggestionsCallback: (pattern) async {
        if (pattern != '') {
          return await homeController.searchFirebaseDatabase(pattern);
        }
        return [];
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        WordModel? wordModel;

        if (homeController.historyList.isNotEmpty) {
          wordModel = homeController.historyList[suggestion];
        }

        homeController.searchController.text = '';

        Get.toNamed(AppRoutes.WORD_PAGE.value,
            arguments: wordModel ?? suggestion);
      },
    );
  }
}
