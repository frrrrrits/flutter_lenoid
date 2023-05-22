import '../../model/latest_update.dart';

abstract class ApiService {
  Future<List<LatestUpdate>> getLatestUpdate({int page = 1}) {
    return Future.value(<LatestUpdate>[]);
  }
}
