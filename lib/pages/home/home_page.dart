import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/widgets/compact_item.dart';
import 'package:lenoid/widgets/keep_alive_wrapper.dart';
import 'package:lenoid/widgets/paging_grid_view.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      body: KeepAliveWrapper(
        child: Obx(
          () => PagingGridView(
            minSpacing: 8,
            refreshOnStart: false,
            pagination: controller,
            desiredItemWidth: 200,
            showPagingLoading: true,
            rowMainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(controller.list.length, (i) {
              var item = controller.list[i];
              return CompactItem(item, i);
            }),
          ),
        ),
      ),
    );
  }
}
