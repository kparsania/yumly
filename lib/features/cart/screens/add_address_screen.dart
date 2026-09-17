import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/cart/provider/checkout_address_provider.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final _labelController = TextEditingController(text: 'Other');
  final _lineController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _labelController.dispose();
    _lineController.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final id = 'n${DateTime.now().millisecondsSinceEpoch}';
    final a = SavedAddress(
      id: id,
      label: _labelController.text.trim(),
      line: _lineController.text.trim(),
    );
    ref.read(checkoutAddressListProvider.notifier).add(a);
    ref.read(selectedCheckoutAddressIdProvider.notifier).state = id;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
            size: 22.sp,
          ),
          onPressed: () => context.pop(),
        ),
        title: CustomText(
          'Add address',
          fontWeight: Fonts.bold,
          fontSize: 18.sp,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            CustomText('Label', fontWeight: Fonts.semiBold, fontSize: 14.sp),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _labelController,
              decoration: _fieldDeco('Home, Work, office…'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter a label' : null,
            ),
            SizedBox(height: 18.h),
            CustomText(
              'Full address',
              fontWeight: Fonts.semiBold,
              fontSize: 14.sp,
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _lineController,
              maxLines: 4,
              decoration: _fieldDeco('House no., street, landmark…'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter address' : null,
            ),
            SizedBox(height: 28.h),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              onPressed: _save,
              child: CustomText(
                'Save address',
                color: AppColors.white,
                fontWeight: Fonts.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}
