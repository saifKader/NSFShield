// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheckTransaction _$CheckTransactionFromJson(Map<String, dynamic> json) {
  return _CheckTransaction.fromJson(json);
}

/// @nodoc
mixin _$CheckTransaction {
  double get amount => throw _privateConstructorUsedError;
  DateTime get transactionDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckTransactionCopyWith<CheckTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckTransactionCopyWith<$Res> {
  factory $CheckTransactionCopyWith(
          CheckTransaction value, $Res Function(CheckTransaction) then) =
      _$CheckTransactionCopyWithImpl<$Res, CheckTransaction>;
  @useResult
  $Res call({double amount, DateTime transactionDate});
}

/// @nodoc
class _$CheckTransactionCopyWithImpl<$Res, $Val extends CheckTransaction>
    implements $CheckTransactionCopyWith<$Res> {
  _$CheckTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? transactionDate = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CheckTransactionCopyWith<$Res>
    implements $CheckTransactionCopyWith<$Res> {
  factory _$$_CheckTransactionCopyWith(
          _$_CheckTransaction value, $Res Function(_$_CheckTransaction) then) =
      __$$_CheckTransactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, DateTime transactionDate});
}

/// @nodoc
class __$$_CheckTransactionCopyWithImpl<$Res>
    extends _$CheckTransactionCopyWithImpl<$Res, _$_CheckTransaction>
    implements _$$_CheckTransactionCopyWith<$Res> {
  __$$_CheckTransactionCopyWithImpl(
      _$_CheckTransaction _value, $Res Function(_$_CheckTransaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? transactionDate = null,
  }) {
    return _then(_$_CheckTransaction(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CheckTransaction implements _CheckTransaction {
  const _$_CheckTransaction(
      {required this.amount, required this.transactionDate});

  factory _$_CheckTransaction.fromJson(Map<String, dynamic> json) =>
      _$$_CheckTransactionFromJson(json);

  @override
  final double amount;
  @override
  final DateTime transactionDate;

  @override
  String toString() {
    return 'CheckTransaction(amount: $amount, transactionDate: $transactionDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheckTransaction &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, transactionDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CheckTransactionCopyWith<_$_CheckTransaction> get copyWith =>
      __$$_CheckTransactionCopyWithImpl<_$_CheckTransaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheckTransactionToJson(
      this,
    );
  }
}

abstract class _CheckTransaction implements CheckTransaction {
  const factory _CheckTransaction(
      {required final double amount,
      required final DateTime transactionDate}) = _$_CheckTransaction;

  factory _CheckTransaction.fromJson(Map<String, dynamic> json) =
      _$_CheckTransaction.fromJson;

  @override
  double get amount;
  @override
  DateTime get transactionDate;
  @override
  @JsonKey(ignore: true)
  _$$_CheckTransactionCopyWith<_$_CheckTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}
