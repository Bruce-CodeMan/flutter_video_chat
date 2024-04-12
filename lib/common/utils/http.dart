// Import the core libraries
import 'dart:io';

// Import the libraries from the external
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide FormData;

// Import the custom values
import 'package:flutter_video_chat/common/values/values.dart';
import 'package:flutter_video_chat/common/utils/utils.dart';
import 'package:flutter_video_chat/common/entities/entities.dart';
import 'package:flutter_video_chat/common/store/store.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  late Dio dio;
  factory HttpUtil() => _instance;

  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      // 请求的基地址
      baseUrl: serverApiUrl,

      // 单位是毫秒
      connectTimeout: 30000,

      // 响应流上前后两次接受到的数据的间隔，单位为毫秒
      receiveTimeout: 20000,

      // Http请求头
      headers: {},

      // 请求的Content-Type, 默认使用的就是"application/json; charset=utf-8"
      // contentType: Headers.formUrlEncodedContentType
      // 如果想以"application/x-www-form-urlencoded"格式编码请求数据，如上设置
      contentType: 'application/json;charset=utf-8',

      /// [responseType] 表示期望以哪种方式接受响应数据
      /// 目前有四种类型 `json`, `stream`, `plain`, `bytes`
      responseType: ResponseType.json
    );

    dio = Dio(options);

    // 忽略HTTPS证书验证，从而允许与自签名或有问题的SSL证书的服务器进行通信
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client){
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    
    // Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    // add the interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before the request is sent
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        // Do something with response error
        Loading.dismiss();
        ErrorEntity errorInfo = createErrorEntity(e);
        onError(errorInfo);
        return handler.next(e);
      }
    ));
  }

  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch(error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "request to cancel");
      case DioErrorType.connectTimeout:
        return ErrorEntity(code: -1, message: "Connection timed out");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: "Request timed out");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: "Response timed out");
      case DioErrorType.response: {
        {
          try {
            int errCode = error.response != null ? error.response!.statusCode! : -1;
            switch(errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "Request syntax error");
              case 401:
                return ErrorEntity(code: errCode, message: "Permission denied");
              case 403:
                return ErrorEntity(code: errCode, message: "The server refuses to execute");
              case 404:
                return ErrorEntity(code: errCode, message: "Can not connect to the server");
              case 405:
                return ErrorEntity(code: errCode, message: "Request method is forbidden");
              case 500:
                return ErrorEntity(code: errCode, message: "Internal server error");
              case 502:
                return ErrorEntity(code: errCode, message: "Invalid request");
              case 503:
                return ErrorEntity(code: errCode, message: "Server down");
              case 505:
                return ErrorEntity(code: errCode, message: "Does not support HTTP protocol request");
              default:
                return ErrorEntity(code: errCode, message: error.response != null ? error.response!.statusMessage! : "");
            }
          }on Exception catch(_) {
            return ErrorEntity(code: -1, message: "unknown mistake");
          }
        }
      }
      default:
        return ErrorEntity(code: -1, message: error.message);

    }
  }

  /*
   * 统一错误处理
   */
  void onError(ErrorEntity errorInfo) {
    switch(errorInfo.code) {
      case 401:
        UserStore.to.onLogout();
        EasyLoading.showError(errorInfo.message);
        break;
      default:
        break;
    }
  }

  /*
   * 取消请求
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// read the local configuration
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    if(Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
      headers['Authorization'] = 'Bearer ${UserStore.to.token}';
    }
    return headers;
  }

  /// Get the headers
  Options _configureOptions(Options? options) {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if(authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    return requestOptions;
  }


  /// restful get operation
  Future get(
    String path,{
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = !cacheEnable,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false
  }) async{
    Options requestOptions = _configureOptions(options);
    requestOptions.extra ??= <String, dynamic> {};
    requestOptions.extra!.addAll({
      'refresh': refresh,
      'noCache': noCache,
      'list': list,
      'cacheKey': cacheKey,
      'cacheDisk': cacheDisk
    });
    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken
    );

    return response.data;
  }

  // restful post operation
  Future post(
    String path,{
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options
  }) async {
    Options requestOptions = _configureOptions(options);
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken
    );
    return response.data;
  }

  /// restful put operation
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options
  }) async {
    Options requestOptions = _configureOptions(options);
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken
    );
    return response.data;
  }

  /// restful patch operation
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options
  }) async{
    Options requestOptions = _configureOptions(options);
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken
    );
    return response.data;
  }

  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options
  }) async {
    Options requestOptions = _configureOptions(options);
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken
    );
    return response.data;
  }

  Future postForm(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options
  }) async {
    Options requestOptions = _configureOptions(options);
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken
    );
    return response.data;
  }

  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options
  }) async{
    Options requestOptions = _configureOptions(options);
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken
    );
    return response.data;
  }
}