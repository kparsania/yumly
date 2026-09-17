import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/features/cart/data/coupons_data.dart';

class AppliedCouponState {
  const AppliedCouponState({required this.offer});

  final CouponOffer offer;
}

final appliedCouponProvider = StateProvider<AppliedCouponState?>((ref) => null);
