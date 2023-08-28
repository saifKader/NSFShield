import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nsfsheild/logic/cubits/user/user_state.dart';
import '../../../data/models/user/user_model.dart';
import '../../../data/repositories/user_repository.dart';

class UserCubit extends HydratedCubit<UserState> {
  final userRepository = UserRepository();

  UserCubit() : super(UserInitial()) {
    //
  }
  Future<void> refreshUserData() async {
    try {
      final currentState = state;

      if (currentState is UserAuthenticated) {
        final refreshResponse = await userRepository.refreshToken(currentState.refreshToken);

        final newAccessToken = refreshResponse['access_token'];
        final newUserJson = refreshResponse['user']; // Assuming the user data is in 'user' key

        // Parse the user JSON to a User object
        final User newUser = User.fromJson(newUserJson);

        // Create a new UserAuthenticated state with updated access token and user data
        final newUserState = currentState.copyWith(
          accessToken: newAccessToken,
          user: newUser,
          refreshToken: currentState.refreshToken,
        );
        emit(newUserState);
      }
    } catch (e) {
      print('Error refreshing user data: $e');
      // Handle error, emit an error state or take other appropriate actions
    }
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
      print('Login successful');
    } catch (e) {
      print('Error during login: $e');
      emit(UserError('An error occurred'));
    }
  }

  Future<void> logoutUser(String token) async {
    try {
      final currentState = state;

      if (currentState is UserAuthenticated) {
        // Call the logout API to invalidate the user's tokens
        await userRepository.logout(token);

        // Transition to the unauthenticated state
        emit(UserUnauthenticated());

        print('Logout successful');
      }
    } catch (e) {
      print('Error during logout: $e');
      // Handle error, emit an error state or take other appropriate actions
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
