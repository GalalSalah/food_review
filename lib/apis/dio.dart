
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_review/apis/url_apis.dart';

class DioHelpers {
  static  Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        receiveDataWhenStatusError: true,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
  }
  static Future<Response>getData({@required String url,Map<String,dynamic>query})async{
    return await dio.get(url,queryParameters: query);
  }
  static Future<Response> reviewById({String id,String name,String review})async{
     dio.interceptors.add(LogInterceptor(requestBody: true));
    return await dio.post(Urls.restraurantReview,data: {'id':id,'name':name,'review':review});

  }
}
