import 'package:flutter/material.dart';

import 'constant.dart';

class MainAppName extends StatelessWidget {
  String text = '';
  MainAppName({@required this.text});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
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
