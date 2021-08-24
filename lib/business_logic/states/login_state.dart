import 'package:equatable/equatable.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/login.dart';

abstract class LoginState extends Equatable {
  bool isShow;
  bool isUsernameErr;
  bool isPasswordErr;
  LoginState({this.isShow, this.isPasswordErr, this.isUsernameErr});
}

class LoginStateFormatChecking extends LoginState {
  bool isUsernameErr;
  bool isPasswordErr;
  LoginStateFormatChecking({this.isUsernameErr, this.isPasswordErr});

  @override
  // TODO: implement props
  List<Object> get props => [isUsernameErr, isPasswordErr];
}

class LoginStateToggleShow extends LoginState {
  bool isShow;
  LoginStateToggleShow({this.isShow});

  @override
  // TODO: implement props
  List<Object> get props => [isShow];
}

class LoginStateLoadingRequest extends LoginState {
  DateTime timestamp; 
  LoginStateLoadingRequest({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class LoginStateLoginSuccessful extends LoginState {
  DateTime timestamp;
  LoginData loginData;
  LoginStateLoginSuccessful({this.timestamp, this.loginData});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class LoginStateLoginFailure extends LoginState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  LoginStateLoginFailure({this.timestamp, this.errorPackage});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class LoginStateInitial extends LoginState {
  bool isUsernameErr;
  bool isPasswordErr;
  bool isShow;
  LoginStateInitial({this.isUsernameErr, this.isPasswordErr, this.isShow});
  @override
  // TODO: implement props
  List<Object> get props => [isUsernameErr, isPasswordErr, isShow];
} 
