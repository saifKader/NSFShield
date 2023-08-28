import 'dart:io';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nsfsheild/data/repositories/user_repository_interface.dart';

import '../models/check_transaction_model.dart';
import '../providers/check_data_provider.dart';
import '../providers/user_data_provider.dart';

class UserRepository implements IUserRepository {
  final UserDataProvider _userDataProvider = UserDataProvider();
  final CheckDataProvider _checkDataProvider = CheckDataProvider();

  @override
  Future<dynamic> sendVerificationPin(String accountNumber) async {
    try {
      final response = await _userDataProvider.sendPinSms(accountNumber);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data['message'] ?? 'Error sending verification PIN.';
      }
    } catch (error) {
      // Handle DioException here
      print('DioException occurred: $error');
      return 'An error occurred while sending the verification PIN.';
    }
  }

  Future<List<CheckTransaction>> getCheckTransactions(String token) async {
    try {
      final response = await _userDataProvider.getCheckTransactions(token);
      if (response.statusCode == 200) {
        final List<dynamic>? transactionList =
            response.data; // Use nullable type
        if (transactionList != null) {
          // Check for null before proceeding
          final List<CheckTransaction> transactions = transactionList
              .map((transactionJson) =>
                  CheckTransaction.fromJson(transactionJson))
              .toList();
          print(transactionList);
          print(transactions);
          return transactions;
        } else {
          print('Transaction data is null');
          return [];
        }
      } else {
        print('Response status code is not 200');
        return [];
      }
    } catch (e) {
      print('Error getting check transactions: $e');
      return Future.error(e.toString());
    }
  }

  @override
  Future<dynamic> extractAccountNumber(File image) async {
    try {
      final response = await _checkDataProvider.extractAccountNumber(image);

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 210) {
        return response.data['error'] ?? 'Error extracting account number.';
      } else {
        return response.data['msg'] ?? 'Error extracting account number.';
      }
    } catch (error) {
      // Handle DioException here
      print('DioException occurred: $error');
      return 'An error occurred while making the request.';
    }
  }

  @override
  Future<dynamic> sendImageAndAmount(
      String accountNumber, double amount, String pin) async {
    try {
      final response =
          await _userDataProvider.issueCheck(accountNumber, amount, pin);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data['msg'] ?? 'Error sending image and amount.';
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<dynamic> login(String username, String password) async {
    try {
      final response = await _userDataProvider.login(username, password);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return Future.error(response.data['msg'] ?? 'Error logging in.');
      }
    } catch (e) {
      print('Exception during login: $e');
      return Future.error(e.toString());
    }
  }

  @override
  Future<dynamic> refreshToken(String refreshToken) async {
    try {
      final response = await _userDataProvider.refreshToken(refreshToken);
      if (response.statusCode == 200) {
        final newAccessToken = response.data['access_token'];
        final newUser = response.data['user'];
        // Update the access token in the dio instance directly
        _userDataProvider.dio.options.headers['Authorization'] =
            'Bearer $newAccessToken';

        // Save the new access token to local storage
        await HydratedBloc.storage.write('auth-token', newAccessToken);

        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<dynamic> logout(String token) async {
    try {
      final response = await _userDataProvider.logout(token);
      if (response.statusCode == 200) {
        // Clear the access token from Dio instance headers
        _userDataProvider.dio.options.headers.remove('Authorization');

        // Clear the access token from local storage
        await HydratedBloc.storage.delete('auth-token');

        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
