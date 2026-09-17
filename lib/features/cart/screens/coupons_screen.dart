import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/cart/data/coupons_data.dart';
import 'package:yumly/features/cart/provider/coupon_provider.dart';
import 'package:yumly/features/cart/widgets/coupon_applied_popup.dart';

/// Same [kDefaultCoupons] list is used everywhere offers are shown.
class CouponsScreen extends ConsumerWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applied = ref.watch(appliedCouponProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
            size: 22.sp,
          ),
          onPressed: () => context.pop(),
        ),
        title: CustomText(
          'Coupons & offers',
          fontWeight: Fonts.bold,
          fontSize: 18.sp,
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: kDefaultCoupons.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final c = kDefaultCoupons[index];
          final isOn = applied?.offer.code == c.code;
          return Material(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            elevation: 1,
            shadowColor: Colors.black12,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () async {
                ref.read(appliedCouponProvider.notifier).state =
                    AppliedCouponState(offer: c);
                await showCouponAppliedPopup(
                  context,
                  code: c.code,
                  title: c.title,
                  discountRupee: c.discountRupee,
                );
                if (context.mounted) context.pop();
              },
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPrimary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: CustomText(
                        c.code,
                        fontWeight: Fonts.bold,
                        fontSize: 13.sp,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            c.title,
                            fontWeight: Fonts.bold,
                            fontSize: 15.sp,
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            c.subtitle,
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                            maxLines: 3,
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            c.discountRupee > 0
                                ? 'Save ₹${c.discountRupee.toStringAsFixed(0)}'
                                : 'Special offer',
                            fontSize: 13.sp,
                            fontWeight: Fonts.semiBold,
                            color: AppColors.mediumGreen,
                          ),
                        ],
                      ),
                    ),
                    if (isOn)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.mediumGreen,
                        size: 24.sp,
                      )
                    else
                      Icon(Icons.chevron_right, color: AppColors.greyIcon),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
