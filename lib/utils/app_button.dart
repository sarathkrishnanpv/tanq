import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';
import 'package:tanq.driver.app/utils/global.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.width,
    this.height,
    this.onTap,
    required this.text,
    this.textColor,
    this.buttonColor,
    this.icon,
    required this.iconData,
    this.iconBeforeText = false,
    this.border,
  });

  final double? width;
  final double? height;
  final Function()? onTap;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final bool? icon;
  final Widget iconData;
  final bool iconBeforeText;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      from: 20,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: height ?? 50,
          width: width ?? Constants.width,
          decoration: BoxDecoration(
            border: border,
            color: buttonColor ?? AppColors.black,
            borderRadius: BorderRadius.circular(3),
          ),
          child: icon ?? true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: iconBeforeText
                      ? [
                          iconData,
                          const SizedBox(width: 7),
                          AppStyles().semiBold(
                              text: text,
                              size: 15,
                              color: textColor ?? AppColors.backgroundColor),
                        ]
                      : [
                          AppStyles().semiBold(
                              text: text,
                              size: 15,
                              color: textColor ?? AppColors.backgroundColor),
                          const SizedBox(width: 5),
                          iconData,
                        ],
                )
              : Center(
                  child: AppStyles().semiBold(
                      text: text,
                      size: 15,
                      color: textColor ?? AppColors.backgroundColor),
                ),
        ),
      ),
    );
  }
}
