// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CheckTransaction _$$_CheckTransactionFromJson(Map<String, dynamic> json) =>
    _$_CheckTransaction(
      amount: (json['amount'] as num).toDouble(),
      transactionDate: DateTime.parse(json['transactionDate'] as String),
    );

Map<String, dynamic> _$$_CheckTransactionToJson(_$_CheckTransaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'transactionDate': instance.transactionDate.toIso8601String(),
    };
