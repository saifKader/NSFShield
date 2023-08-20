
import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];

  Map<String, dynamic>? toJson();
  static UserState? fromJson(Map<String, dynamic> json) {
    return null;
  }
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() {
    return null;
  }
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() {
    return null;
  }
}

class UserAuthenticated extends UserState {
  final User user;
  final String accessToken;
  final String refreshToken;

  UserAuthenticated({required this.user, required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [user, accessToken, refreshToken];

  @override
  Map<String, dynamic> toJson() => {
    'type': 'authenticated',
    'user': user.toJson(),
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  static UserAuthenticated fromJson(Map<String, dynamic> json) {
    return UserAuthenticated(
      user: User.fromJson(json['user']),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  UserAuthenticated copyWith({User? user, String? accessToken, String? refreshToken}) {
    return UserAuthenticated(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}


class UserUnauthenticated extends UserState {
  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() {
    return null;
  }
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  Map<String, dynamic>? toJson() {
    return null;
  }
}
