import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/cart/data/cart_item_edit_catalog.dart';
import 'package:yumly/features/cart/provider/cart_provider.dart';

/// Zomato-style edit item bottom sheet.
Future<void> showEditCartItemBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  required CartItem item,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => EditCartItemSheet(initial: item),
  );
}

class EditCartItemSheet extends ConsumerStatefulWidget {
  const EditCartItemSheet({super.key, required this.initial});

  final CartItem initial;

  @override
  ConsumerState<EditCartItemSheet> createState() => _EditCartItemSheetState();
}

class _EditCartItemSheetState extends ConsumerState<EditCartItemSheet> {
  late int _qty;
  late TextEditingController _noteController;
  late ItemEditProfile _profile;

  @override
  void initState() {
    super.initState();
    _qty = widget.initial.quantity;
    _noteController = TextEditingController(text: widget.initial.cookingNote);
    _profile = resolveItemEditProfile(
      foodName: widget.initial.foodName,
      detailDescription: widget.initial.detailDescription,
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String get _heroUrl {
    final u = _profile.heroImageUrl;
    if (u != null && u.isNotEmpty) return u;
    return widget.initial.image;
  }

  void _appendChip(String tag) {
    final t = _noteController.text.trim();
    if (t.contains(tag)) return;
    _noteController.text = t.isEmpty ? tag : '$t, $tag';
    _noteController.selection = TextSelection.collapsed(
      offset: _noteController.text.length,
    );
    setState(() {});
  }

  void _applyUpdate() {
    final note = _noteController.text.trim();
    if (note.length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cooking request must be 100 characters or less'),
        ),
      );
      return;
    }
    final updated = widget.initial.copyWith(quantity: _qty, cookingNote: note);
    ref.read(cartProvider.notifier).updateCartLine(updated);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.initial.foodName} updated')),
    );
  }

  Widget _heroImage() {
    final url = _heroUrl;
    if (url.isEmpty) {
      return Container(
        height: 200.h,
        color: AppColors.lightGrey,
        child: Icon(Icons.restaurant, size: 48.sp, color: AppColors.greyIcon),
      );
    }
    if (url.startsWith('http')) {
      return Image.network(
        url,
        height: 200.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 200.h,
          color: AppColors.lightGrey,
          child: Icon(Icons.broken_image_outlined, color: AppColors.greyIcon),
        ),
      );
    }
    return Image.asset(
      url,
      height: 200.h,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        height: 200.h,
        color: AppColors.lightGrey,
        child: Icon(Icons.fastfood, color: AppColors.greyIcon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lineTotal = widget.initial.price * _qty;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.55,
      maxChildSize: 0.98,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.r),
                          ),
                          child: _heroImage(),
                        ),
                        Positioned(
                          top: 12.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Material(
                              color: Colors.black54,
                              shape: const CircleBorder(),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () => Navigator.of(context).pop(),
                                child: Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Icon(
                                    Icons.close,
                                    color: AppColors.white,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_profile.isVeg)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 2.h,
                                    right: 8.w,
                                  ),
                                  child: CustomImage(
                                    source: Images.veg,
                                    isSvg: true,
                                    width: 18.w,
                                    height: 18.w,
                                  ),
                                ),
                              if (_profile.isSpicy) ...[
                                Icon(
                                  Icons.local_fire_department,
                                  size: 18.sp,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 4.w),
                                CustomText(
                                  'Spicy',
                                  color: AppColors.primary,
                                  fontWeight: Fonts.semiBold,
                                  fontSize: 13.sp,
                                ),
                                SizedBox(width: 12.w),
                              ],
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomText(
                                  widget.initial.foodName,
                                  fontWeight: Fonts.bold,
                                  fontSize: 20.sp,
                                  maxLines: 3,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _RoundIconButton(
                                    icon: Icons.bookmark_border,
                                    onTap: () {},
                                  ),
                                  SizedBox(width: 8.w),
                                  _RoundIconButton(
                                    icon: Icons.share_outlined,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (_profile.highlyReordered) ...[
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Container(
                                  width: 4.w,
                                  height: 14.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.mediumGreen,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                CustomText(
                                  'Highly reordered',
                                  fontSize: 12.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 10.h),
                          CustomText(
                            _profile.description,
                            fontSize: 13.sp,
                            color: AppColors.textSecondary,
                            height: 1.35,
                          ),
                          SizedBox(height: 22.h),
                          Row(
                            children: [
                              CustomText(
                                'Add a cooking request (optional)',
                                fontWeight: Fonts.bold,
                                fontSize: 15.sp,
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.info_outline,
                                size: 16.sp,
                                color: AppColors.greyIcon,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          TextField(
                            controller: _noteController,
                            maxLines: 4,
                            maxLength: 100,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: "e.g. Don't make it too spicy",
                              filled: true,
                              fillColor: const Color(0xFFF5F5F7),
                              contentPadding: EdgeInsets.all(14.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 40.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _profile.cookingQuickTags.length,
                              separatorBuilder: (_, __) => SizedBox(width: 8.w),
                              itemBuilder: (context, i) {
                                final tag = _profile.cookingQuickTags[i];
                                return ActionChip(
                                  label: Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  backgroundColor: AppColors.white,
                                  side: BorderSide(color: AppColors.divider),
                                  onPressed: () {
                                    _appendChip(tag);
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  12.h,
                  16.w,
                  12.h + bottomInset,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _SheetQty(
                      qty: _qty,
                      onDec: () {
                        if (_qty > 1) {
                          setState(() => _qty--);
                        } else {
                          ref
                              .read(cartProvider.notifier)
                              .removeLineCompletely(widget.initial.id);
                          Navigator.of(context).pop();
                        }
                      },
                      onInc: () => setState(() => _qty++),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: _applyUpdate,
                        child: Text(
                          'Update item — ₹${lineTotal.toStringAsFixed(0)}',
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
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.divider),
          ),
          child: Icon(icon, size: 18.sp, color: AppColors.mediumGrey),
        ),
      ),
    );
  }
}

class _SheetQty extends StatelessWidget {
  const _SheetQty({
    required this.qty,
    required this.onDec,
    required this.onInc,
  });

  final int qty;
  final VoidCallback onDec;
  final VoidCallback onInc;

  @override
  Widget build(BuildContext context) {
    final soft = Color.lerp(AppColors.primary, AppColors.white, 0.65)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: soft, width: 1.2),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onDec,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Icon(Icons.remove, size: 18.sp, color: AppColors.primary),
            ),
          ),
          SizedBox(
            width: 28.w,
            child: Center(
              child: Text(
                '$qty',
                style: TextStyle(
                  fontWeight: Fonts.bold,
                  fontSize: 16.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onInc,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Icon(Icons.add, size: 18.sp, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
