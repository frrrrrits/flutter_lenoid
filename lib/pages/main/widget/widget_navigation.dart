import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main_controller.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    MainController controller = Get.put(MainController());
    return Obx(
      () => NavigationBar(
        elevation: 0.6,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: controller.currentPageIndex,
        onDestinationSelected: controller.setCurrentPageIndex,
        backgroundColor: materialTheme.colorScheme.surface,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.collections_bookmark),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}

class RailNavigationWidget extends StatelessWidget {
  const RailNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    MainController controller = Get.put(MainController());
    return Obx(
      () => NavigationRail(
        selectedIndex: controller.currentPageIndex,
        onDestinationSelected: controller.setCurrentPageIndex,
        backgroundColor: materialTheme.colorScheme.onInverseSurface,
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
    );
  }
}
