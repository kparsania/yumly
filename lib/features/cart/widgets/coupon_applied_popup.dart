import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomText.dart';

/// Dimmed overlay with Lottie (behind card) + copy; auto-closes after [duration].
Future<void> showCouponAppliedPopup(
  BuildContext context, {
  required String code,
  required String title,
  required double discountRupee,
  Duration duration = const Duration(seconds: 2),
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (dialogContext) {
      return _CouponAppliedPopupBody(
        code: code,
        title: title,
        discountRupee: discountRupee,
        duration: duration,
      );
    },
  );
}

class _CouponAppliedPopupBody extends StatefulWidget {
  const _CouponAppliedPopupBody({
    required this.code,
    required this.title,
    required this.discountRupee,
    required this.duration,
  });

  final String code;
  final String title;
  final double discountRupee;
  final Duration duration;

  @override
  State<_CouponAppliedPopupBody> createState() =>
      _CouponAppliedPopupBodyState();
}

class _CouponAppliedPopupBodyState extends State<_CouponAppliedPopupBody> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.duration, () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  String get _saveLine {
    final v = widget.discountRupee;
    final s = v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
    return 'You save ₹$s on this order';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: 320.w,
              height: 320.h,
              child: Lottie.asset(
                Images.couponAppliedLottie,
                fit: BoxFit.contain,
                repeat: false,
                errorBuilder: (_, __, ___) => Image.asset(
                  Images.couponAppliedCelebration,
                  fit: BoxFit.contain,
                  errorBuilder: (_, ___, ____) => Icon(
                    Icons.celebration_rounded,
                    size: 120.sp,
                    color: AppColors.primary.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 28.w),
              padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 52.sp,
                    color: AppColors.mediumGreen,
                  ),
                  SizedBox(height: 12.h),
                  CustomText(
                    'Coupon applied!',
                    fontWeight: Fonts.bold,
                    fontSize: 18.sp,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.lightPrimary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CustomText(
                      widget.code,
                      fontWeight: Fonts.bold,
                      fontSize: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    widget.title,
                    fontSize: 13.sp,
                    color: AppColors.textSecondary,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    _saveLine,
                    fontSize: 13.sp,
                    fontWeight: Fonts.semiBold,
                    color: AppColors.mediumGreen,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
