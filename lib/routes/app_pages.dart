import 'package:get/get.dart';
import 'package:lenoid/pages/main/main_page.dart';
import 'package:lenoid/pages/main/main_controller.dart';
import 'package:lenoid/pages/home/home_controller.dart';
import 'package:lenoid/pages/library/library_page.dart';
import 'package:lenoid/pages/library/library_controller.dart';

import 'route_path.dart';

class AppPages {
  AppPages._();
  static final routes = [
    // home pages
    GetPage(
      name: RoutePath.kMain,
      page: () => const MainPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MainController());
        Get.lazyPut(() => HomeController());
      }),
    ),
    // library pages
    GetPage(
      name: RoutePath.kLbrary,
      page: () => const LibraryPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => LibraryController()),
      ),
    ),
  ];
}
