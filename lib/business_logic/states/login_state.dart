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
  bool isUsernameErr;  //Do Gi là 2 kí tự nên isUsernameErr = true
  bool isPasswordErr;
  LoginStateFormatChecking({this.isUsernameErr, this.isPasswordErr});

  @override
  // TODO: implement props
  List<Object> get props => [isUsernameErr, isPasswordErr];
}

class LoginStateToggleShow extends LoginState {
  bool isShow; //isShow mình cài đặt mặc định trong BloC là false
  //isShow khi nhấn nút con mắt sẽ là true do BloC xử lý
  LoginStateToggleShow({this.isShow});

  @override
  // TODO: implement props
  List<Object> get props => [isShow];
}

class LoginStateLoadingRequest extends LoginState {
  DateTime timestamp; 
  LoginStateLoadingRequest({this.timestamp});
//UI đọc được LoadingRequest sẽ hiển thị loadingDialog
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
