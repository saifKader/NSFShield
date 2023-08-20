import '../../logic/cubits/user/user_cubit.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  late UserCubit _userCubit;

  factory ServiceLocator() {
    return _instance;
  }

  ServiceLocator._internal();

  void initialize({required UserCubit userCubit}) {
    _userCubit = userCubit;
  }

  UserCubit get userCubit => _userCubit;
}
