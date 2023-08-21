import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nsfsheild/data/models/check_transaction_model.dart';
import 'package:nsfsheild/data/repositories/user_repository.dart'; // Import the user repository

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final UserRepository _userRepository; // Add this field
  TransactionCubit(this._userRepository) : super(TransactionInitial());


  final userRepository = UserRepository();
  Future<void> loadCheckTransactions(String token) async {
    emit(TransactionLoading());
    try {
      final transactions = await _userRepository.getCheckTransactions(token);
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError('An error occurred while loading transactions.'));
    }
  }
}
