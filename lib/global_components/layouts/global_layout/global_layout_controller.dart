import 'package:get/get.dart';

class GlobalLayoutController extends GetxController {
  final currentRouteName = RxString('/');

  void setCurrentRoute(Routing? routing) {
    if (routing != null) {
      currentRouteName.value = routing.current;
    }
  }
}
