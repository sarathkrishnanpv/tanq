import 'package:flutter/material.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';
import 'package:tanq.driver.app/utils/app_styles.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.keyboardType,
    required this.label,
    required this.controller,
    this.maxLength,
  });
  final TextInputType? keyboardType;
  final String label;
  final int? maxLength;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.black.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: TextFormField(
                maxLength: maxLength,
                buildCounter: (context,
                        {required int currentLength,
                        required int? maxLength,
                        required bool isFocused}) =>
                    null,
                controller: controller,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                // keyboardType: TextInputType.phone,
              ),
            ),
          ),
        ),
        Positioned(
          top: -8,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.white,
            child: AppStyles().med(
                text: label,
                size: 12,
                color: AppColors.black.withOpacity(0.5)),
          ),
        ),
      ],
    );
  }
}
