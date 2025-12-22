import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Fonts.dart';

import '../utils/Colors.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final int? maxLength;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSuffixTap,
    this.controller,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLength: maxLength,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: Fonts.regular,
        color: AppColors.textPrimary,
        fontFamily: Fonts.fontFamilyLexend,
      ),
      buildCounter:
          (
            BuildContext context, {
            required int currentLength,
            required bool isFocused,
            required int? maxLength,
          }) {
            return null; // Hides the counter
          },
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText == "" ? null : errorText,
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(
          color: AppColors.red,
          fontWeight: Fonts.regular,
          fontFamily: Fonts.fontFamilyLexend,
        ),
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: Fonts.regular,
          color: AppColors.textSecondary,
          fontFamily: Fonts.fontFamilyLexend,
        ),
        hintMaxLines: 2,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 12,
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixTap,
                child: Icon(suffixIcon, color: AppColors.textSecondary),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.greyText, width: 2),
        ),
      ),
    );
  }
}
