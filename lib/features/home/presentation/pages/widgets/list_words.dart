import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/word_widget.dart';
import 'package:dictionary_words/global_components/snack_bar.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListWords extends StatelessWidget {
  ListWords({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Word List',
            style: GoogleFonts.commissioner(
                color: AppColors.text.darkBlue,
                height: 2,
                fontSize: 26,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FirebaseDatabaseQueryBuilder(
          pageSize: 20,
          query: _homeController.wordsQuery,
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
                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                  snapshot.fetchMore();
                }
                final word = snapshot.docs[index].key as String;
                return Center(
                  child: WordWidget(
                      homeController: _homeController,
                      onTap: () => {},
                      word: word),
                );
              },
            );
          },
        ),
      ),
    );
  }
}