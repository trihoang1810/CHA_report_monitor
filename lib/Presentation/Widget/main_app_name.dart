import 'package:flutter/material.dart';

import 'constant.dart';

class MainAppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "GIÁM SÁT KIỂM TRA CHẤT LƯỢNG SẢN PHẨM NẮP BỒN CẦU",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Constants.mainColor),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('lib/assets/CHAlogo.png'),
                width: 100,
              ),
              SizedBox(
                width: 40,
              ),
              Image(image: AssetImage('lib/assets/BK_VIAMLAB.png'), width: 100)
            ],
          ),
        ]);
  }
}
