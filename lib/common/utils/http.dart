// Import the libraries from the external
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

// Import the custom values
import 'package:flutter_video_chat/common/values/values.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  late Dio dio;
  factory HttpUtil() => _instance;

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
        
      }
    ));
  }
}