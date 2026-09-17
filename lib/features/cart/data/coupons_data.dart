/// Shared catalog — same offers wherever coupons are shown (cart, checkout, etc.).
class CouponOffer {
  const CouponOffer({
    required this.code,
    required this.title,
    required this.subtitle,
    required this.discountRupee,
  });

  final String code;
  final String title;
  final String subtitle;

  /// Flat ₹ off the order subtotal (before tip).
  final double discountRupee;
}

const List<CouponOffer> kDefaultCoupons = [
  CouponOffer(
    code: 'YUMLY39',
    title: 'Items at ₹39',
    subtitle: 'Save on select dishes · min order ₹199',
    discountRupee: 39,
  ),
  CouponOffer(
    code: 'FIRST100',
    title: 'First order',
    subtitle: 'Flat ₹100 off · max ₹100',
    discountRupee: 100,
  ),
  CouponOffer(
    code: 'FREEDEL',
    title: 'Free delivery',
    subtitle: '₹40 off (delivery waiver) · orders above ₹149',
    discountRupee: 40,
  ),
  CouponOffer(
    code: 'MEAL50',
    title: 'Lunch special',
    subtitle: '₹50 off weekday lunch · 11am–3pm',
    discountRupee: 50,
  ),
];
