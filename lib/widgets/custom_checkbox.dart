import 'package:flutter/material.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color? activeColor;
  final double size;
  final double borderRadius;
  final double borderWidth;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.size = 20,
    this.borderRadius = 0,
    this.borderWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: value ? (activeColor ?? AppColors.primary) : Colors.black,
            width: borderWidth,
          ),
          color:
              value ? (activeColor ?? AppColors.primary) : Colors.transparent,
        ),
        child: value
            ? Center(
                child: Icon(
                  Icons.check,
                  size: size * 0.7,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
