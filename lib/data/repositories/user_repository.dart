import 'dart:io';
import 'package:hydrated_bloc/hydrated_bloc.dart';
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
      print('Calling login API');
      final response = await _userDataProvider.login(username, password);
      print('Login API response: $response');
      if (response.statusCode == 200) {
        print('Login successful');
        return response.data;
      } else {
        print('Login failed');
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
