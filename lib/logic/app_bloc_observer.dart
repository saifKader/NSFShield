import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase cubit) {
    super.onCreate(cubit);
    developer.log(cubit.state.toString(), name: 'onCreate');
  }

  @override
  void onChange(BlocBase cubit, Change change) {
    super.onChange(cubit, change);
    developer.log(change.toString(), name: 'onChange');
  }

  @override
  void onClose(BlocBase cubit) {
    super.onClose(cubit);
    developer.log(cubit.toString(), name: 'onClose');
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    developer.log(cubit.toString(), name: 'onError');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    developer.log(bloc.toString(), name: 'onEvent');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    developer.log(bloc.toString(), name: 'onTransition');
  }
}
