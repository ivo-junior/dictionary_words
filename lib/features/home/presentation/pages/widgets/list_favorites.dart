// ignore_for_file: deprecated_member_use

import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/no_data_page.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/request_login.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/word_widget.dart';
import 'package:dictionary_words/features/word/data/models/word_model.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'off_page.dart';

class ListFavorites extends StatelessWidget {
  ListFavorites({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (_homeController.currentRoutBodyChild.value == "/off_page") {
      return const OffPage();
    } else if (_homeController.user == null) {
      return RequestLogin();
    } else if (_homeController.favoriteList.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Favorite List',
                style: GoogleFonts.commissioner(
                    color: AppColors.text.darkBlue,
                    height: 2,
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
              IconButton(
                onPressed: () => showLogoutButton(context),
                icon: const Icon(
                  Icons.person,
                  color: AppColors.darkBlue,
                ),
                iconSize: 32,
              )
            ],
          ),
        ),
        body: GridView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: _homeController.favoriteList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            final word = _homeController.favoriteList.values.elementAt(index);
            WordModel? wordModel;
            if (_homeController.historyList.isNotEmpty) {
              wordModel = _homeController.historyList[word.word];
            }
            return Center(
              child: WordWidget(
                homeController: _homeController,
                word: wordModel.isNull ? word.word! : null,
                wordModel: wordModel.isNull ? null : wordModel,
              ),
            );
          },
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => showLogoutButton(context),
                  icon: const Icon(
                    Icons.person,
                    color: AppColors.darkBlue,
                  ),
                  iconSize: 32,
                )
              ],
            ),
          ),
          body: const Center(child: NodataPage()));
    }
  }

  void showLogoutButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Center(
              child: IconButton(
                onPressed: () => _homeController.logout(),
                icon: const Icon(
                  Icons.logout,
                  color: AppColors.darkBlue,
                ),
                iconSize: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
