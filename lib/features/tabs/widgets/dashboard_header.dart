import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomSearchBar.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import 'dashboard_categories.dart';

/// Blue address and search header. It is laid out at its full height and the
/// sliver clips it from the top, so the address scrolls away and the search
/// bar stays pinned.
class DashboardHeaderDelegate extends SliverPersistentHeaderDelegate {
  DashboardHeaderDelegate({
    required this.topInset,
    required this.onSearchTap,
    required this.onAddressTap,
    required this.onProfileTap,
    required this.addressLabel,
    required this.addressLine,
  });

  final double topInset;
  final VoidCallback onSearchTap;
  final VoidCallback onAddressTap;
  final VoidCallback onProfileTap;
  final String addressLabel;
  final String addressLine;

  static double get _topPadding => 8.h;
  static double get _addressHeight => 44.h;
  static double get _addressGap => 14.h;
  static double get _searchHeight => 50.h;
  static double get _bottomPadding => 18.h;

  static double get _expandedBody =>
      _topPadding + _addressHeight + _addressGap + _searchHeight + _bottomPadding;

  static double get _collapsedBody =>
      _topPadding + _searchHeight + _bottomPadding;

  @override
  double get maxExtent => topInset + _expandedBody;

  @override
  double get minExtent => topInset + _collapsedBody;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.bottomCenter,
        minHeight: maxExtent,
        maxHeight: maxExtent,
        child: _DashboardHeaderBody(
          onSearchTap: onSearchTap,
          onAddressTap: onAddressTap,
          onProfileTap: onProfileTap,
          addressLabel: addressLabel,
          addressLine: addressLine,
          addressOpacity: 1 - progress,
          shadowOpacity: progress,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(DashboardHeaderDelegate oldDelegate) => true;
}

/// The category row itself, pinned once it reaches the header.
class DashboardCategoriesDelegate extends SliverPersistentHeaderDelegate {
  const DashboardCategoriesDelegate();

  @override
  double get maxExtent => DashboardCategories.height;

  @override
  double get minExtent => DashboardCategories.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return const ColoredBox(
      color: AppColors.white,
      child: DashboardCategories(),
    );
  }

  @override
  bool shouldRebuild(DashboardCategoriesDelegate oldDelegate) => true;
}

class _DashboardHeaderBody extends StatelessWidget {
  const _DashboardHeaderBody({
    required this.onSearchTap,
    required this.onAddressTap,
    required this.onProfileTap,
    required this.addressLabel,
    required this.addressLine,
    required this.addressOpacity,
    required this.shadowOpacity,
  });

  final VoidCallback onSearchTap;
  final VoidCallback onAddressTap;
  final VoidCallback onProfileTap;
  final String addressLabel;
  final String addressLine;
  final double addressOpacity;
  final double shadowOpacity;

  static const List<String> _searchPlaceholders = [
    "Search for 'restaurants'",
    "Search for 'pizza'",
    "Search for 'Cake'",
    "Search for 'Sweet'",
    "Search for 'High Protein'",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top +
              DashboardHeaderDelegate._topPadding,
          left: 16.w,
          right: 16.w,
          bottom: DashboardHeaderDelegate._bottomPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.blueBorder,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24.r),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: DashboardHeaderDelegate._addressHeight,
            child: Opacity(
              opacity: addressOpacity,
              child: _AddressRow(
                label: addressLabel,
                line: addressLine,
                onAddressTap: onAddressTap,
                onProfileTap: onProfileTap,
              ),
            ),
            ),
            SizedBox(height: DashboardHeaderDelegate._addressGap),
            CustomSearchBar(
              key: const ValueKey("headerSearch"),
              placeholderTexts: _searchPlaceholders,
              isSearchEnabled: false,
              leftIcon: Images.search,
              rightIcon1: Images.microphone,
              rightIcon2Color: AppColors.mediumGrey,
              rightIcon1Color: AppColors.primary,
              leftIconColor: AppColors.mediumGrey,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textPrimary.withValues(alpha: 0.06),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              onTap: onSearchTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressRow extends StatelessWidget {
  const _AddressRow({
    required this.label,
    required this.line,
    required this.onAddressTap,
    required this.onProfileTap,
  });

  final String label;
  final String line;
  final VoidCallback onAddressTap;
  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onAddressTap,
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 18.h,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: CustomText(
                        label,
                        fontSize: 15.sp,
                        fontWeight: Fonts.bold,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    CustomImage(source: Images.downArrow, height: 14.h),
                  ],
                ),
                SizedBox(height: 2.h),
                CustomText(
                  line,
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: onProfileTap,
          child: Container(
            height: 40.w,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2.w),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 8.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Icon(
              Icons.person_rounded,
              size: 22.w,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
