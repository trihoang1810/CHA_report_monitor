import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/error_package.dart';
import 'package:mobile_app/models/login.dart';
import 'package:mobile_app/Presentation/routers/app_router.dart';
import 'package:mobile_app/business_logic/events/login_event.dart';
import 'package:mobile_app/business_logic/states/login_state.dart';

int minLength = 6;
int maxLength = 12;
int minLengthAcc = 3;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(LoginStateInitial(
          isUsernameErr: false,
          isPasswordErr: false,
          isShow: true,
        ));
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEventChecking) {
      bool _isUsernameErr = true, _isPasswordErr = true;
      _isUsernameErr = event.userName.length < minLengthAcc;
      _isPasswordErr = event.passWord.length < minLength ||
          event.passWord.length > maxLength;
      yield LoginStateFormatChecking(
        isUsernameErr: _isUsernameErr,
        isPasswordErr: _isPasswordErr,
      );
    } else if (event is LoginEventToggleShow) {
      event.isShow = !event.isShow;
      yield LoginStateToggleShow(isShow: event.isShow);
    } else if (event is LoginEventLoginClicked) {
      yield LoginStateLoadingRequest();
      final loginDataOrErr =
          await loginRepository.loginRequest(event.username, event.password);
      if (loginDataOrErr is LoginData) {
        yield LoginStateLoginSuccessful(
            timestamp: event.timestamp, loginData: loginDataOrErr);
      } else if (loginDataOrErr is ErrorPackage) {
        yield LoginStateLoginFailure(
            timestamp: event.timestamp, errorPackage: loginDataOrErr);
      }
    }
  }
}
