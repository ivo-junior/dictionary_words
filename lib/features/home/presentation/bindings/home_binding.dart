import 'package:dictionary_words/global_components/services/hive_service.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HiveService>(
      () => HiveService(),
    );
  }
}
