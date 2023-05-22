import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_controller.dart';
import 'navigator/navigator_route.dart';
import 'widget/widget_navigation.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = contentNavigator();
    final indexStack = _buildIndexStack();
    final materialTheme = Theme.of(context);
    return _buildPanel(context, indexStack, content, materialTheme);
  }

  Widget _buildPanel(
    BuildContext context,
    Widget indexStack,
    Widget content,
    ThemeData materialTheme,
  ) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1000) {
        return Scaffold(
          backgroundColor: materialTheme.colorScheme.onInverseSurface,
          body: Row(
            children: [
              Visibility(
                visible: constraints.maxWidth >= 1000,
                child: const RailNavigationWidget(),
              ),
              Container(
                width: 700,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.withOpacity(.1)),
                  ),
                ),
                child: indexStack,
              ),
              Expanded(
                child: content,
              ),
            ],
          ),
        );
      } else {
        return Stack(
          children: [
            Scaffold(
                body: indexStack,
                bottomNavigationBar: const BottomNavigationWidget()),
            Obx(
              () => IgnorePointer(
                ignoring: !controller.showContent.value,
                child: content,
              ),
            )
          ],
        );
      }
    });
  }

  Widget _buildIndexStack() {
    return Obx(
      () => IndexedStack(
        key: controller.indexKey,
        index: controller.currentPageIndex,
        children: controller.pages,
      ),
    );
  }
}
