import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail_controller.dart';
import 'screen/details/details_screen.dart';
import 'screen/download/download_screen.dart';

class DetailPage extends StatelessWidget {
  final String url;
  final String title;
  final DetailController controller;
  DetailPage(this.url, this.title, {Key? key})
      : controller = Get.put(DetailController(url: url)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(title),
              bottom: TabBar(
                tabs: [
                  const Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download_for_offline_outlined, size: 17),
                        SizedBox(width: 8),
                        Text('Unduh'),
                      ],
                    ),
                  ),
                  const Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline_rounded, size: 17),
                        SizedBox(width: 8),
                        Text('Informasi'),
                      ],
                    ),
                  ),
                ],
                controller: controller.tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children: [
            const DownloadScreen(),
            DetailsScreen(),
          ],
        ),
      ),
    );
  }
}
