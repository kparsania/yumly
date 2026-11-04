import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/route/screenNames.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomText.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: CustomText('Profile', fontWeight: Fonts.bold, fontSize: 18.sp),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  height: 56.w,
                  width: 56.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    color: AppColors.white,
                    size: 30.sp,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Yumly User',
                        fontSize: 16.sp,
                        fontWeight: Fonts.bold,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        'yumly.user@email.com',
                        fontSize: 13.sp,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _ProfileTile(
            icon: Icons.location_on_outlined,
            label: 'Saved addresses',
            onTap: () => context.pushNamed(ScreenNames.ADDRESSES),
          ),
          _ProfileTile(
            icon: Icons.favorite_border,
            label: 'Favourites',
            onTap: () => context.pushNamed(ScreenNames.FAVOURITES),
          ),
          _ProfileTile(
            icon: Icons.replay,
            label: 'Reorder',
            onTap: () => context.pushNamed(ScreenNames.REORDER),
          ),
          _ProfileTile(
            icon: Icons.shopping_bag_outlined,
            label: 'Cart',
            onTap: () => context.pushNamed(ScreenNames.CART),
          ),
          SizedBox(height: 8.h),
          _ProfileTile(
            icon: Icons.logout,
            label: 'Log out',
            color: AppColors.red,
            onTap: () => context.go(ScreenNames.LOGIN),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? AppColors.textPrimary;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Row(
              children: [
                Icon(icon, color: tint, size: 22.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomText(
                    label,
                    fontSize: 15.sp,
                    fontWeight: Fonts.medium,
                    color: tint,
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.greyIcon, size: 22.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
