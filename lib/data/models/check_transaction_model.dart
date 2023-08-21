import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_transaction_model.freezed.dart';
part 'check_transaction_model.g.dart';

@freezed
class CheckTransaction with _$CheckTransaction {
  const factory CheckTransaction({
    required double amount,
    required DateTime transactionDate,
  }) = _CheckTransaction;

  factory CheckTransaction.fromJson(Map<String, dynamic> json) => _$CheckTransactionFromJson(json);
}
