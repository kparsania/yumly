import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/widgets/CustomImage.dart';

import '../utils/Images.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? centerWidget;
  final Color backgroundColor;
  final bool showBack;
  final VoidCallback? onBack;
  final double elevation;
  final Color iconColor;
  final TextStyle? titleTextStyle;
  final String? rightIcon1;
  final VoidCallback? onRightIcon1Tap;
  final String? rightIcon2;
  final VoidCallback? onRightIcon2Tap;

  const CustomHeader({
    super.key,
    this.title = '',
    this.centerWidget,
    this.backgroundColor = Colors.white,
    this.showBack = true,
    this.onBack,
    this.rightIcon1,
    this.onRightIcon1Tap,
    this.rightIcon2,
    this.onRightIcon2Tap,
    this.elevation = 0.5,
    this.iconColor = AppColors.textPrimary,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final titleWidget =
        centerWidget ??
        Text(
          title!,
          maxLines: 1,
          textAlign: TextAlign.center,
          style:
              titleTextStyle ??
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightGrey,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: CustomImage(
              source: showBack ? Images.backArrow : null,
              color: iconColor,
              isSvg: true,
              onTap: () => {context.pop()},
              height: 18.h,
              width: 18.w,
            ),
          ),
          Expanded(child: titleWidget),
          Row(
            children: [
              if (rightIcon1 != null)
                CustomImage(
                  source: rightIcon1,
                  color: iconColor,
                  onTap: onRightIcon1Tap,
                  height: 24.h,
                  width: 24.w,
                ),
              if (rightIcon2 != null)
                CustomImage(
                  source: rightIcon2,
                  color: iconColor,
                  onTap: onRightIcon2Tap,
                  height: 24.h,
                  width: 24.w,
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
