import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/routes/app_navigator.dart';
import 'package:lenoid/routes/app_pages.dart';
import 'package:lenoid/widgets/status/empty_widget.dart';

extension WillPopScopeExt on Widget {
  WillPopScope contentNavigator() {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.canPop(Get.context!)) {
          return true;
        }
        if (AppNavigator.navigatorKey!.currentState!.canPop()) {
          AppNavigator.navigatorKey!.currentState!.pop();
          return false;
        }
        return true;
      },
      child: ClipRect(
        child: Navigator(
          key: AppNavigator.navigatorKey,
          initialRoute: '/',
          onUnknownRoute: (settings) => GetPageRoute(
            page: () =>
                const EmptyWidget(message: "Looks like your'e lost <W>"),
          ),
          observers: [SubNavigatorObserver()],
          onGenerateRoute: AppPages.createSubRoute,
        ),
      ),
    );
  }
}
