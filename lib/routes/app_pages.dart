import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/pages/detail/detail_page.dart';
import 'package:lenoid/pages/home/home_controller.dart';
import 'package:lenoid/pages/library/library_controller.dart';
import 'package:lenoid/pages/library/library_page.dart';
import 'package:lenoid/pages/main/main_controller.dart';
import 'package:lenoid/pages/main/main_page.dart';
import 'package:lenoid/widgets/empty_view.dart';

import 'route_path.dart';

class AppPages {
  AppPages._();
  static final routes = [
    // home pages
    GetPage(name: RoutePath.kMain, page: () => const MainPage(), bindings: [
      BindingsBuilder.put(() => MainController()),
      BindingsBuilder.put(() => HomeController()),
    ]),
    // library pages
    GetPage(
      name: RoutePath.kLibrary,
      page: () => const LibraryPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => LibraryController()),
      ),
    ),
  ];

  static Route<dynamic>? createSubRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return GetPageRoute(
          settings: settings,
          page: () => const EmptyView(),
        );
      case RoutePath.kDetail:
        final parameter = settings.arguments as Map;
        return GetPageRoute(
          settings: settings,
          page: () => DetailPage(parameter['title']),
        );
      default:
        return GetPageRoute(page: () => const EmptyView());
    }
  }
}
