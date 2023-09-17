import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/no_data_page.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/word_widget.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListFavorites extends StatelessWidget {
  ListFavorites({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (_homeController.favoriteList.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              'Favorite List',
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
          child: GridView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: _homeController.favoriteList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              final word = _homeController.favoriteList[index];
              return Center(
                child: WordWidget(
                    homeController: _homeController,
                    onTap: () => {},
                    word: word),
              );
            },
          ),
        ),
      );
    } else {
      return const NodataPage();
    }
  }
}
