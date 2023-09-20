// ignore_for_file: deprecated_member_use
import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/word_widget.dart';
import 'package:dictionary_words/features/word/data/models/word_model.dart';
import 'package:dictionary_words/global_components/inputs/imput_search.dart';
import 'package:dictionary_words/global_components/snack_bar.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'off_page.dart';

class ListWords extends StatelessWidget {
  ListWords({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (_homeController.currentRoutBodyChild.value == "/off_page") {
      return const OffPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Text(
                'Word List',
                style: GoogleFonts.commissioner(
                    color: AppColors.text.darkBlue,
                    height: 2,
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                  child: InputSearch(
                    homeController: _homeController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FirebaseDatabaseQueryBuilder(
          pageSize: 20,
          query: _homeController.wordsRef,
          builder: (context, snapshot, child) {
            if (snapshot.isFetching) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.darkBlue,
                ),
              );
            }
            if (snapshot.hasError) {
              snack('Error', snapshot.error.toString());
            }

            return GridView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: snapshot.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                final word = snapshot.docs[index].key as String;
                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                  // test variable
                  _homeController.testCurrentWordScrol = word;
                  snapshot.fetchMore();
                }

                WordModel? wordModel;

                if (_homeController.historyList.isNotEmpty) {
                  wordModel = _homeController.historyList[word];
                }

                return Center(
                    child: WordWidget(
                  key: Key(wordModel.isNull ? word : wordModel!.word!),
                  homeController: _homeController,
                  word: wordModel.isNull ? word : null,
                  wordModel: wordModel.isNull ? null : wordModel,
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
