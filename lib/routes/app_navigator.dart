import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/pages/main/main_controller.dart';
import 'package:lenoid/routes/route_path.dart';
import 'package:lenoid/utils/logger/log.dart';

// tbh this is not my code
class AppNavigator {
  // current route index name default is "/"
  static String currentContentRouteName = "/";
  // sub route default id
  static const int defaultNavigatorId = 1;
  // sub route identified key
  static final GlobalKey<NavigatorState>? navigatorKey =
      Get.nestedKey(defaultNavigatorId);

  // child route context
  static BuildContext get navigatorContext => navigatorKey!.currentContext!;

  // Common
  static void toPage(String name, {dynamic arg}) {
    Get.toNamed(name, arguments: arg);
  }

  static void toContentPage(String name, {dynamic arg, bool replace = false}) {
    Log.i("toContentPage: $currentContentRouteName $name");
    if (currentContentRouteName == name && replace) {
      Get.offAndToNamed(name, arguments: arg, id: defaultNavigatorId);
    } else {
      Get.toNamed(name, arguments: arg, id: defaultNavigatorId);
    }
  }

  static void closePage() {
    if (Navigator.canPop(Get.context!)) {
      Get.back();
    } else {
      Get.back(id: 1);
    }
  }

  static void toDetailPage(String url, String title) {
    toContentPage(RoutePath.kDetail, arg: {
      "url": url,
      "title": title,
    });
  }
}

class SubNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      var routeName = route.settings.name ?? "";
      AppNavigator.currentContentRouteName = routeName;
      Get.find<MainController>().showContent.value = routeName != '/';
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    var routeName = previousRoute?.settings.name ?? "";
    AppNavigator.currentContentRouteName = routeName;
    Get.find<MainController>().showContent.value = routeName != '/';
  }
}
