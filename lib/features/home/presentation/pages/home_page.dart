// ignore_for_file: depend_on_referenced_packages

import 'package:dictionary_words/features/home/presentation/pages/widgets/list_history.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/list_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/features/home/presentation/controllers/home_controller.dart';
import 'package:dictionary_words/features/home/presentation/pages/widgets/off_page.dart';
import 'package:dictionary_words/global_components/shimmer.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

import 'widgets/list_favorites.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController(), permanent: true);
  List<GlobalKey> stepKeys = [];
  int cardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<HomeController>(builder: (_) {
        if (controller.isLoading) {
          return const ShimmerDefalt();
        } else {
          if (!controller.hasInternet) {
            controller.changeRoutBodyChild("/off_page");
          }
          return Scaffold(
            backgroundColor: AppColors.areiaHome,
            extendBodyBehindAppBar: true,
            body: NestedScrollView(
              controller: controller.scrollController,
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Column(children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: Text(
                              'Dictionary Words',
                              style: GoogleFonts.commissioner(
                                  color: AppColors.text.darkBlue,
                                  height: 2,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 18),
                        ]),
                        Stack(
                          fit: StackFit.passthrough,
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: controller
                                                  .currentRoutBodyChild.value ==
                                              '/home'
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 2.0),
                                ),
                              ),
                            ),
                            TabBar(
                              controller: controller.tabController,
                              indicatorColor:
                                  controller.currentRoutBodyChild.value ==
                                          '/home'
                                      ? const Color(0xff612BD6)
                                      : Colors.transparent,
                              unselectedLabelColor: Colors.white,
                              unselectedLabelStyle:
                                  const TextStyle(fontSize: 2.0),
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Word List',
                                    style: GoogleFonts.commissioner(
                                        color: AppColors.text.darkBlue,
                                        height: 2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'History',
                                    style: GoogleFonts.commissioner(
                                        color: AppColors.text.darkBlue,
                                        height: 2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Favorites',
                                    style: GoogleFonts.commissioner(
                                        color: AppColors.text.darkBlue,
                                        height: 2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                              onTap: (value) =>
                                  controller.currentRoutBodyChild.value ==
                                          '/home'
                                      ? controller.update()
                                      : null,
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: Builder(builder: (context) {
                if (controller.currentRoutBodyChild.value == "/off_page") {
                  return const OffPage();
                } else {
                  return TabBarView(
                      controller: controller.tabController,
                      children: [
                        ListWords(),
                        ListHistory(),
                        ListFavorites(),
                      ]);
                }
              }),
            ),
          );
        }
      }),
    );
  }
}
