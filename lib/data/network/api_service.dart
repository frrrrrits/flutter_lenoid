import 'dart:async';

import 'package:lenoid/model/detail_model.dart';

import '../../model/latest_update.dart';

abstract class ApiService {
  Future<List<LatestUpdate>> getLatestUpdate({int page = 1}) {
    return Future.value(<LatestUpdate>[]);
  }

  Future<String> getDetailUrl({required String url});
  Future<DetailModel> getDetail({required String url});
}
