import '../../model/latest_update.dart';

class ApiService {
  Future<List<LatestUpdate>> getLatestUpdate({int page = 1}) {
    return Future.value(<LatestUpdate>[]);
  }
}
