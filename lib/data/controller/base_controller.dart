import 'package:get/get.dart';
import 'package:lenoid/utils/logger/log.dart';

class BaseController extends GetxController {
  var isLoading = false;
  var pagingLoading = false.obs;
  var pagingEmpty = false.obs;
  var pagingError = false.obs;
  var errorMsg = "".obs;
  Error? error;

  void handleError(Object exception, {bool showPagingError = false}) {
    Log.e(exception.toString(), StackTrace.current);
    var message = errorToString(exception);
    if (exception is Error) {
      error = exception;
    }
    if (showPagingError) {
      pagingError.value = true;
      errorMsg.value = message;
    } else {
      Get.snackbar('Failed', message);
    }
  }

  String errorToString(Object exception) {
    return exception.toString().replaceAll("Exception:", "");
  }
}
