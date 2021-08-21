import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Presentation/Dialog/dialog.dart';
import 'package:mobile_app/models/login.dart';
import 'package:mobile_app/Presentation/Widget/main_app_name.dart';
import 'package:mobile_app/Presentation/Widget/widget.dart';
import 'package:mobile_app/business_logic/blocs/login_bloc.dart';
import 'package:mobile_app/business_logic/events/login_event.dart';
import 'package:mobile_app/business_logic/states/login_state.dart';

import 'package:mobile_app/presentation/widget/constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      // ignore: missing_required_param
      body: SingleChildScrollView(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, loginState) async {
            if (loginState is LoginStateLoadingRequest) {
              loadingDialog.show();
            } else if (loginState is LoginStateLoginSuccessful) {
              loadingDialog.dismiss();
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
                } else if (loginState.errorPackage.message == "Lỗi lạ") {
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
                    SizedBox(
                        height: SizeConfig.screenHeight *
                            0.03841), //100/SizeConfig.screenHeight = const
                    SizedBox(height: SizeConfig.screenHeight * 0.05121),
                    MainAppName(
                        text: "PHÒNG GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM"),
                    SizedBox(height: SizeConfig.screenHeight * 0.05761),
                    TextFormField(
                      autofocus: false,
                      controller: userController,
                      decoration: InputDecoration(
                        errorText: _isUsernameErr // <-- true
                            ? "Tên đăng nhập phải dài hơn $minLengthAcc ký tự"
                            : null,
                        errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        hintText: 'Nhập tài khoản',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0,
                            10.0), //logical pixel <-- -- physical pixel
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onChanged: (_) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginEventChecking(
                              //Gia --> -->Gi
                              userName: userController.text,
                              passWord: passController.text),
                        );
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0128),
                    Stack(
                      alignment: _isPasswordErr
                          ? AlignmentDirectional.topEnd
                          : AlignmentDirectional.bottomEnd,
                      children: [
                        TextFormField(
                          controller: passController,
                          autofocus: false,
                          obscureText:
                              _showPass, //true -->, nhấn vào sẽ thành false
                          decoration: InputDecoration(
                            errorText: _isPasswordErr
                                ? "Mật khẩu phải chứa $minLength đến $maxLength ký tự"
                                : null,
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 15),
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
                      //xám khi ko nhập gì hoặc nhập sai
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
