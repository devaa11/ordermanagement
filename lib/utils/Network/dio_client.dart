import 'package:dio/dio.dart';

class ApiClient{

 static final Dio dio=Dio(

    BaseOptions(
      baseUrl: 'https://6953cf8aa319a928023cbbf7.mockapi.io/api/',
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json'
      }
    )
  );
}