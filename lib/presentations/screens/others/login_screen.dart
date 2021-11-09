import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/presentations/Dialog/dialog.dart';
import 'package:mobile_app/presentations/widgets/main_app_name.dart';
import 'package:mobile_app/presentations/widgets/widget.dart';
import 'package:mobile_app/blocs/blocs/login_bloc.dart';
import 'package:mobile_app/blocs/events/login_event.dart';
import 'package:mobile_app/blocs/states/login_state.dart';

import 'package:mobile_app/presentations/widgets/constant.dart';
import 'package:mobile_app/utils/password_preferences.dart';
import 'package:mobile_app/utils/username_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey key = GlobalKey();
  String text = "a";
  TextEditingController userController = new TextEditingController();
  TextEditingController passController =
      new TextEditingController(); //null safety --> dart
  bool _showPass = true;
  bool _isUsernameErr = false;
  bool _isPasswordErr = false;
  String errorTitle = "";
  String errorDetail = "";
  String errorButton = "";

  @override
  void initState() {
    super.initState();
    userController.text = UsernamePreferences.getUsername() ?? 'admin';
    passController.text = PasswordPreferences.getPassword() ?? '';

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Đăng nhập"),
        backgroundColor: Constants.mainColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, loginState) async {
            if (loginState is LoginStateLoadingRequest) {
              loadingDialog.show();
            } else if (loginState is LoginStateLoginSuccessful) {
              loadingDialog.dismiss();
              await UsernamePreferences.setUsername(userController.text);
              await PasswordPreferences.setPassword(passController.text);
              String employeeIdOverall =
                  loginState.loginData.employee.employeeId;
              String employeeFirstNameOverall =
                  loginState.loginData.employee.firstName;
              String employeeLastNameOverall =
                  loginState.loginData.employee.lastName;
              Navigator.popAndPushNamed(context, '/modescreen', arguments: {
                'id': employeeIdOverall.toString(),
                'firstName': employeeFirstNameOverall.toString(),
                'lastName': employeeLastNameOverall.toString()
              });
            } else if (loginState is LoginStateLoginFailure) {
              loadingDialog.dismiss();
              if (loginState.errorPackage.message != null) {
                if (loginState.errorPackage.message == "Lỗi mạng") {
                  errorTitle = loginState.errorPackage.message;
                  errorDetail = loginState.errorPackage.detail;
                  errorButton = "OK";
                } else if (loginState.errorPackage.message == "Lỗi hệ thống") {
                  errorTitle = loginState.errorPackage.message;
                  errorDetail = loginState.errorPackage.detail;
                  errorButton = "OK";
                } else if (loginState.errorPackage.message ==
                    "Request could not be process because of invalid request.") {
                  errorTitle = "Đăng nhập thất bại";
                  errorDetail = "Tên đăng nhập hoặc mật khẩu không đúng";
                  errorButton = "Đăng nhập lại";
                } else {
                  errorTitle = "Lỗi xảy ra";
                  errorDetail = "Vui lòng đăng nhập lại";
                  errorButton = "Đăng nhập lại";
                }
              } else {
                errorTitle = "Lỗi xảy ra";
                errorDetail = "Vui lòng đăng nhập lại";
                errorButton = "Đăng nhập lại";
              }
              AlertDialogOneBtnCustomized(
                  context: context,
                  title: errorTitle,
                  desc: errorDetail,
                  textBtn: errorButton,
                  closePressed: () {
                    userController.text = "";
                    passController.text = "";
                  },
                  onPressedBtn: () {
                    userController.text = "";
                    passController.text = "";
                  }).show();
            } else if (loginState is LoginStateInitial) {
              _showPass = loginState.isShow;
              _isUsernameErr = loginState.isUsernameErr;
              _isPasswordErr = loginState.isPasswordErr;
            } else if (loginState is LoginStateFormatChecking) {
              _isUsernameErr = loginState.isUsernameErr;
              _isPasswordErr = loginState.isPasswordErr;
            } else if (loginState is LoginStateToggleShow) {
              _showPass = loginState.isShow;
            }
          },
          builder: (context, loginState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.03841),
                    SizedBox(height: SizeConfig.screenHeight * 0.05121),
                    MainAppName(
                        text: "PHÒNG GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM"),
                    SizedBox(height: SizeConfig.screenHeight * 0.05761),
                    TextField(
                      key: key,
                      controller: userController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                        hintText: "Nhập tài khoản",
                        errorText: _isUsernameErr
                            ? "Tên đăng nhập phải dài hơn $minLengthAcc ký tự"
                            : null,
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      onChanged: (_) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginEventChecking(userName: userController.text,passWord: passController.text
                        ));
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    Stack(
                      alignment: _isPasswordErr
                          ? AlignmentDirectional.topEnd
                          : AlignmentDirectional.bottomEnd,
                      children: [
                        TextFormField(
                          controller: passController,
                          autofocus: false,
                          obscureText: _showPass,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 18),
                            errorText: _isPasswordErr
                                ? "Mật khẩu phải chứa $minLength đến $maxLength ký tự"
                                : null,
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 15),
                            hintText: 'Nhập mật khẩu',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          onChanged: (_) {
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginEventChecking(passWord: passController.text,
                              userName: userController.text),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginEventToggleShow(isShow: _showPass));
                          },
                          icon: Icon(
                            _showPass ? Icons.visibility : Icons.visibility_off,
                            color: Constants.mainColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.0192,
                    ),
                    CustomizedButton(
                      onPressed: (userController.text == "" ||
                              passController.text == "" ||
                              _isPasswordErr ||
                              _isUsernameErr)
                          ? null
                          : () async {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginEventLoginClicked(
                                      username: userController.text,
                                      password: passController.text,
                                      timestamp: DateTime.now()));
                            },
                      text: "Đăng nhập",
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0768),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'SISTRAIN All rights reserved',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: (SizeConfig.screenHeight / 100),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
