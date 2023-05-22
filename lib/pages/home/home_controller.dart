import 'dart:async';

import 'package:lenoid/data/controller/paging_controller.dart';
import 'package:lenoid/model/latest_update.dart';
import 'package:lenoid/repository/api_repository.dart';

class HomeController extends BasePagingController<LatestUpdate> {
  late final _apiRepository = ApiRepository();

  @override
  void onInit() async {
    await loadData();
    super.onInit();
  }

  @override
  Future<List<LatestUpdate>> fetchData(int page) async {
    var response = await _apiRepository.getLatestUpdate(page: page);
    return response;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
