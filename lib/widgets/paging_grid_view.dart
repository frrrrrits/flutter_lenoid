import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/data/controller/base_controller.dart';
import 'package:lenoid/widgets/status/empty_widget.dart';
import 'package:lenoid/widgets/status/loading_widget.dart';
import 'package:responsive_grid/responsive_grid.dart';

class PagingGridView extends StatelessWidget {
  final BasePagingController pagination;
  final MainAxisAlignment rowMainAxisAlignment;
  final double minSpacing, desiredItemWidth;
  final EdgeInsets? padding;
  final bool refreshOnStart;
  final bool showPagingLoading;
  final bool scrollAble;
  final List<Widget> children;

  const PagingGridView({
    required this.pagination,
    required this.children,
    this.showPagingLoading = false,
    this.refreshOnStart = false,
    this.minSpacing = 5,
    this.scrollAble = true,
    this.desiredItemWidth = 200,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          EasyRefresh(
            header: const ClassicHeader(
              processedDuration: Duration(milliseconds: 400),
            ),
            footer: const ClassicFooter(
              processedDuration: Duration(milliseconds: 400),
            ),
            scrollController: pagination.scrollController,
            controller: pagination.easyRefreshController,
            refreshOnStart: refreshOnStart,
            onLoad: pagination.loadData,
            onRefresh: pagination.refreshData,
            scrollBehaviorBuilder: (physic) {
              return CustomScrollBehavior(physic);
            },
            child: SingleChildScrollView(
              controller: pagination.scrollController,
              child: ResponsiveGridList(
                scroll: false,
                minSpacing: minSpacing,
                controller: pagination.scrollController,
                desiredItemWidth: desiredItemWidth,
                rowMainAxisAlignment: rowMainAxisAlignment,
                children: children,
              ),
            ),

            /* MasonryGridView.count(
              padding: padding,
              itemCount: pagination.list.length,
              itemBuilder: itemBuilder,
              crossAxisCount: desiredItemWidth,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              ), */
          ),
          Offstage(
            offstage: !pagination.pagingEmpty.value,
            child: EmptyWidget(
              message: "Gagal Memuat Data",
              actions: [
                EmptyWidgetButton(
                  text: "Refresh",
                  icon: const Icon(Icons.refresh),
                  actions: () => pagination.refreshData(),
                )
              ],
            ),
          ),
          Offstage(
            offstage: !(showPagingLoading && pagination.pagingLoading.value),
            child: const LoadingWidget(),
          ),
          Offstage(
            offstage: !pagination.pagingError.value,
            child: EmptyWidget(
              message: pagination.errorMsg.value,
              actions: [
                EmptyWidgetButton(
                  text: "Refresh",
                  icon: const Icon(Icons.refresh),
                  actions: () => pagination.refreshData(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  final ScrollPhysics? _physics;

  const CustomScrollBehavior([this._physics]);

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return _physics ?? super.getScrollPhysics(context);
  }

  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
        // add a trackpad
        PointerDeviceKind.trackpad,
      };
}
