import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/utils/Constants.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../features/cart/provider/cart_provider.dart';
import '../route/screenNames.dart';
import 'CustomDivider.dart';

/// Resolves full restaurant JSON for navigation, or a minimal map from cart context.
Map<String, dynamic> _restaurantPayloadForNavigation(
  String restaurantName,
  String fallbackImageUrl,
) {
  final n = restaurantName.trim();
  for (final r in restaurants) {
    final rn = (r['restaurant'] ?? r['title'] ?? '').toString().trim();
    if (rn == n) {
      return Map<String, dynamic>.from(r);
    }
  }
  return <String, dynamic>{
    'restaurant': n,
    'title': n,
    'image': fallbackImageUrl,
    'rating': '4.5',
    'reviews': '—',
    'deliveryTime': '25–35 min',
    'address': '',
    'categories': 'Food delivery',
    'menu': <dynamic>[],
  };
}

class CustomBottomBar extends ConsumerStatefulWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  ConsumerState<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends ConsumerState<CustomBottomBar> {
  void _showClearCartDialog(BuildContext context, String restaurantName, List<CartItem> items) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: CustomText(
          'Clear Cart?',
          fontWeight: Fonts.bold,
          fontSize: 18.sp,
        ),
        content: CustomText(
          'Are you sure you want to remove all items from $restaurantName?',
          fontSize: 14.sp,
          maxLines: 3,
          color: AppColors.textSecondary,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: CustomText('Cancel', color: AppColors.textSecondary, fontWeight: Fonts.medium),
          ),
          TextButton(
            onPressed: () {
              final notifier = ref.read(cartProvider.notifier);
              for (final item in items) {
                notifier.removeLineCompletely(item.id);
              }
              Navigator.pop(ctx);
              // Silent removal - SnackBar removed per user request
            },
            child: CustomText('Clear', color: AppColors.red, fontWeight: Fonts.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Column(
      mainAxisSize: Map<String, dynamic>.from({}).isEmpty ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (cart.isEmpty)
          const SizedBox.shrink()
        else
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(24.w),
                topEnd: Radius.circular(24.w),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.divider.withValues(alpha: 0.4),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Consumer(
              builder: (context, ref, _) {
                // Group by restaurant
                final grouped = <String, List<CartItem>>{};
                for (final item in cart) {
                  grouped.putIfAbsent(item.restautantName, () => []).add(item);
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: grouped.entries.map((entry) {
                    final restaurantName = entry.key;
                    final items = entry.value;

                    // Use the first item's image as restaurant image
                    final image = items.first.image;

                    // Calculate total quantity and price for this restaurant
                    final totalQuantity = items.fold<int>(
                      0,
                      (sum, item) => sum + item.quantity,
                    );
                    final totalPrice = items.fold<double>(
                      0,
                      (sum, item) => sum + item.total,
                    );
                    return Container(
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          // Restaurant Image with errorBuilder null safety
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.network(
                              image,
                              width: 40.w,
                              height: 40.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 40.w,
                                  height: 40.h,
                                  color: AppColors.lightGrey,
                                  child: Icon(
                                    Icons.restaurant,
                                    color: AppColors.greyIcon,
                                    size: 20.w,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 8.w),

                          // Restaurant Name
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  restaurantName,
                                  fontSize: 15.sp,
                                  fontWeight: Fonts.semiBold,
                                  maxLines: 1,
                                ),
                                SizedBox(height: 2.h),
                                InkWell(
                                  onTap: () => context.pushNamed(
                                    ScreenNames.RESTAURANT_DETAIL,
                                    extra: _restaurantPayloadForNavigation(
                                      restaurantName,
                                      image,
                                    ),
                                  ),
                                  child: CustomText(
                                    "View full menu",
                                    fontWeight: Fonts.light,
                                    fontSize: 12.sp,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.w),

                          InkWell(
                            onTap: () => context.push(ScreenNames.CART),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.mediumGreen,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        '$totalQuantity Item${totalQuantity > 1 ? 's' : ''}',
                                        color: AppColors.white,
                                        fontSize: 11.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomDivider(
                                        isVertical: true,
                                        height: 10.h,
                                        thickness: 1,
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        '₹${totalPrice.toStringAsFixed(0)}',
                                        color: AppColors.white,
                                        fontSize: 11.sp,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  CustomText(
                                    'Checkout',
                                    color: AppColors.white,
                                    fontSize: 14.sp,
                                    fontWeight: Fonts.semiBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          GestureDetector(
                            onTap: () => _showClearCartDialog(context, restaurantName, items),
                            child: Container(
                              height: 40.h,
                              width: 32.w,
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: AppColors.lightRed,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                              ),
                              child: CustomImage(
                                source: Images.bin,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.divider,
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Home
              _BottomBarItem(
                index: 0,
                currentIndex: widget.currentIndex,
                imagePath: widget.currentIndex == 0
                    ? Images.homeFilled
                    : Images.home,
                onTap: widget.onTabSelected,
              ),

              /// Dining
              _BottomBarItem(
                index: 1,
                currentIndex: widget.currentIndex,
                imagePath: widget.currentIndex == 1
                    ? Images.diningFilled
                    : Images.dining,
                onTap: widget.onTabSelected,
              ),

              /// Favourites
              _BottomBarItem(
                index: 2,
                currentIndex: widget.currentIndex,
                imagePath: widget.currentIndex == 2
                    ? Images.heartFilled
                    : Images.heart,
                onTap: widget.onTabSelected,
              ),

              /// Reorder
              _BottomBarItem(
                index: 3,
                currentIndex: widget.currentIndex,
                imagePath: widget.currentIndex == 3
                    ? Images.reorderFilled
                    : Images.reorder,
                onTap: widget.onTabSelected,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String imagePath;
  final Function(int) onTap;

  const _BottomBarItem({
    required this.index,
    required this.currentIndex,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 4.w,
          bottom: 15.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(
              source: imagePath,
              height: 24.h,
              width: 24.w,
              isSvg: true,
              color: isSelected ? AppColors.primary : AppColors.mediumGrey,
            ),
            Container(
              margin: EdgeInsets.only(top: 4.h),
              child: isSelected
                  ? Container(
                      height: 4.h,
                      width: 4.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                    )
                  : SizedBox(height: 4.h, width: 4.w),
            ),
          ],
        ),
      ),
    );
  }
}
