import 'package:flutter/material.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/utils/global.dart';


class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: false,
      leadingWidth: Constants.width * 0.3,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Image.asset(
          Assets.images.icons.activity,
          width: Constants.width * 0.5,
          height: Constants.height * 0.06,
        ),
      ),
    );
  }
}
