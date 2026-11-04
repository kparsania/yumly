// top_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import 'package:go_router/go_router.dart';
import 'package:yumly/core/route/screenNames.dart';

import '../data/restaurant_catalog.dart';
import '../../../core/widgets/CustomSearchBar.dart';

class TopSheet extends StatefulWidget {
  final VoidCallback onClose;

  const TopSheet({super.key, required this.onClose});

  @override
  State<TopSheet> createState() => _TopSheetState();
}

class _TopSheetState extends State<TopSheet> {
  final FocusNode _searchFocusNode = FocusNode();
  String _query = '';

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  // Top of the file: reusable function

  Widget customChip({
    required String label,
    Color backgroundColor = Colors.white,
    Color borderColor = AppColors.divider,
    double borderRadius = 30,
    EdgeInsets? padding,
  }) {
    return Container(
      padding:
      padding ?? EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            source: Images.repeatClock,
            width: 20.w,
            height: 20.w,
            fit: BoxFit.contain,
            color: AppColors.greyIcon,
          ),
          SizedBox(width: 6.w),

          Container(
            constraints: BoxConstraints(maxWidth: 110.w),
            child: CustomText(label, color: AppColors.secondary),
          ),
        ],
      ),
    );
  }

  void _openRestaurant(Map<String, dynamic> item) {
    widget.onClose();
    context.pushNamed(ScreenNames.RESTAURANT_DETAIL, extra: item);
  }

  @override
  Widget build(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_searchFocusNode.hasFocus) {
          _searchFocusNode.requestFocus();
        }
      });

      final results = _query.trim().isEmpty
          ? <Map<String, dynamic>>[]
          : restaurantsForQuery(_query);
      final recent = dashboardRestaurants().take(4).toList();

      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Dim background
            GestureDetector(
              onTap: widget.onClose,
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
            // Sheet content
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .padding
                      .top + 10.h,
                  bottom: 12.h,
                  left: 16.w,
                  right: 16.w,
                ),
                width: double.infinity,
                // padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(35.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImage(
                          source: Images.backArrow,
                          height: 16.h,
                          width: 16.w,
                          color: AppColors.darkGrey,
                          onTap: widget.onClose,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: CustomText(
                            "Search for dishes & restaurants",
                            fontSize: 16.sp,
                            fontWeight: Fonts.light,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        SizedBox(width: 18.w),
                      ],
                    ),
                    SizedBox(height: 18.w),
                    CustomSearchBar(
                      key: const ValueKey("headerSearch"),
                      focusNode: _searchFocusNode,
                      placeholderTexts: [
                        "Try 'restaurants'",
                        "Try 'pizza'",
                        "Try 'Cake'",
                        "Try 'Sweet'",
                        "Try 'High Protein'",
                      ],
                      leftIcon: Images.search,
                      rightIcon1: Images.microphone,
                      rightIcon2Color: AppColors.mediumGrey,
                      rightIcon1Color: AppColors.primary,
                      leftIconColor: AppColors.mediumGrey,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(12)),
                        border: Border.all(color: AppColors.divider),
                      ),
                      onChanged: (value) => setState(() => _query = value),
                      onLeftIconTap: () {},
                    ),
                    SizedBox(height: 10.h),
                    if (_query.trim().isNotEmpty) ...[
                      CustomText(
                        results.isEmpty
                            ? 'NO RESTAURANTS FOUND'
                            : 'MATCHING RESTAURANTS',
                        fontWeight: Fonts.medium,
                        fontSize: 12.sp,
                      ),
                      SizedBox(height: 14.h),
                      if (results.isEmpty)
                        CustomText(
                          'Try pizza, momo, or cafe',
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        )
                      else
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 240.h),
                          child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemCount: results.length,
                            separatorBuilder: (_, __) => SizedBox(height: 2.h),
                            itemBuilder: (context, index) {
                              final item = results[index];
                              return InkWell(
                                onTap: () => _openRestaurant(item),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  child: Row(
                                    children: [
                                      CustomImage(
                                        source: item['image']?.toString(),
                                        isNetwork: true,
                                        height: 40.w,
                                        width: 40.w,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomText(
                                              '${item['restaurant'] ?? ''}',
                                              fontSize: 14.sp,
                                              fontWeight: Fonts.semiBold,
                                            ),
                                            CustomText(
                                              '${item['categories'] ?? ''}',
                                              fontSize: 12.sp,
                                              color: AppColors.textSecondary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ] else ...[
                    Row(
                      children: [
                        CustomText(
                          "RECENTLY SEARCHED RESTAURANTS",
                          // fontSize: 16.sp,
                          fontWeight: Fonts.medium,
                          // color: AppColors.darkGrey,
                        ),
                        SizedBox(width: 12.h),
                        Expanded(
                          child: CustomImage(
                            source: Images.shadedLine,
                            height: 1.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: [
                        for (final item in recent)
                          GestureDetector(
                            onTap: () => _openRestaurant(item),
                            child: customChip(
                              label: '${item['restaurant'] ?? ''}',
                            ),
                          ),
                      ],
                    ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
