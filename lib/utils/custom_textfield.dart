import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tanq.driver.app/themes/app_colors.dart';

import 'app_colors.dart';

class CustomTextfieldTwo extends StatelessWidget {
  const CustomTextfieldTwo({
    super.key,
    this.controller,
    this.onSubmit,
    this.color,
    this.validator,
    this.onChanged,
    required this.hintText,
    this.autofocus,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.maxLines,
    this.readOnly,
    this.radius,
  });
  final TextEditingController? controller;
  final bool? autofocus;
  final void Function(String)? onSubmit;
  final String hintText;
  final Color? color;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool? readOnly;
  final bool? radius;

  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      maxLines: maxLines,
      autofocus: autofocus ?? false,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.black.withOpacity(0.9),
        fontSize: 14,
        fontFamily: "Inter",
      ),
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        filled: true,
        fillColor: color ?? AppColors.grey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.1),
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w200,
          color: AppColors.black,
          fontSize: 12,
          fontFamily: "Inter",
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
