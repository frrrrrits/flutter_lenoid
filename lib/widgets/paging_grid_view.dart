import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/data/controller/paging_controller.dart';
import 'package:lenoid/utils/behavior/custom_behavior.dart';
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
  final String headerText;
  final List<Widget> children;

  const PagingGridView({
    required this.pagination,
    required this.children,
    required this.headerText,
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
    final _widthSize = MediaQuery.of(context).size.width > 700;
    return Obx(
      () => Stack(
        children: [
          EasyRefresh(
            header: const MaterialHeader(
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
              child: Column(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Text(
                      headerText,
                      style: _widthSize
                          ? Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface)
                          : Theme.of(context).textTheme.titleLarge,
                    )),
                ResponsiveGridList(
                  scroll: false,
                  shrinkWrap: true,
                  minSpacing: minSpacing,
                  controller: pagination.scrollController,
                  desiredItemWidth: desiredItemWidth,
                  rowMainAxisAlignment: rowMainAxisAlignment,
                  children: children,
                ),
              ]),
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
