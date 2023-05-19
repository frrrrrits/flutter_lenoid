import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:html/parser.dart';
import 'package:lenoid/utils/logger/log.dart';
import 'code_error.dart';

class HttpClient {
  static HttpClient? _instance;

  static HttpClient get instance {
    _instance ??= HttpClient();
    return _instance!;
  }

  late Dio dio;

  HttpClient({BaseOptions? options}) {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 5),
      ),
    );

    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        retries: 4,
      ),
    );
  }

  Future<dynamic> requests(String url) async {
    try {
      var response = await dio.get(url);
      var document = parse(response.data);
      Log.i("[STATUS CODE] " + response.statusCode.toString());
      return document;
    } on DioError catch (e) {
      Log.e(e.message ?? 'Failed to send Request', e.stackTrace);
      throw CodeError(e.message ?? 'Failed to send Request',
          statusCode: e.response?.statusCode ?? 0);
    }
  }

  Future<dynamic> get(String url) async {
    try {
      var response = await dio.get(url);
      return response.data;
    } on DioError catch (e) {
      Log.e(e.message ?? 'Failed to send Request', e.stackTrace);
    }
  }
}
