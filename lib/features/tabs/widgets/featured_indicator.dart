import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomText.dart';

class FeaturedIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const FeaturedIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left dots
        ..._buildSideDots(isLeft: true),

        // Current index pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: AppColors.blackSecondary,
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: CustomText(
            '${currentIndex + 1}/$itemCount',
            color: AppColors.white,
            fontWeight: Fonts.semiBold,
          ),
        ),

        // Right dots
        ..._buildSideDots(isLeft: false),
      ],
    );
  }

  List<Widget> _buildSideDots({required bool isLeft}) {
    final List<Widget> dots = [];
    if (isLeft) {
      if (currentIndex > 0) {
        if (currentIndex == 1) {
          dots.add(_dot(small: false));
        } else {
          dots.add(_dot(small: true));
          dots.add(SizedBox(width: 5.w));
          dots.add(_dot(small: false));
        }
      }
    } else {
      if (currentIndex < itemCount - 1) {
        final remaining = itemCount - currentIndex - 1;
        if (remaining == 1) {
          dots.add(_dot(small: true));
        } else {
          dots.add(_dot(small: false));
          dots.add(const SizedBox(width: 4));
          dots.add(_dot(small: true));
        }
      }
    }
    return dots;
  }

  Widget _dot({required bool small}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: small ? 7.w : 10.w,
      height: small ? 7.h : 10.h,
      decoration: BoxDecoration(
        color: small ? AppColors.divider : AppColors.textSecondary,
        shape: BoxShape.circle,
      ),
    );
  }
}
