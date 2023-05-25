import 'package:get/get.dart';
import 'package:lenoid/model/detail_model.dart';
import 'package:lenoid/utils/logger/log.dart';

class DetailsScreenController extends GetxController {
  List<Genres> listGenre = <Genres>[].obs;

  @override
  void onInit() {
    Log.i("Hello From Details Controller");
    // test
    listGenre.addAll([
      Genres('Fantasy'),
      Genres('Drama'),
      Genres('School'),
    ]);
    super.onInit();
  }
}
