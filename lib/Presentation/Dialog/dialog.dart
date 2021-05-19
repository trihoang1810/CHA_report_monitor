//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Presentation/Widget/constant.dart';
import 'package:ndialog/ndialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertDialogTwoBtnCustomized {
  BuildContext context;
  String title;
  String desc;
  String textBtn1;
  String textBtn2;
  Color bgBtn1, bgBtn2, fgBtn1, fgBtn2;
  double titleFSize, descFSize;
  VoidCallback onPressedBtn1, onPressedBtn2;
  AlertDialogTwoBtnCustomized({
    @required this.context,
    this.title = "Nhập title",
    this.desc = "Nhập mô tả ",
    this.textBtn1 = "Đồng ý",
    this.textBtn2 = "Hủy bỏ",
    this.bgBtn1 = Constants.mainColor,
    this.bgBtn2 = Colors.transparent,
    this.fgBtn1 = Colors.white,
    this.fgBtn2 = Constants.mainColor,
    this.onPressedBtn1,
    this.onPressedBtn2,
    this.descFSize = 18,
    this.titleFSize = 22,
  });
  void show() {
    Alert(
            context: context,
            title: title,
            desc: desc,
            buttons: [
              DialogButton(
                color: bgBtn1,
                child: Text(textBtn1,
                    style: TextStyle(
                        fontSize: 18,
                        color: fgBtn1,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onPressedBtn1 != null) {
                    onPressedBtn1();
                  }
                },
              ),
              DialogButton(
                color: bgBtn2,
                child: Text(textBtn2,
                    style: TextStyle(
                        fontSize: 18,
                        color: fgBtn2,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onPressedBtn2 != null) {
                    onPressedBtn2();
                  }
                },
              )
            ],
            style: AlertStyle(
                descStyle: TextStyle(
                    fontSize: descFSize, fontWeight: FontWeight.normal),
                titleStyle: TextStyle(fontSize: titleFSize)))
        .show();
  }
}

class AlertDialogOneBtnCustomized {
  BuildContext context;
  String title;
  String desc;
  String textBtn;
  Color bgBtn, fgBtn;
  double titleFSize, descFSize;
  VoidCallback onPressedBtn;
  VoidCallback closePressed;
  AlertDialogOneBtnCustomized({
    @required this.context,
    this.title = "Nhập title",
    this.desc = "Nhập mô tả ",
    this.textBtn = "Đồng ý",
    this.bgBtn = Constants.mainColor,
    this.fgBtn = Colors.white,
    this.onPressedBtn,
    this.descFSize = 18,
    this.titleFSize = 22,
    this.closePressed,
  });
  void show() {
    Alert(
            onWillPopActive: false,
            closeFunction: () {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
                print("can pop");
              }
              if (closePressed != null) {
                closePressed();
              }
            },
            context: context,
            title: title,
            desc: desc,
            buttons: [
              DialogButton(
                color: bgBtn,
                child: Text(textBtn,
                    style: TextStyle(
                        fontSize: 18,
                        color: fgBtn,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                  print("sthg");
                  if (onPressedBtn != null) {
                    onPressedBtn();
                  }
                },
              ),
            ],
            style: AlertStyle(
                descStyle: TextStyle(
                    fontSize: descFSize, fontWeight: FontWeight.normal),
                titleStyle: TextStyle(fontSize: titleFSize)))
        .show();
  }
}

class AlertWaitingCustomized {
  BuildContext context;
  String title;
  String desc;
  double titleFSize, descFSize;
  AlertWaitingCustomized(
      {this.context,
      this.title = "Đang xử lý",
      this.desc = "Vui lòng chờ trong giây lát",
      this.descFSize = 18,
      this.titleFSize = 22});
  void show() {
    Alert(
        onWillPopActive: true,
        image: Image.asset('lib/assets/CHAlogo.png'),
        context: context,
        title: title,
        desc: desc,
        style: AlertStyle(
            animationDuration: Duration(milliseconds: 300),
            descStyle:
                TextStyle(fontSize: descFSize, fontWeight: FontWeight.normal),
            titleStyle: TextStyle(fontSize: titleFSize)),
        buttons: []).show();
  }

  void dismiss() {
    Alert(
        image: Image.asset('lib/assets/CHAlogo.png'),
        context: context,
        title: title,
        desc: desc,
        style: AlertStyle(
            animationDuration: Duration(milliseconds: 300),
            descStyle:
                TextStyle(fontSize: descFSize, fontWeight: FontWeight.normal),
            titleStyle: TextStyle(fontSize: titleFSize)),
        buttons: []).dismiss();
  }
}

class LoadingDialog {
  BuildContext buildContext;
  LoadingDialog({this.buildContext});
  ProgressDialog progressDialog;
  void show() {
    progressDialog = ProgressDialog(
      buildContext,
      message: Text(
        "Đang tải dữ liệu",
        style: TextStyle(fontSize: 20),
      ),
      dismissable: true,
      defaultLoadingWidget: Container(
          //Do dialog ko có kích thước, nên dùng chính Container để chỉnh kích thước cho Dialog và padding để ép size Circular
          padding: EdgeInsets.all(15),
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Constants.mainColor),
            strokeWidth: 3,
          )),
    );
    progressDialog.show();
  }

  void dismiss() {
    progressDialog.dismiss();
  }
}
