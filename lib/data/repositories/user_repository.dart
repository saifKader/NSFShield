import 'dart:io';
import 'package:nsfsheild/data/repositories/user_repository_interface.dart';

import '../providers/user_data_provider.dart';

class UserRepository implements IUserRepository {
  final UserDataProvider _userDataProvider = UserDataProvider();


  @override
  Future<dynamic> extractAccountNumber(File image) async {
    try {
      final response = await _userDataProvider.extractAccountNumber(image);
      if (response.statusCode == 200) {
        print('here ${response.data}');
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error extracting account numbeazeazeazer: $e');
      return Future.error(e.toString());
    }
  }

  Future<dynamic> sendImageAndAmount(String accountNumber, double amount, token) async {
    try {
      final response = await _userDataProvider.issueCheck(accountNumber, amount,token);
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
        print('the api response ${response.data}');
        return response.data;
      } else {
        // Handle non-200 status codes as per your requirements
        return Future.error(response.data['msg'] ?? 'Error logging in.');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
  /*@override
  Future<dynamic> login(String username, String password) async {
    try {
        final response = await _userDataProvider.login(username, password);
        return response.statusCode == 200
            ? response.data
            : Future.error(response.data['msg'] ?? 'Error logging in.');
    } catch (e) {
      return Future.error(e.toString());
    }
  }*/

  @override
  Future<dynamic> refreshToken(String token) async {
    try {
      final response = await _userDataProvider.refreshToken(token);
      if (response.statusCode == 200) {
        return response.data['access_token'];
      } else {
        return Future.error(response.data['msg'] ?? 'Error refreshing token.');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
