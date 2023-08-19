import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nsfsheild/logic/cubits/user/user_state.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

class UserCubit extends HydratedCubit<UserState> {
  final userRepository = UserRepository();

  UserCubit() : super(UserInitial()) {
    //
  }
  String? getRefreshToken() {
    if (state is UserAuthenticated) {
      return (state as UserAuthenticated).refreshToken;
    }
    return null;
  }

  Future<void> loginUser(String username, String password) async {
    emit(UserLoading());
    try {
      final response = await userRepository.login(username, password);
      final User user = User.fromJson(response['user']);
      emit(UserAuthenticated(
          user: user,
          accessToken: response['access_token'],
          refreshToken: response['refresh_token']
      ));
    } catch (e) {
      emit(UserError('An error occurred'));
    }
  }

  Future<void> refreshToken(String token) async {
    emit(UserLoading());
    try {
      final newAccessToken = await userRepository.refreshToken(token);
      if (state is UserAuthenticated) {
        final currentUser = (state as UserAuthenticated).user; // Retrieve current user data from state
        emit(UserAuthenticated(
            user: currentUser,
            accessToken: newAccessToken,
            refreshToken: token
        ));
      } else {
        // Handle scenarios where the current state isn't UserAuthenticated
        emit(UserError('Unable to refresh token without existing user data.'));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'authenticated') {
      return UserAuthenticated.fromJson(json);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toJson() ?? {};
  }
}
