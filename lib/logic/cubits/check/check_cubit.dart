import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/providers/check_data_provider.dart';
import '../../../data/repositories/user_repository.dart';
import 'check_state.dart';

class CheckCubit extends Cubit<CheckState> {

  CheckCubit() : super(CheckInitial());
  final CheckDataProvider _checkDataProvider = CheckDataProvider();
  final userRepository = UserRepository();

  void resetCheckState() {
    emit(CheckInitial());
  }
  //sendVerificationPin
  Future<void> sendVerificationPin(String accountNumber) async {
    try {
      final response = await userRepository.sendVerificationPin(accountNumber);
      final data = response.data;
      if (response.statusCode == 200) {
        print('the api response ${data['message']}');
      } else {
        emit(CheckIsFailure(data['error'] ?? 'Error sending verification PIN.'));
      }
    } catch (e) {
      emit(CheckIsFailure(e.toString()));
    }
  }
  Future<String> extractAccountNumber(File image) async {
    emit(CheckLoadInProgress()); // Update the state to indicate loading
    try {
      final response = await _checkDataProvider.extractAccountNumber(image);
      final data = response.data;
      if (response.statusCode == 200) {
        print('the api response $data');
        emit(CheckSuccess(data));
        return data;
      }else if (response.statusCode == 210){
        emit(CheckIsFailure(data['error'] ?? 'Error extracting account number.'));
        return data['error'] ?? 'Error extracting account number.';
      }
      else {
        emit(CheckIsFailure(data['error'] ?? 'Error extracting account number.'));
        return data['error'] ?? 'Error extracting account number.';
      }
    } catch (e) {
      emit(CheckIsFailure(e.toString()));
      return e.toString();
    }
  }

  Future<void> sendImageAndAmountToBackend(String accountNumber, double amount, String pin) async {
    emit(CheckLoadInProgress()); // Update the state to indicate loading
    try {
      final response = await userRepository.sendImageAndAmount(accountNumber, amount, pin);


      print(response['msg']);
      emit(CheckSuccess(response['msg']));
    } catch (e) {
      print('the api response ${e.toString()}');
      emit(CheckIsFailure(e.toString()));
    }
  }

}
