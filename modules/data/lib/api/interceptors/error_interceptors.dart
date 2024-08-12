import 'package:dio/dio.dart';


final class ErrorsInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {

    return handler.next(err);
  }
}