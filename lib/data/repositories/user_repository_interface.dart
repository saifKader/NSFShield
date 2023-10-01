import 'dart:io';

abstract class IUserRepository {
  Future<dynamic> login(String username, String password);
  Future<dynamic> issueCheckRepo(String accountNumber, double amount, String pin, String checkNumber);
  Future<dynamic> refreshToken(String refreshToken);
  Future<dynamic> sendVerificationPin(String accountNumber);
  Future<dynamic> logout(String token);
}
