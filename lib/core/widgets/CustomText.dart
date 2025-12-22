import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? height;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontFamily,
    this.fontWeight = Fonts.regular,
    this.color = AppColors.textPrimary,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.decoration,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight,
        color: color,
        fontFamily: fontFamily ?? Fonts.fontFamilyLexend,
        decoration: decoration,
        height: height,
      ),
    );
  }
}
