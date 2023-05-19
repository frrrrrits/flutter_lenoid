import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:lenoid/widgets/status/empty_widget.dart';
import 'library_controller.dart';

class LibraryPage extends GetView<LibraryController> {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: EmptyWidget(
          message: "Gagal Memuat Data",
          actions: [
            EmptyWidgetButton(
              text: "Button 1",
              icon: const Icon(Icons.refresh),
              actions: () => Get.snackbar('Helllo', 'from EmptyWidget',
                  snackPosition: SnackPosition.TOP,
                  margin: const EdgeInsets.all(30),
                  colorText: Theme.of(context).colorScheme.surface,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withAlpha(179)),
            ),
            EmptyWidgetButton(
                text: "Button 2",
                icon: const Icon(Icons.refresh),
                actions: () {
                  DefaultCacheManager().emptyCache();
                }),
          ],
        ),
      ),
    );
  }
}
