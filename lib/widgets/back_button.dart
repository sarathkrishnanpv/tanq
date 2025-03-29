import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';


class BackArrowButton extends StatelessWidget {
  const BackArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(5, 2),
          ),
        ]),
        child:  SvgPicture.asset(
                               Assets.images.icons.backArrow,
                              
                             ),
      ),
    );
  }
}
