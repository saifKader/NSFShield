// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Account _$$_AccountFromJson(Map<String, dynamic> json) => _$_Account(
      bankAccountNumber: json['bankAccountNumber'] as String,
      dateOfOpening: DateTime.parse(json['dateOfOpening'] as String),
      balance: (json['balance'] as num).toDouble(),
      blockedBalance: (json['blockedBalance'] as num).toDouble(),
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'bankAccountNumber': instance.bankAccountNumber,
      'dateOfOpening': instance.dateOfOpening.toIso8601String(),
      'balance': instance.balance,
      'blockedBalance': instance.blockedBalance,
      'userId': instance.userId,
    };
