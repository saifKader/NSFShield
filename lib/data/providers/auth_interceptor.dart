import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AuthInterceptor implements Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await HydratedBloc.storage.read('auth-token');
    final authToken = prefs?.toString();

    if (authToken != null) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // navigate to the authentication screen
      final newException = DioException(
        requestOptions: err.requestOptions,
        error: 'The user has been deleted or the session is expired',
      );
      return handler.reject(newException);
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ... Your response handling logic
  }
}