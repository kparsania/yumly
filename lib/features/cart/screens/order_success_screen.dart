import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumly/core/route/screenNames.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../../core/widgets/CustomImage.dart';
import '../provider/cart_provider.dart';

class OrderSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderSuccessScreen({super.key, required this.orderData});

  Future<void> _shareOrder(
    List<CartItem> items,
    String orderId,
    String restaurant,
    double total,
  ) async {
    final itemDetails = items
        .map((i) => "${i.quantity}x ${i.foodName}")
        .join(", ");
    final shareText =
        "Hey! I just ordered $itemDetails from $restaurant on Yumly. \nOrder ID: #$orderId\nTotal Amount: ₹${total.toStringAsFixed(0)}";
    await SharePlus.instance.share(
      ShareParams(
        text: shareText,
      ),
    );
  }

  Future<void> _trackOrder(String restaurantName) async {
    final query = Uri.encodeComponent(restaurantName);
    final googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$query";
    final appleMapsUrl = "https://maps.apple.com/?q=$query";

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
      await launchUrl(Uri.parse(appleMapsUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final rawItems = orderData['items'];
    final List<CartItem> items = (rawItems is List)
        ? List<CartItem>.from(rawItems.map((e) => e as CartItem))
        : <CartItem>[];

    final String restaurantName = orderData['restaurantName'] ?? 'Restaurant';
    final double subtotal = (orderData['subtotal'] ?? 0.0).toDouble();
    final double deliveryFee = (orderData['deliveryFee'] ?? 0.0).toDouble();
    final double couponDiscount = (orderData['couponDiscount'] ?? 0.0)
        .toDouble();
    final double tip = (orderData['tip'] ?? 0.0).toDouble();
    final double total = (orderData['total'] ?? 0.0).toDouble();
    final String deliveryTime = orderData['deliveryTime'] ?? '30-40 mins';
    final String orderId =
        orderData['orderId'] ??
        'GN${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final String placedAt = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    'No order data found.',
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16.h),
                  FilledButton(
                    onPressed: () => context.go(ScreenNames.BOTTOM_TABS),
                    child: const Text('Go Home'),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 350.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: CustomText(
                          'Yay! Your delicious food is on the way.\nGet ready to enjoy!',
                          textAlign: TextAlign.center,
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.lightGreen,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: const BoxDecoration(
                                color: AppColors.lightGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.delivery_dining,
                                color: AppColors.mediumGreen,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    'Your order is confirmed',
                                    fontWeight: Fonts.bold,
                                    color: AppColors.mediumGreen,
                                  ),
                                  CustomText(
                                    'We\'ll let you know once it\'s out for delivery.',
                                    fontSize: 12.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AppColors.greyIcon,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      'Order #$orderId',
                                      fontWeight: Fonts.bold,
                                      fontSize: 16.sp,
                                    ),
                                    CustomText(
                                      'Placed on $placedAt',
                                      fontSize: 12.sp,
                                      color: AppColors.textSecondary,
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGreen,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 6.w,
                                        height: 6.w,
                                        decoration: const BoxDecoration(
                                          color: AppColors.mediumGreen,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        'Preparing',
                                        fontSize: 11.sp,
                                        color: AppColors.mediumGreen,
                                        fontWeight: Fonts.semiBold,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            ...items.map(
                              (item) => Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: (item.image.startsWith('http'))
                                          ? Image.network(
                                              item.image,
                                              width: 50.w,
                                              height: 50.w,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) =>
                                                  Image.asset(
                                                    Images.noImage,
                                                    width: 50.w,
                                                    height: 50.w,
                                                  ),
                                            )
                                          : Image.asset(
                                              Images.noImage,
                                              width: 50.w,
                                              height: 50.w,
                                            ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            item.foodName,
                                            fontWeight: Fonts.bold,
                                            fontSize: 14.sp,
                                          ),
                                          CustomText(
                                            '${item.quantity} item${item.quantity > 1 ? 's' : ''}',
                                            fontSize: 12.sp,
                                            color: AppColors.textSecondary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomText(
                                      '₹${item.total.toStringAsFixed(0)}',
                                      fontWeight: Fonts.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Divider(color: AppColors.divider),
                            SizedBox(height: 8.h),
                            _buildSummaryRow(
                              'Item Total',
                              '₹${subtotal.toStringAsFixed(0)}',
                            ),
                            _buildSummaryRow(
                              'Delivery Fee',
                              deliveryFee == 0
                                  ? 'FREE'
                                  : '₹${deliveryFee.toStringAsFixed(0)}',
                              color: deliveryFee == 0
                                  ? AppColors.mediumGreen
                                  : null,
                            ),
                            if (couponDiscount > 0)
                              _buildSummaryRow(
                                'Coupon Discount',
                                '- ₹${couponDiscount.toStringAsFixed(0)}',
                                color: AppColors.mediumGreen,
                              ),
                            if (tip > 0)
                              _buildSummaryRow(
                                'Tip',
                                '₹${tip.toStringAsFixed(0)}',
                              ),

                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  'Total Paid',
                                  fontWeight: Fonts.bold,
                                  fontSize: 18.sp,
                                ),
                                CustomText(
                                  '₹${total.toStringAsFixed(0)}',
                                  fontWeight: Fonts.bold,
                                  fontSize: 18.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: AppColors.primary,
                              size: 28.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    'Estimated Delivery Time',
                                    fontSize: 11.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                  CustomText(
                                    deliveryTime,
                                    fontWeight: Fonts.bold,
                                    fontSize: 18.sp,
                                  ),
                                ],
                              ),
                            ),
                            FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.lightGreen,
                                foregroundColor: AppColors.mediumGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              onPressed: () => _trackOrder(restaurantName),
                              icon: Icon(Icons.location_on, size: 16.sp),
                              label: CustomText(
                                'Track Order',
                                fontSize: 12.sp,
                                fontWeight: Fonts.bold,
                                color: AppColors.mediumGreen,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  side: BorderSide(color: AppColors.divider),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.assignment_outlined,
                                  size: 18.sp,
                                  color: AppColors.textPrimary,
                                ),
                                label: CustomText(
                                  'View Order Details',
                                  fontWeight: Fonts.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  side: BorderSide(color: AppColors.divider),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                onPressed: () => _shareOrder(
                                  items,
                                  orderId,
                                  restaurantName,
                                  total,
                                ),
                                icon: Icon(
                                  Icons.share_outlined,
                                  size: 18.sp,
                                  color: AppColors.textPrimary,
                                ),
                                label: CustomText(
                                  'Share Order',
                                  fontWeight: Fonts.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEB),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    'Craving something else?',
                                    fontWeight: Fonts.bold,
                                    fontSize: 14.sp,
                                  ),
                                  CustomText(
                                    'Explore more delicious options now!',
                                    fontSize: 11.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            ),
                            Image.asset(Images.burger, height: 75.h),
                            SizedBox(width: 8.w),
                            Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: SizedBox(
                                height: 30.h,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  onPressed: () =>
                                      context.go(ScreenNames.BOTTOM_TABS),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        'Order Again',
                                        color: AppColors.white,
                                        fontSize: 11.sp,
                                        fontWeight: Fonts.bold,
                                      ),
                                      SizedBox(width: 2.w),
                                      Icon(
                                        Icons.chevron_right,
                                        size: 14.sp,
                                        color: AppColors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),

                Column(
                  children: [
                    CustomImage(
                      source: Images.orderPlacedBg,
                      width: double.infinity,
                      height: 330.h,
                    ),
                    Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFF8FAF8), Colors.white12],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(label, fontSize: 13.sp, color: AppColors.textSecondary),
          CustomText(
            value,
            fontWeight: Fonts.medium,
            fontSize: 13.sp,
            color: color ?? AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
