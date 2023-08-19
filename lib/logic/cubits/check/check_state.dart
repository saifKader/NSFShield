
import 'package:nsfsheild/data/models/account_model.dart';

abstract class CheckState{}

class CheckInitial extends CheckState{}

class CheckLoadInProgress extends CheckState{}

class CheckSuccess extends CheckState{
  final String responseData;

  CheckSuccess(this.responseData);
}

class CheckIsFailure extends CheckState{
  final String error;

  CheckIsFailure(this.error);
}