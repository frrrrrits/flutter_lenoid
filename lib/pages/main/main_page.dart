import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: materialTheme.colorScheme.onInverseSurface,
          body: Obx(
            () => Row(
              children: [
                SafeArea(
                  child: Obx(
                    () => NavigationRail(
                      minExtendedWidth: 170,
                      selectedIndex: controller.currentPageIndex,
                      extended: constraints.maxWidth >= 1200,
                      onDestinationSelected: controller.setCurrentPageIndex,
                      backgroundColor:
                          materialTheme.colorScheme.onInverseSurface,
                      leading: Container(
                        height: 50.0,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Row(
                          children: [
                            Icon(Icons.star_border_purple500_rounded),
                          ],
                        ),
                      ),
                      destinations: const <NavigationRailDestination>[
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.collections_bookmark),
                          label: Text('Library'),
                        ),
                      ],
                    ),
                  ),
                ),
                // const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: IndexedStack(
                    index: controller.currentPageIndex,
                    children: controller.pages,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
