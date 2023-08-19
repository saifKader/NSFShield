import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/account_model.dart';
import '../../../data/repositories/user_repository.dart';
import 'check_state.dart';

class CheckCubit extends Cubit<CheckState> {

  CheckCubit() : super(CheckInitial());

  final userRepository = UserRepository();

  void resetCheckState() {
    emit(CheckInitial());
  }
  Future<String> extractAccountNumber(File image) async {
    emit(CheckLoadInProgress()); // Update the state to indicate loading
    try {
      final response = await userRepository.extractAccountNumber(image);
      print('the api response $response');
      emit(CheckSuccess(response));
      return response;
    } catch (e) {
      emit(CheckIsFailure(e.toString()));
      return e.toString();
    }
  }

  Future<void> sendImageAndAmountToBackend(String accountNumber, double amount, token) async {
    emit(CheckLoadInProgress()); // Update the state to indicate loading
    try {
      final response = await userRepository.sendImageAndAmount(accountNumber, amount, token);


      print(response['msg']);
      emit(CheckSuccess(response['msg']));
    } catch (e) {
      print('the api response ${e.toString()}');
      emit(CheckIsFailure(e.toString()));
    }
  }

}
