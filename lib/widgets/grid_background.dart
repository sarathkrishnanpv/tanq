import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/utils/global.dart';

class GridBackGround extends StatelessWidget {
  const GridBackGround({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.images.normal.grid,
      width: Constants.width,
      height: Constants.height * 0.18,
      fit: BoxFit.cover,
    );
  }
} 
