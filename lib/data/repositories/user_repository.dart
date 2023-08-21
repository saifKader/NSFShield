import 'dart:io';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nsfsheild/data/repositories/user_repository_interface.dart';

import '../models/check_transaction_model.dart';
import '../providers/user_data_provider.dart';

class UserRepository implements IUserRepository {
  final UserDataProvider _userDataProvider = UserDataProvider();


  Future<List<CheckTransaction>> getCheckTransactions(String token) async {
    try {
      final response = await _userDataProvider.getCheckTransactions(token);
      if (response.statusCode == 200) {
        final List<dynamic>? transactionList = response.data;  // Use nullable type
        if (transactionList != null) {  // Check for null before proceeding
          print('hi here 2 ${response.data}');
          final List<CheckTransaction> transactions = transactionList
              .map((transactionJson) =>
              CheckTransaction.fromJson(transactionJson))
              .toList();
          print('hi here 3');
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
      final response = await _userDataProvider.extractAccountNumber(image);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error extracting account numbeazeazeazer: $e');
      return Future.error(e.toString());
    }
  }

  Future<dynamic> sendImageAndAmount(String accountNumber, double amount, String token) async {
    try {
      final response = await _userDataProvider.issueCheck(accountNumber, amount, token);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
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
        _userDataProvider.dio.options.headers['Authorization'] = 'Bearer $newAccessToken';

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



}
