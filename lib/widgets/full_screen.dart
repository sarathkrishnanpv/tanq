import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tanq.driver.app/gen/assets.gen.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/reusablespacing.dart';


class FullScreenImage extends StatelessWidget {
  final String imagePath;
  final String tag;

  const FullScreenImage(
      {super.key, required this.imagePath, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leadingWidth: 90,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const Twow(),
              Image.asset(
                width: 25,
                Assets.images.icons.backShop.path,
                height: 30,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
