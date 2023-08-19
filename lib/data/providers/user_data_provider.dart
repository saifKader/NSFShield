import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nsfsheild/utils/constants.dart';

import '../../logic/cubits/user/user_cubit.dart';

class UserDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = const Duration(milliseconds: 5000)
    ..options.receiveTimeout = const Duration(milliseconds: 3000);

  Future<Response> extractAccountNumber(File image) async {
    try {
      FormData formData = FormData.fromMap({
        'check_image': await MultipartFile.fromFile(image.path),
      });

      final response = await dio.patch(
        '/extract_account_number',
        data: formData,
      );
      return response;
    } catch (e) {
      print('Error extracting account number: $e');
      throw e;
    }
  }

  Future<Response> issueCheck(String accountNumber, double amount, String token) async {
    try {
      FormData formData = FormData.fromMap({
        'account_number': accountNumber,
        'amount': amount.toString(),
      });
print(token);
      final response = await dio.post(
        '/issue_check',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      print('Error sending image and amount: $e');
      throw e;
    }
  }

  void _addInterceptors(UserCubit userCubit) {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          // Detected token expiration

          // Retrieve the refresh token
          String? _refreshToken = userCubit.getRefreshToken(); // Fetch this from your state management solution or storage

          if (_refreshToken != null) {
            try {
              // Call the refreshToken method
              final response = await refreshToken(_refreshToken);
              final newAccessToken = response.data['access_token'];

              // Update your state/BLoC/Cubit with the new access token
              // Here you might want to emit a new state with the updated token

              // Retry the failed request with the new token
              RequestOptions options = error.response!.requestOptions;
              Options newOptions = Options(
                method: options.method,
                headers: {
                  'Authorization': 'Bearer $newAccessToken',
                },
                validateStatus: (status) {
                  return status! < 500;
                },
              );
              final newResponse = await dio.request(options.path, options: newOptions);
              handler.resolve(newResponse);
            } catch (e) {
              handler.reject(error);
            }
          } else {
            handler.reject(error);
          }
        } else {
          handler.reject(error);
        }
      },
    ));
  }





  Future<Response> login(String username, String password) async {
    return await dio.request(
      '/login',
      data: {'username': username, 'password': password},
      options: Options(
        method: 'POST',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  Future<Response> refreshToken(String token) async {
    return await dio.request(
      '/refresh',
      options: Options(
        method: 'POST',
        headers: {
          'Authorization': 'Bearer $token',
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }
}
