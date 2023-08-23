import 'dart:io';

abstract class IUserRepository {
  Future<dynamic> extractAccountNumber(File image);
  Future<dynamic> login(String username, String password);
  Future<dynamic> sendImageAndAmount(String accountNumber, double amount);
  Future<dynamic> refreshToken(String refreshToken);
}
