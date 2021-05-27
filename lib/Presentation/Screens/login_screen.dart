import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Dialog/dialog.dart';
import 'package:mobile_app/models/login.dart';
import 'package:mobile_app/Presentation/Widget/main_app_name.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/login_bloc.dart';
import 'package:mobile_app/business_logic/events/login_event.dart';
import 'package:mobile_app/business_logic/states/login_state.dart';

import 'file:///C:/flutterprojects/mobile_app/lib/Presentation/Widget/constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String text = "a";
  TextEditingController userController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool _showPass = true;
  bool _isUsernameErr = false;
  bool _isPasswordErr = false;
  @override
  Widget build(BuildContext context) {
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
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
        // ignore: missing_required_param
        body: SingleChildScrollView(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, loginState) async {
              print("Đang trong listener");
              if (loginState is LoginStateLoadingRequest) {
                print("Đang ở loading request");
                loadingDialog.show();
              } else if (loginState is LoginStateLoginSuccessful) {
                loadingDialog.dismiss();
                employeeIdOverall = loginState.loginData.employee.employeeId;
                employeeFirstNameOverall =
                    loginState.loginData.employee.firstName;
                employeeLastNameOverall =
                    loginState.loginData.employee.lastName;
                Navigator.popAndPushNamed(context, '/modescreen');
              } else if (loginState is LoginStateLoginFailure) {
                print("Đã thất bại");
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                    context: context,
                    title: "Đăng nhập thất bại",
                    desc: "Tên đăng nhập hoặc mật khẩu không đúng.",
                    textBtn: "Đăng nhập lại",
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
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    //Text(
                    // "GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM NẮP BỒN CẦU",
                    //textAlign: TextAlign.center,
                    //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    // ),
                    SizedBox(height: 40),
                    MainAppName(),
                    SizedBox(height: 45.0),
                    TextFormField(
                      autofocus: false,
                      controller: userController,
                      decoration: InputDecoration(
                        errorText: _isUsernameErr
                            ? "Tên đăng nhập phải dài hơn $minLength ký tự"
                            : null,
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        hintText: 'Nhập tài khoản',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (_) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginEventChecking(
                              userName: userController.text,
                              passWord: passController.text),
                        );
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: passController,
                      autofocus: false,
                      obscureText: _showPass,
                      decoration: InputDecoration(
                        errorText: _isPasswordErr
                            ? "Mật khẩu phải dài hơn $minLength ký tự"
                            : null,
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        hintText: 'Nhập mật khẩu',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (_) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginEventChecking(
                              userName: userController.text,
                              passWord: passController.text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                      width: 30.0,
                    ),
                    CustomizedButton(
                      onPressed: (userController.text == "" ||
                              passController.text == "" ||
                              _isPasswordErr ||
                              _isUsernameErr)
                          ? null
                          : () async {
                              //Code này cho bản full
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginEventLoginClicked(
                                      username: userController.text,
                                      password: passController.text,
                                      timestamp: DateTime.now()));
                              //Code này cho bản test
                              // Navigator.popAndPushNamed(context, '/modescreen');
                            },
                      text: "Đăng nhập",
                    ),
                    SizedBox(height: 60),
                    Text(
                      'SISTRAIN All rights reserved',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
