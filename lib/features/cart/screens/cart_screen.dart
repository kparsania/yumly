import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/utils/Constants.dart';
import 'package:yumly/core/route/screenNames.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/cart/provider/cart_provider.dart';
import 'package:yumly/features/cart/provider/checkout_address_provider.dart';
import 'package:yumly/features/cart/provider/coupon_provider.dart';
import 'package:yumly/features/cart/widgets/edit_cart_item_sheet.dart';

enum _CheckoutPayment { cashOnDelivery, card, googlePay }

enum _DeliverySpeed { express, standard, eco }

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  _CheckoutPayment _payment = _CheckoutPayment.googlePay;
  _DeliverySpeed _deliverySpeed = _DeliverySpeed.standard;
  int _checkoutTab = 0; // 0 delivery, 1 tip, 2 instructions
  final TextEditingController _customTipController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  bool _customTipMode = false;
  double _tipRupees = 0;

  @override
  void initState() {
    super.initState();
    _customTipController.addListener(_onCustomTipChanged);
  }

  void _onCustomTipChanged() {
    if (!_customTipMode || !mounted) return;
    final v = double.tryParse(_customTipController.text.trim()) ?? 0;
    setState(() => _tipRupees = v.clamp(0, 99999));
  }

  @override
  void dispose() {
    _customTipController.removeListener(_onCustomTipChanged);
    _instructionsController.dispose();
    _customTipController.dispose();
    super.dispose();
  }

  double _subtotal(CartNotifier n) => n.totalPrice();

  double _deliveryFee(double subtotal) => subtotal >= 99 ? 0 : 40;

  double _expressFee() => _deliverySpeed == _DeliverySpeed.express ? 19 : 0;

  double _savingsHint(double subtotal, double delivery) {
    if (subtotal <= 0) return 0;
    if (delivery == 0) return 1;
    return 1;
  }

  String _paymentLabel(_CheckoutPayment p) {
    switch (p) {
      case _CheckoutPayment.cashOnDelivery:
        return 'Cash on delivery';
      case _CheckoutPayment.card:
        return 'Credit / Debit card';
      case _CheckoutPayment.googlePay:
        return 'Google Pay';
    }
  }

  String _paymentShort(_CheckoutPayment p) {
    switch (p) {
      case _CheckoutPayment.cashOnDelivery:
        return 'Cash';
      case _CheckoutPayment.card:
        return 'Card';
      case _CheckoutPayment.googlePay:
        return 'Google Pay';
    }
  }

  Widget _paymentBrandIcon(_CheckoutPayment p, double size) {
    return _CheckoutPaymentSvgIcon(
      assetPath: switch (p) {
        _CheckoutPayment.googlePay => Images.checkoutGpay,
        _CheckoutPayment.cashOnDelivery => Images.checkoutCash,
        _CheckoutPayment.card => Images.checkoutCard,
      },
      size: size,
      fallbackIcon: switch (p) {
        _CheckoutPayment.googlePay => Icons.account_balance_wallet_outlined,
        _CheckoutPayment.cashOnDelivery => Icons.payments_outlined,
        _CheckoutPayment.card => Icons.credit_card_outlined,
      },
    );
  }

  Future<void> _pickPayment() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          padding: EdgeInsets.fromLTRB(
            20.w,
            12.h,
            20.w,
            24.h + MediaQuery.paddingOf(ctx).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomText('Pay using', fontSize: 18.sp, fontWeight: Fonts.bold),
              SizedBox(height: 12.h),
              ..._CheckoutPayment.values.map((e) {
                final selected = _payment == e;
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Material(
                    color: selected ? AppColors.lightPrimary : AppColors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14.r),
                      onTap: () {
                        setState(() => _payment = e);
                        Navigator.pop(ctx);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 14.h,
                        ),
                        child: Row(
                          children: [
                            _paymentBrandIcon(e, 28.w),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: CustomText(
                                _paymentLabel(e),
                                fontWeight: Fonts.medium,
                              ),
                            ),
                            Icon(
                              selected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.greyIcon,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _placeOrder(double total) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order placed with ${_paymentShort(_payment)} • ₹${total.toStringAsFixed(0)}',
        ),
      ),
    );
  }

  void _selectTipPreset(double amount) {
    setState(() {
      _customTipMode = false;
      _tipRupees = amount;
      _customTipController.clear();
    });
  }

  void _selectTipCustom() {
    setState(() {
      _customTipMode = true;
      final v = double.tryParse(_customTipController.text.trim()) ?? 0;
      _tipRupees = v;
    });
  }

  void _onMealAddonAdd(MealAddonItem m) {
    final cart = ref.read(cartProvider);
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add items from a restaurant menu first.'),
        ),
      );
      return;
    }
    final rest = cart.first.restautantName;
    final price =
        double.tryParse(m.priceDisplay.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    final lineId = Object.hash(rest, m.dishName, price.round());
    ref
        .read(cartProvider.notifier)
        .addToCart(
          CartItem(
            id: lineId,
            restautantName: rest,
            foodName: m.dishName,
            image: m.imageUrl.trim(),
            price: price,
          ),
        );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${m.dishName} added')));
  }

  void _openAddressPicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Consumer(
          builder: (context, ref, _) {
            final list = ref.watch(checkoutAddressListProvider);
            var pick = ref.watch(selectedCheckoutAddressIdProvider);
            return StatefulBuilder(
              builder: (context, setModal) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(
                    20.w,
                    12.h,
                    20.w,
                    24.h + MediaQuery.paddingOf(ctx).bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: AppColors.divider,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomText(
                        'Choose your location',
                        fontSize: 18.sp,
                        fontWeight: Fonts.bold,
                      ),
                      SizedBox(height: 12.h),
                      ...list.map(
                        (a) => RadioListTile<String>(
                          value: a.id,
                          groupValue: pick,
                          activeColor: AppColors.primary,
                          onChanged: (v) {
                            if (v != null) setModal(() => pick = v);
                          },
                          title: CustomText(
                            a.label,
                            fontWeight: Fonts.bold,
                            fontSize: 14.sp,
                          ),
                          subtitle: CustomText(
                            a.line,
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          context.pushNamed(ScreenNames.ADDRESSES);
                        },
                        child: CustomText(
                          'Manage addresses',
                          color: AppColors.primary,
                          fontWeight: Fonts.medium,
                        ),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          ref
                                  .read(
                                    selectedCheckoutAddressIdProvider.notifier,
                                  )
                                  .state =
                              pick;
                          Navigator.pop(ctx);
                        },
                        child: CustomText(
                          'Save',
                          color: AppColors.white,
                          fontWeight: Fonts.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _checkoutTabContent() {
    switch (_checkoutTab) {
      case 0:
        return _DeliveryOptionsCard(
          speed: _deliverySpeed,
          onChanged: (v) => setState(() => _deliverySpeed = v),
        );
      case 1:
        return _TipCheckoutPanel(
          customTipMode: _customTipMode,
          tipRupees: _tipRupees,
          customController: _customTipController,
          onPreset: _selectTipPreset,
          onPickCustom: _selectTipCustom,
        );
      case 2:
        return _DeliveryInstructionsCard(controller: _instructionsController);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final appliedCoupon = ref.watch(appliedCouponProvider);
    final subtotal = _subtotal(notifier);
    final delivery = _deliveryFee(subtotal);
    final express = _expressFee();
    final couponRaw = appliedCoupon?.offer.discountRupee ?? 0;
    final couponOff = min(couponRaw, subtotal);
    final tip = _tipRupees;
    final total = (subtotal + delivery + express + tip - couponOff).clamp(
      0.0,
      1e12,
    );
    final restaurantName = cart.isEmpty
        ? 'Your order'
        : cart.first.restautantName;
    final saved = _savingsHint(subtotal, delivery);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: cart.isEmpty
          ? _EmptyCart(
              onBrowse: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(ScreenNames.BOTTOM_TABS);
                }
              },
            )
          : Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: _HeaderBlock()),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 8.h),
                              CustomText(
                                restaurantName,
                                fontSize: 20.sp,
                                fontWeight: Fonts.bold,
                                maxLines: 2,
                              ),
                              SizedBox(height: 12.h),
                              _AddressCard(onOpenPicker: _openAddressPicker),
                              SizedBox(height: 10.h),
                              _SavingsBanner(savedRupee: saved),
                              SizedBox(height: 18.h),
                              _SectionTitle('Your order'),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final item = cart[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: _CartLineCard(
                                item: item,
                                onDec: () => notifier.removeFromCart(item.id),
                                onInc: () => notifier.addToCart(item),
                                onEdit: () => showEditCartItemBottomSheet(
                                  context: context,
                                  ref: ref,
                                  item: item,
                                ),
                              ),
                            );
                          }, childCount: cart.length),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _CompleteMealStrip(
                                items: kMealAddonCatalog,
                                onAddItem: _onMealAddonAdd,
                              ),
                              SizedBox(height: 20.h),
                              _SavingsCornerCard(
                                onApplyTap: () =>
                                    context.pushNamed(ScreenNames.COUPONS),
                              ),
                              SizedBox(height: 20.h),
                              _DeliveryTabs(
                                index: _checkoutTab,
                                onChanged: (i) =>
                                    setState(() => _checkoutTab = i),
                              ),
                              SizedBox(height: 12.h),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 280),
                                curve: Curves.easeOutCubic,
                                alignment: Alignment.topCenter,
                                child: _checkoutTabContent(),
                              ),
                              SizedBox(height: 20.h),
                              _SectionTitle('Payment method'),
                              SizedBox(height: 10.h),
                              _PaymentTiles(
                                selected: _payment,
                                onSelect: (p) => setState(() => _payment = p),
                                brandIcon: _paymentBrandIcon,
                                label: _paymentLabel,
                              ),
                              SizedBox(height: 20.h),
                              _OrderSummaryCard(
                                subtotal: subtotal,
                                delivery: delivery,
                                express: express,
                                tip: tip,
                                couponOff: couponOff,
                                couponLabel: appliedCoupon?.offer.title,
                                total: total,
                              ),
                              SizedBox(height: 14.h),
                              CustomText(
                                'Orders cannot be cancelled once the restaurant starts preparing your food. '
                                'Refunds are subject to partner policy.',
                                fontSize: 11.sp,
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                              SizedBox(height: 120.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _BottomPayBar(
                  total: total,
                  payment: _payment,
                  paymentShort: _paymentShort,
                  brandIcon: _paymentBrandIcon,
                  onPickPayment: _pickPayment,
                  onPay: () => _placeOrder(total),
                ),
              ],
            ),
    );
  }
}

class _HeaderBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, top + 4.h, 12.w, 8.h),
      color: const Color(0xFFF3F4F6),
      child: Row(
        children: [
          Material(
            color: AppColors.white,
            elevation: 2,
            shadowColor: Colors.black26,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => context.pop(),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Icon(
                  Icons.arrow_back,
                  size: 20.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              'Checkout',
              textAlign: TextAlign.center,
              fontSize: 18.sp,
              fontWeight: Fonts.bold,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: AppColors.textPrimary,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressCard extends ConsumerWidget {
  const _AddressCard({required this.onOpenPicker});

  final VoidCallback onOpenPicker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(checkoutAddressListProvider);
    final id = ref.watch(selectedCheckoutAddressIdProvider);
    final match = list.where((e) => e.id == id);
    final a = match.isEmpty
        ? (list.isNotEmpty ? list.first : null)
        : match.first;
    final label = a?.label ?? 'Address';
    final line = a?.line ?? 'Tap to choose delivery location';

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onOpenPicker,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.work_outline_rounded,
                color: AppColors.textPrimary,
                size: 22.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(label, fontWeight: Fonts.bold, fontSize: 15.sp),
                    SizedBox(height: 4.h),
                    CustomText(
                      line,
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.greyIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavingsBanner extends StatelessWidget {
  const _SavingsBanner({required this.savedRupee});

  final double savedRupee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.mediumGreen.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, size: 18.sp, color: AppColors.mediumGreen),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              '₹${savedRupee.toStringAsFixed(0)} saved! Including delivery fee savings.',
              fontSize: 12.sp,
              fontWeight: Fonts.medium,
              color: AppColors.mediumGreen,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(title, fontSize: 17.sp, fontWeight: Fonts.bold);
  }
}

class _CartLineCard extends StatelessWidget {
  const _CartLineCard({
    required this.item,
    required this.onDec,
    required this.onInc,
    required this.onEdit,
  });

  final CartItem item;
  final VoidCallback onDec;
  final VoidCallback onInc;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: CustomImage(
              source: Images.veg,
              isSvg: true,
              width: 16.w,
              height: 16.w,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  item.foodName,
                  fontWeight: Fonts.bold,
                  fontSize: 14.sp,
                  maxLines: 2,
                ),
                SizedBox(height: 4.h),
                InkWell(
                  onTap: onEdit,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        'Edit',
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 14.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              _ZomatoStyleQty(onDec: onDec, onInc: onInc, qty: item.quantity),
              SizedBox(height: 6.h),
              CustomText(
                '₹${item.total.toStringAsFixed(0)}',
                fontWeight: Fonts.bold,
                fontSize: 15.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ZomatoStyleQty extends StatelessWidget {
  const _ZomatoStyleQty({
    required this.onDec,
    required this.onInc,
    required this.qty,
  });

  final VoidCallback onDec;
  final VoidCallback onInc;
  final int qty;

  @override
  Widget build(BuildContext context) {
    final softBorder = Color.lerp(AppColors.primary, AppColors.white, 0.65)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: softBorder, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onDec,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Icon(Icons.remove, size: 16.sp, color: AppColors.primary),
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 24.w),
            alignment: Alignment.center,
            child: CustomText(
              '$qty',
              fontWeight: Fonts.bold,
              fontSize: 14.sp,
              color: AppColors.blackSecondary,
            ),
          ),
          InkWell(
            onTap: onInc,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Icon(Icons.add, size: 16.sp, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _completeMealImageFallback() {
  return Container(
    color: AppColors.lightGrey,
    alignment: Alignment.center,
    child: Icon(Icons.lunch_dining, color: AppColors.greyIcon, size: 26.sp),
  );
}

class _CompleteMealStrip extends StatelessWidget {
  const _CompleteMealStrip({required this.items, required this.onAddItem});

  final List<MealAddonItem> items;
  final void Function(MealAddonItem item) onAddItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 0, 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Complete your meal',
            fontWeight: Fonts.bold,
            fontSize: 15.sp,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 124.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemBuilder: (context, i) {
                final m = items[i];
                final name = m.dishName;
                final price = m.priceDisplay;
                return Material(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () => onAddItem(m),
                    child: Container(
                      width: 108.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: SizedBox(
                                  height: 54.h,
                                  width: double.infinity,
                                  child: m.imageUrl.trim().isNotEmpty
                                      ? Image.network(
                                          m.imageUrl.trim(),
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, p) {
                                            if (p == null) return child;
                                            return Container(
                                              color: AppColors.lightGrey,
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                width: 18.w,
                                                height: 18.w,
                                                child:
                                                    const CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (_, __, ___) =>
                                              _completeMealImageFallback(),
                                        )
                                      : _completeMealImageFallback(),
                                ),
                              ),
                              Positioned(
                                left: 4,
                                bottom: 4,
                                child: CustomImage(
                                  source: Images.veg,
                                  isSvg: true,
                                  width: 12.w,
                                  height: 12.w,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: CustomImage(
                                    source: Images.add,
                                    isSvg: true,
                                    width: 12.w,
                                    height: 12.w,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          CustomText(
                            name,
                            fontSize: 11.sp,
                            fontWeight: Fonts.medium,
                            maxLines: 2,
                          ),
                          CustomText(
                            price,
                            fontWeight: Fonts.bold,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SavingsCornerCard extends ConsumerWidget {
  const _SavingsCornerCard({required this.onApplyTap});

  final VoidCallback onApplyTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applied = ref.watch(appliedCouponProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.local_offer_outlined, color: AppColors.primary),
            title: CustomText('Apply coupon', fontWeight: Fonts.medium),
            trailing: Icon(Icons.chevron_right, color: AppColors.greyIcon),
            onTap: onApplyTap,
          ),
          if (applied != null) ...[
            Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.6)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.sell_outlined, color: AppColors.primary),
              title: CustomText(
                '${applied.offer.title} · ${applied.offer.code}',
                fontSize: 13.sp,
                fontWeight: Fonts.medium,
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.mediumGreen,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      'Applied · ₹${applied.offer.discountRupee.toStringAsFixed(0)} off',
                      fontSize: 12.sp,
                      color: AppColors.mediumGreen,
                      fontWeight: Fonts.medium,
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.close, size: 20.sp, color: AppColors.greyIcon),
                onPressed: () =>
                    ref.read(appliedCouponProvider.notifier).state = null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DeliveryTabs extends StatelessWidget {
  const _DeliveryTabs({required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final labels = ['Delivery type', 'Tip', 'Instructions'];
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E9EC),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: List.generate(3, (i) {
          final sel = index == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: sel ? AppColors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  labels[i],
                  textAlign: TextAlign.center,
                  fontSize: 11.sp,
                  fontWeight: sel ? Fonts.semiBold : Fonts.medium,
                  color: sel ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _DeliveryOptionsCard extends StatelessWidget {
  const _DeliveryOptionsCard({required this.speed, required this.onChanged});

  final _DeliverySpeed speed;
  final ValueChanged<_DeliverySpeed> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 68.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 52.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFFFFF0EB),
                          AppColors.lightPrimary,
                          AppColors.primary,
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            'Delivering superfast!',
                            fontWeight: Fonts.semiBold,
                            fontSize: 13.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 4.w,
                  bottom: 0,
                  child: ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ).createShader(bounds);
                    },
                    child: Image.asset(
                      Images.checkoutDeliveryManSticker,
                      height: 75.h,
                      width: 60.w,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          _DeliveryRadioTile(
            title: 'Express',
            subtitle: 'Fastest delivery, directly to you!',
            time: '15–20 mins',
            selected: speed == _DeliverySpeed.express,
            onTap: () => onChanged(_DeliverySpeed.express),
            highlight: true,
          ),
          _DeliveryRadioTile(
            title: 'Standard',
            subtitle: 'Minimal order grouping',
            time: '20–25 mins',
            selected: speed == _DeliverySpeed.standard,
            onTap: () => onChanged(_DeliverySpeed.standard),
            highlight: false,
          ),
          _DeliveryRadioTile(
            title: 'Eco saver',
            subtitle: 'Lesser CO₂ by order grouping',
            time: '25–35 mins',
            selected: speed == _DeliverySpeed.eco,
            onTap: () => onChanged(_DeliverySpeed.eco),
            highlight: false,
          ),
        ],
      ),
    );
  }
}

class _DeliveryRadioTile extends StatelessWidget {
  const _DeliveryRadioTile({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.selected,
    required this.onTap,
    required this.highlight,
  });

  final String title;
  final String subtitle;
  final String time;
  final bool selected;
  final VoidCallback onTap;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final accent = highlight ? const Color(0xFFE65100) : AppColors.primary;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: selected
            ? (highlight ? const Color(0xFFFFF3E0) : AppColors.lightPrimary)
            : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected ? accent : AppColors.greyIcon,
                  size: 22.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (highlight)
                        Row(
                          children: [
                            CustomText(
                              'Express ',
                              fontSize: 13.sp,
                              fontWeight: Fonts.bold,
                              color: accent,
                            ),
                            Text(
                              '₹29',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: Fonts.bold,
                                color: accent,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: accent,
                              ),
                            ),
                            CustomText(
                              '  ₹19',
                              fontSize: 13.sp,
                              fontWeight: Fonts.bold,
                              color: accent,
                            ),
                            const Spacer(),
                            CustomText(
                              time,
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                title,
                                fontWeight: Fonts.bold,
                                fontSize: 14.sp,
                                color: selected
                                    ? accent
                                    : AppColors.textPrimary,
                              ),
                            ),
                            CustomText(
                              time,
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      if (highlight) ...[
                        SizedBox(height: 4.h),
                        CustomText(
                          title,
                          fontWeight: Fonts.bold,
                          fontSize: 14.sp,
                          color: accent,
                        ),
                        SizedBox(height: 2.h),
                        CustomText(
                          subtitle,
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ] else ...[
                        SizedBox(height: 2.h),
                        CustomText(
                          subtitle,
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentTiles extends StatelessWidget {
  const _PaymentTiles({
    required this.selected,
    required this.onSelect,
    required this.brandIcon,
    required this.label,
  });

  final _CheckoutPayment selected;
  final ValueChanged<_CheckoutPayment> onSelect;
  final Widget Function(_CheckoutPayment, double) brandIcon;
  final String Function(_CheckoutPayment) label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _CheckoutPayment.values.map((e) {
        final sel = selected == e;
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Material(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            elevation: sel ? 2 : 0,
            shadowColor: Colors.black26,
            child: InkWell(
              borderRadius: BorderRadius.circular(14.r),
              onTap: () => onSelect(e),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: sel ? AppColors.primary : AppColors.divider,
                    width: sel ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    brandIcon(e, 30.w),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomText(
                        label(e),
                        fontWeight: Fonts.medium,
                        fontSize: 14.sp,
                      ),
                    ),
                    Icon(
                      sel ? Icons.check_circle : Icons.circle_outlined,
                      color: sel ? AppColors.primary : AppColors.greyIcon,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({
    required this.subtotal,
    required this.delivery,
    required this.express,
    required this.tip,
    required this.couponOff,
    this.couponLabel,
    required this.total,
  });

  final double subtotal;
  final double delivery;
  final double express;
  final double tip;
  final double couponOff;
  final String? couponLabel;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _SummaryRow(label: 'Subtotal', value: subtotal),
          SizedBox(height: 8.h),
          _SummaryRow(
            label: 'Delivery charge',
            value: delivery,
            hint: delivery == 0 ? 'FREE' : null,
          ),
          if (express > 0) ...[
            SizedBox(height: 8.h),
            _SummaryRow(label: 'Express fee', value: express),
          ],
          if (tip > 0) ...[
            SizedBox(height: 8.h),
            _SummaryRow(label: 'Tip', value: tip),
          ],
          if (couponOff > 0) ...[
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    couponLabel != null
                        ? 'Coupon ($couponLabel)'
                        : 'Coupon discount',
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                    maxLines: 2,
                  ),
                ),
                CustomText(
                  '− ₹${couponOff.toStringAsFixed(0)}',
                  fontSize: 14.sp,
                  fontWeight: Fonts.medium,
                  color: AppColors.mediumGreen,
                ),
              ],
            ),
          ],
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: CustomPaint(
              painter: _DashedLinePainter(color: AppColors.divider),
              child: SizedBox(height: 1, width: double.infinity),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText('Total', fontWeight: Fonts.bold, fontSize: 16.sp),
              CustomText(
                '₹${total.toStringAsFixed(0)}',
                fontWeight: Fonts.bold,
                fontSize: 18.sp,
              ),
            ],
          ),
          if (delivery == 0)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: CustomText(
                        'Free delivery on orders above ₹99',
                        fontSize: 11.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.hint});

  final String label;
  final double value;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(label, fontSize: 14.sp, color: AppColors.textSecondary),
        if (hint != null && value == 0)
          CustomText(
            hint!,
            fontSize: 14.sp,
            fontWeight: Fonts.bold,
            color: AppColors.mediumGreen,
          )
        else
          CustomText(
            '₹${value.toStringAsFixed(0)}',
            fontSize: 14.sp,
            fontWeight: Fonts.medium,
          ),
      ],
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const dash = 5.0;
    const gap = 4.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dash, 0), paint);
      x += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BottomPayBar extends StatelessWidget {
  const _BottomPayBar({
    required this.total,
    required this.payment,
    required this.paymentShort,
    required this.brandIcon,
    required this.onPickPayment,
    required this.onPay,
  });

  final double total;
  final _CheckoutPayment payment;
  final String Function(_CheckoutPayment) paymentShort;
  final Widget Function(_CheckoutPayment, double) brandIcon;
  final VoidCallback onPickPayment;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Material(
      elevation: 12,
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, bottom + 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onPickPayment,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 4.w,
                      ),
                      child: Row(
                        children: [
                          brandIcon(payment, 26.w),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      'PAY USING',
                                      fontSize: 10.sp,
                                      color: AppColors.textSecondary,
                                      fontWeight: Fonts.medium,
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      size: 14.sp,
                                      color: AppColors.textSecondary,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                CustomText(
                                  paymentShort(payment),
                                  fontWeight: Fonts.bold,
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 0,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.mediumGreen,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    onPressed: onPay,
                    child: Text(
                      'Pay ₹${total.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontFamily: Fonts.fontFamilyGilroy,
                        fontWeight: Fonts.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TipCheckoutPanel extends StatelessWidget {
  const _TipCheckoutPanel({
    required this.customTipMode,
    required this.tipRupees,
    required this.customController,
    required this.onPreset,
    required this.onPickCustom,
  });

  final bool customTipMode;
  final double tipRupees;
  final TextEditingController customController;
  final void Function(double amount) onPreset;
  final VoidCallback onPickCustom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            'Tip your delivery partner',
            fontWeight: Fonts.bold,
            fontSize: 15.sp,
          ),
          SizedBox(height: 4.h),
          CustomText(
            '100% goes to your partner · added to bill',
            fontSize: 11.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _TipChip(
                label: 'No tip',
                selected: !customTipMode && tipRupees == 0,
                onTap: () => onPreset(0),
              ),
              _TipChip(
                label: '₹10',
                selected: !customTipMode && tipRupees == 10,
                onTap: () => onPreset(10),
              ),
              _TipChip(
                label: '₹20',
                selected: !customTipMode && tipRupees == 20,
                onTap: () => onPreset(20),
              ),
              _TipChip(
                label: '₹30',
                selected: !customTipMode && tipRupees == 30,
                onTap: () => onPreset(30),
              ),
              _TipChip(
                label: 'Other',
                selected: customTipMode,
                onTap: onPickCustom,
              ),
            ],
          ),
          if (customTipMode) ...[
            SizedBox(height: 12.h),
            TextField(
              controller: customController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: InputDecoration(
                hintText: 'Enter amount (₹)',
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TipChip extends StatelessWidget {
  const _TipChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.black : const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: CustomText(
            label,
            fontSize: 13.sp,
            fontWeight: Fonts.medium,
            color: selected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _DeliveryInstructionsCard extends StatelessWidget {
  const _DeliveryInstructionsCard({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            'Delivery instructions',
            fontWeight: Fonts.bold,
            fontSize: 15.sp,
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'e.g. Ring the bell, leave at door...',
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.divider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Loads checkout payment SVGs via [rootBundle] so missing/empty assets fail gracefully.
class _CheckoutPaymentSvgIcon extends StatefulWidget {
  const _CheckoutPaymentSvgIcon({
    required this.assetPath,
    required this.size,
    required this.fallbackIcon,
  });

  final String assetPath;
  final double size;
  final IconData fallbackIcon;

  @override
  State<_CheckoutPaymentSvgIcon> createState() =>
      _CheckoutPaymentSvgIconState();
}

class _CheckoutPaymentSvgIconState extends State<_CheckoutPaymentSvgIcon> {
  late final Future<ByteData?> _loadFuture = _load();

  Future<ByteData?> _load() async {
    try {
      final data = await rootBundle.load(widget.assetPath);
      if (data.lengthInBytes == 0) return null;
      return data;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ByteData?>(
      future: _loadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(width: widget.size, height: widget.size);
        }
        final data = snapshot.data;
        if (snapshot.hasError || data == null) {
          return Icon(
            widget.fallbackIcon,
            size: widget.size,
            color: AppColors.textPrimary,
          );
        }
        return SvgPicture.memory(
          data.buffer.asUint8List(),
          width: widget.size,
          height: widget.size,
          fit: BoxFit.contain,
        );
      },
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.onBrowse});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 72.sp,
              color: AppColors.greyIcon,
            ),
            SizedBox(height: 16.h),
            CustomText(
              'Your cart is empty',
              fontSize: 20.sp,
              fontWeight: Fonts.bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            CustomText(
              'Add something delicious — we’ll show savings, delivery options, and payment here.',
              textAlign: TextAlign.center,
              color: AppColors.textSecondary,
              fontSize: 14.sp,
            ),
            SizedBox(height: 28.h),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
              onPressed: onBrowse,
              child: const Text('Back to browsing'),
            ),
          ],
        ),
      ),
    );
  }
}
