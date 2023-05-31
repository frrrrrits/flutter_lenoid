import 'package:get/get.dart';
import 'package:lenoid/data/controller/base_controller.dart';
import 'package:lenoid/model/detail_model.dart';
import 'package:lenoid/repository/api_repository.dart';
import 'package:lenoid/utils/logger/log.dart';

class DetailsScreenController extends BaseController {
  final String url;
  final _apiRepository = ApiRepository();
  final Rx<DetailModel?> _detailModel = Rx<DetailModel?>(null);
  DetailsScreenController(this.url);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      pagingLoading.value = true;
      pagingError.value = false;
      await _apiRepository.getDetailUrl(url: url).then((value) async {
        if (value != null) {
          var response = await _apiRepository.getDetail(url: value);
          _detailModel.value = response;
        } else {
          Log.w("[fetchData] error");
        }
      });
    } catch (e) {
      pagingError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pagingLoading.value = false;
    }
  }

  DetailModel? get detailModel => _detailModel.value;
  List<Episodes>? get episodeModel => _detailModel.value?.episodes;
  List<Genres>? get genreModel => _detailModel.value?.genre;
  int get episodeLength => episodeModel?.length ?? 0;
}
