import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/no_data_page.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/word_widget.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListHistory extends StatelessWidget {
  ListHistory({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (_homeController.historyList.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'History',
                style: GoogleFonts.commissioner(
                    color: AppColors.text.darkBlue,
                    height: 2,
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: _homeController.historyList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              final word = _homeController.historyList[index];
              return Center(
                child: WordWidget(
                    homeController: _homeController, wordModel: word),
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
