import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/cart/provider/cart_provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailsScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    final rawItems = orderData['items'];
    final items = rawItems is List
        ? List<CartItem>.from(rawItems.map((item) => item as CartItem))
        : <CartItem>[];
    final restaurantName = orderData['restaurantName'] ?? 'Restaurant';
    final orderId = orderData['orderId'] ?? '—';
    final deliveryAddress =
        orderData['deliveryAddress'] ?? 'Address unavailable';
    final paymentMethod =
        orderData['paymentMethod'] ?? 'Payment method unavailable';
    final subtotal = (orderData['subtotal'] ?? 0.0).toDouble();
    final deliveryFee = (orderData['deliveryFee'] ?? 0.0).toDouble();
    final expressFee = (orderData['expressFee'] ?? 0.0).toDouble();
    final couponDiscount = (orderData['couponDiscount'] ?? 0.0).toDouble();
    final tip = (orderData['tip'] ?? 0.0).toDouble();
    final total = (orderData['total'] ?? 0.0).toDouble();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        title: const Text('Order details'),
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  restaurantName,
                  fontSize: 18.sp,
                  fontWeight: Fonts.bold,
                ),
                SizedBox(height: 4.h),
                CustomText('Order #$orderId', color: AppColors.textSecondary),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    const Icon(Icons.schedule, color: AppColors.mediumGreen),
                    SizedBox(width: 8.w),
                    CustomText(
                      'Preparing your order',
                      color: AppColors.mediumGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _section(
            title: 'Items',
            child: Column(
              children: [
                for (final item in items)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            '${item.quantity} × ${item.foodName}',
                          ),
                        ),
                        CustomText(
                          '₹${item.total.toStringAsFixed(0)}',
                          fontWeight: Fonts.bold,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _section(
            title: 'Delivery',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(deliveryAddress),
                if ((orderData['deliveryInstructions'] as String? ?? '')
                    .isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  CustomText(
                    'Instructions: ${orderData['deliveryInstructions']}',
                    color: AppColors.textSecondary,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _section(
            title: 'Payment',
            child: Column(
              children: [
                _amountRow('Item total', subtotal),
                _amountRow('Delivery fee', deliveryFee),
                if (expressFee > 0) _amountRow('Express delivery', expressFee),
                if (couponDiscount > 0)
                  _amountRow('Coupon discount', -couponDiscount),
                if (tip > 0) _amountRow('Tip', tip),
                Divider(height: 24.h, color: AppColors.divider),
                _amountRow('Total paid', total, bold: true),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    'Paid via $paymentMethod',
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section({String? title, required Widget child}) => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          CustomText(title, fontSize: 16.sp, fontWeight: Fonts.bold),
          SizedBox(height: 16.h),
        ],
        child,
      ],
    ),
  );

  Widget _amountRow(String label, double amount, {bool bold = false}) =>
      Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(label, fontWeight: bold ? Fonts.bold : Fonts.regular),
            CustomText(
              '${amount < 0 ? '-' : ''}₹${amount.abs().toStringAsFixed(0)}',
              fontWeight: bold ? Fonts.bold : Fonts.regular,
              color: amount < 0 ? AppColors.mediumGreen : Colors.transparent,
            ),
          ],
        ),
      );
}
