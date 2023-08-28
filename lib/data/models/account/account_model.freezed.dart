// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
mixin _$Account {
  String get bankAccountNumber => throw _privateConstructorUsedError;
  DateTime get dateOfOpening => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  double get blockedBalance => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call(
      {String bankAccountNumber,
      DateTime dateOfOpening,
      double balance,
      double blockedBalance,
      int userId});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankAccountNumber = null,
    Object? dateOfOpening = null,
    Object? balance = null,
    Object? blockedBalance = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      bankAccountNumber: null == bankAccountNumber
          ? _value.bankAccountNumber
          : bankAccountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfOpening: null == dateOfOpening
          ? _value.dateOfOpening
          : dateOfOpening // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      blockedBalance: null == blockedBalance
          ? _value.blockedBalance
          : blockedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$_AccountCopyWith(
          _$_Account value, $Res Function(_$_Account) then) =
      __$$_AccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bankAccountNumber,
      DateTime dateOfOpening,
      double balance,
      double blockedBalance,
      int userId});
}

/// @nodoc
class __$$_AccountCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$_Account>
    implements _$$_AccountCopyWith<$Res> {
  __$$_AccountCopyWithImpl(_$_Account _value, $Res Function(_$_Account) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankAccountNumber = null,
    Object? dateOfOpening = null,
    Object? balance = null,
    Object? blockedBalance = null,
    Object? userId = null,
  }) {
    return _then(_$_Account(
      bankAccountNumber: null == bankAccountNumber
          ? _value.bankAccountNumber
          : bankAccountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfOpening: null == dateOfOpening
          ? _value.dateOfOpening
          : dateOfOpening // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      blockedBalance: null == blockedBalance
          ? _value.blockedBalance
          : blockedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Account implements _Account {
  const _$_Account(
      {required this.bankAccountNumber,
      required this.dateOfOpening,
      required this.balance,
      required this.blockedBalance,
      required this.userId});

  factory _$_Account.fromJson(Map<String, dynamic> json) =>
      _$$_AccountFromJson(json);

  @override
  final String bankAccountNumber;
  @override
  final DateTime dateOfOpening;
  @override
  final double balance;
  @override
  final double blockedBalance;
  @override
  final int userId;

  @override
  String toString() {
    return 'Account(bankAccountNumber: $bankAccountNumber, dateOfOpening: $dateOfOpening, balance: $balance, blockedBalance: $blockedBalance, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Account &&
            (identical(other.bankAccountNumber, bankAccountNumber) ||
                other.bankAccountNumber == bankAccountNumber) &&
            (identical(other.dateOfOpening, dateOfOpening) ||
                other.dateOfOpening == dateOfOpening) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.blockedBalance, blockedBalance) ||
                other.blockedBalance == blockedBalance) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bankAccountNumber, dateOfOpening,
      balance, blockedBalance, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountCopyWith<_$_Account> get copyWith =>
      __$$_AccountCopyWithImpl<_$_Account>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccountToJson(
      this,
    );
  }
}

abstract class _Account implements Account {
  const factory _Account(
      {required final String bankAccountNumber,
      required final DateTime dateOfOpening,
      required final double balance,
      required final double blockedBalance,
      required final int userId}) = _$_Account;

  factory _Account.fromJson(Map<String, dynamic> json) = _$_Account.fromJson;

  @override
  String get bankAccountNumber;
  @override
  DateTime get dateOfOpening;
  @override
  double get balance;
  @override
  double get blockedBalance;
  @override
  int get userId;
  @override
  @JsonKey(ignore: true)
  _$$_AccountCopyWith<_$_Account> get copyWith =>
      throw _privateConstructorUsedError;
}
