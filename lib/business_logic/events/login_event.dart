import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

// ignore: must_be_immutable
class LoginEventChecking extends LoginEvent {
  String userName;
  String passWord;
  LoginEventChecking({this.userName, this.passWord});
  @override
  List<Object> get props => [userName, passWord];
}

// ignore: must_be_immutable
class LoginEventToggleShow extends LoginEvent {
  bool isShow;
  LoginEventToggleShow({this.isShow});

  @override
  // TODO: implement props
  List<Object> get props => [isShow];
}

// ignore: must_be_immutable
class LoginEventLoginClicked extends LoginEvent {
  String username, password;
  DateTime timestamp;
  LoginEventLoginClicked({this.username, this.password, this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [username, password, timestamp];
}
