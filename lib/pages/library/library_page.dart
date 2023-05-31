import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:lenoid/utils/logger/log.dart';
import 'package:lenoid/widgets/status/empty_widget.dart';
import 'package:lenoid/widgets/toast.dart';
import 'library_controller.dart';

class LibraryPage extends GetView<LibraryController> {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: EmptyWidget(
          message: "Page under WIP",
          actions: [
            EmptyWidgetButton(
                text: "Clear Image Cache",
                icon: const Icon(Icons.refresh),
                actions: () {
                  clearCache();
                  context.showSnackBar("Image Cache Deleted");
                }),
          ],
        ),
      ),
    );
  }

  void clearCache() async {
    await DefaultCacheManager().emptyCache();
    PaintingBinding.instance.imageCache.clear();
    try {
      await JsonCacheInfoRepository(databaseName: "lendoid_image_cache")
          .deleteDataFile();
    } catch (e, s) {
      Log.e("clearCache", s);
    }
    imageCache.clear();
    imageCache.clearLiveImages();
  }
}
