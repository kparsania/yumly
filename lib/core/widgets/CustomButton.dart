import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import '../utils/Colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 48,
    this.borderRadius = 30,
    this.backgroundColor = AppColors.primary,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // full width
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: CustomText(
          label,
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: Fonts.medium,
        ),
      ),
    );
  }
}
