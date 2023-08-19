import 'package:freezed_annotation/freezed_annotation.dart';

import 'account_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,
    // Removing password as it's not good practice to store or manage passwords on the frontend
   List<Account>? accounts, // Assuming you'd have a similar model for Account
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
