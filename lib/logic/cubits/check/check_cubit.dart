import 'dart:convert';
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
      final data = response;
        print("jawek behi 2 $accountNumber");
        print('the api response ${data['message']}');

    } catch (e) {
      print('the api response mta3 jawek behi ${e.toString()}');
      emit(CheckIsFailure(e.toString()));
    }
  }
  Future<void> extractAccountNumber(File image) async {

    emit(CheckLoadInProgress()); // Update the state to indicate loading
    try {
      final response = await _checkDataProvider.extractAccountNumber(image);
      final data = response.data;
      if (response.statusCode == 200) {
        print('the api response $data');
        emit(CheckOCRSuccess(
            RIB: data['RIB'],
            checkNumber: data['checkNumber']
        ));
      }else if (response.statusCode == 210){
        emit(CheckIsFailure(data['error'] ?? 'Error extracting account number.'));
        return data['error'] ?? 'Error extracting account number.';
      }
      else {
        emit(CheckIsFailure(data['error'] ?? 'Error extracting account number.'));
        return data['error'] ?? 'Error extracting account number.';
      }
    } catch (e) {
      print("ouniii");
      emit(CheckIsFailure(e.toString()));
    }
  }

  Future<void> issue_check(String accountNumber, double amount, String pin, String checkNumber) async {
    emit(CheckLoadInProgress()); // Update the state to indicate loading
    try {
      final response = await userRepository.issueCheckRepo(accountNumber, amount, pin, checkNumber);


      print(response['msg']);
      emit(CheckSuccess(response['msg']));
    } catch (e) {
      print('the api response ${e.toString()}');
      emit(CheckIsFailure(e.toString()));
    }
  }

}
