import 'dart:io';

abstract class IUserRepository {
  Future<dynamic> extractAccountNumber(File image);
  Future<dynamic> login(String username, String password);
  Future<dynamic> refreshToken(String token);
  Future<dynamic> sendImageAndAmount(String accountNumber, double amount, String token);
}
