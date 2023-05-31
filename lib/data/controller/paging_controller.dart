import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lenoid/data/controller/base_controller.dart';

class BasePagingController<T> extends BaseController {
  final ScrollController scrollController = ScrollController();
  final EasyRefreshController easyRefreshController = EasyRefreshController();

  int currentPage = 1;
  var isLoadMore = false.obs;
  var list = <T>[].obs;

  Future refreshData() async {
    currentPage = 1;
    list.value = [];
    await loadData();
  }

  Future loadData() async {
    try {
      if (isLoading) return;
      isLoading = true;
      pagingError.value = false;
      pagingEmpty.value = false;
      pagingLoading.value = currentPage == 1;

      var result = await fetchData(currentPage);
      // if is not empty then load more
      if (result.isNotEmpty) {
        currentPage++;
        isLoadMore.value = true;
        pagingEmpty.value = false;
      } else {
        isLoadMore.value = false;
        if (currentPage == 1) {
          pagingEmpty.value = true;
        }
      }
      // insert data to list
      if (currentPage == 1) {
        list.value = result;
      } else {
        list.addAll(result);
      }
    } catch (e) {
      handleError(e, showPagingError: currentPage == 1);
    } finally {
      isLoading = false;
      pagingLoading.value = false;
    }
  }

  Future<List<T>> fetchData(int page) async {
    return [];
  }

  void scrollToTopOrRefresh() {
    if (scrollController.offset > 0) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    } else {
      easyRefreshController.callRefresh();
    }
  }
}
