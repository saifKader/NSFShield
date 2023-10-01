
import 'package:nsfsheild/data/models/account/account_model.dart';

abstract class CheckState{}

class CheckInitial extends CheckState{}

class CheckLoadInProgress extends CheckState{}

class CheckSuccess extends CheckState{
  final String responseData;

  CheckSuccess(this.responseData);
}
class CheckOCRSuccess extends CheckState{
  final String RIB;
  final String checkNumber;

  CheckOCRSuccess({required this.RIB, required this.checkNumber});

  List<Object?> get props => [RIB, checkNumber];

  Map<String, dynamic> toJson() => {
    'RIB': RIB,
    'checkNumber': checkNumber,
  };

  static CheckOCRSuccess fromJson(Map<String, dynamic> json) {
    return CheckOCRSuccess(
      RIB: json['RIB'],
      checkNumber: json['checkNumber'],
    );
  }
}
class CheckIsFailure extends CheckState{
  final String error;

  CheckIsFailure(this.error);
}