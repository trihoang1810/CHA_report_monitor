import 'package:flutter/material.dart';

import 'constant.dart';

class MainAppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "PHÒNG GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Constants.mainColor),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.0256),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('lib/assets/CHAlogo.png'),
              width: SizeConfig.screenWidth * 0.25605,
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.10242,
            ),
            Image(
              image: AssetImage('lib/assets/BK_VIAMLAB.png'),
              width: SizeConfig.screenWidth * 0.25605,
            )
          ],
        ),
      ],
    );
  }
}
