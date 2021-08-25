import 'package:flutter/material.dart';
import 'package:mobile_app/presentation/dialog/dialog.dart';


void logout(BuildContext context) {
  AlertDialogTwoBtnCustomized alertDialogOneBtnCustomized =
      AlertDialogTwoBtnCustomized(
          context: context,
          title: "Bạn có muốn?",
          desc: "Đăng xuất",
          textBtn1: "Có",
          textBtn2: "Quay lại",
          onPressedBtn1: () {
            while (Navigator.canPop(context)) {
              Navigator.pop(context);
              //print("Đã pop");
            }
          });
  alertDialogOneBtnCustomized.show();
}
