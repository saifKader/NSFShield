import 'package:dio/dio.dart';
import 'package:nsfsheild/utils/constants.dart';

class UserDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = const Duration(milliseconds: 5000)
    ..options.receiveTimeout = const Duration(milliseconds: 3000);


  Future<Response> getCheckTransactions(String token) async {
    try {
      final response = await dio.get(
        checkTransactionsEndpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      print('Error getting check transactions: $e');
      throw e;
    }
  }

  Future<Response> issueCheck(String accountNumber, double amount) async {
    try {
      FormData formData = FormData.fromMap({
        'account_number': accountNumber,
        'amount': amount.toString(),
      });
      final response = await dio.post(
        '/issue_check',
        data: formData,
      );
      return response;
    } catch (e) {
      print('Error sending image and amount: $e');
      throw e;
    }
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
      refreshEndpoint,
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