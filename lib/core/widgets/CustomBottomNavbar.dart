import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/core/widgets/CustomLog.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../features/cart/provider/cart_provider.dart';
import '../route/screenNames.dart';
import 'CustomDivider.dart';

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
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (cart.isEmpty)
          const SizedBox.shrink()
        else
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(24.w),
                topEnd: Radius.circular(24.w),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.divider,
                  blurRadius: 5,
                  offset: Offset(0, -2),
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
                      margin: const EdgeInsets.symmetric(
                        // horizontal: 16,
                        // vertical: 8,
                      ),
                      child: Row(
                        children: [
                          // Restaurant Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              image,
                              width: 40.w,
                              height: 40.h,
                              fit: BoxFit.cover,
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
                                  fontSize: 18.sp,
                                  fontWeight: Fonts.semiBold,
                                ),
                                SizedBox(height: 2.h),
                                InkWell(
                                  onTap: () => context.pushNamed(
                                    ScreenNames.RESTAURANT_DETAIL,
                                    // queryParameters: {'id': restaurant.id},
                                  ),
                                  child: CustomText(
                                    "View full menu",
                                    fontWeight: Fonts.light,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () => context.push(ScreenNames.CART),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.mediumGreen,
                                borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(10.r),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        '$totalQuantity Item${totalQuantity > 1 ? 's' : ''}',
                                        color: AppColors.white,
                                      ),
                                      SizedBox(width: 6.w),
                                      CustomDivider(
                                        isVertical: true,
                                        height: 12.h,
                                        thickness: 2,
                                      ),
                                      SizedBox(width: 6.w),
                                      CustomText(
                                        '₹${totalPrice.toStringAsFixed(0)}',
                                        color: AppColors.white,
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    'Checkout',
                                    color: AppColors.white,
                                    fontSize: 20.sp,
                                    fontWeight: Fonts.semiBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Container(
                            height: 50.h,
                            width: 35.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightRed,
                              borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            child: CustomImage(
                              source: Images.bin,
                              color: AppColors.red,
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
            // borderRadius: BorderRadiusDirectional.only(
            //   topStart: Radius.circular(16.w),
            //   topEnd: Radius.circular(16.w),
            // ),
            boxShadow: [
              BoxShadow(
                color: AppColors.divider,
                blurRadius: 5,
                offset: Offset(0, -2),
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

              /// Cart button (special highlighted)
              // GestureDetector(
              //   onTap: () => onTabSelected(3),
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              //     decoration: BoxDecoration(
              //       color: Colors.orange,
              //       borderRadius: BorderRadius.circular(24),
              //     ),
              //     child: Row(
              //       children: [
              //         const Text(
              //           "4 Goods",
              //           style: TextStyle(color: Colors.white, fontSize: 14),
              //         ),
              //         const SizedBox(width: 6),
              //         Image.asset(
              //           "assets/icons/cart.png",
              //           height: 20,
              //           width: 20,
              //           color: Colors.white,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
        // color: Colors.green,
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
