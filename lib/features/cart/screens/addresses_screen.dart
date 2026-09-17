import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/route/screenNames.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/cart/provider/checkout_address_provider.dart';

class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(checkoutAddressListProvider);
    final selectedId = ref.watch(selectedCheckoutAddressIdProvider);

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
        title: CustomText('Addresses', fontWeight: Fonts.bold, fontSize: 18.sp),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(ScreenNames.ADD_ADDRESS),
            icon: Icon(Icons.add, color: AppColors.textPrimary, size: 26.sp),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Search address',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.greyIcon,
                  size: 22.sp,
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
              ),
              onTap: () {},
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: list.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                final a = list[index];
                final sel = selectedId == a.id;
                return Dismissible(
                  key: ValueKey(a.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: AppColors.white,
                      size: 28.sp,
                    ),
                  ),
                  onDismissed: (_) {
                    final wasSelected = selectedId == a.id;
                    ref
                        .read(checkoutAddressListProvider.notifier)
                        .removeById(a.id);
                    final next = ref.read(checkoutAddressListProvider);
                    if (wasSelected && next.isNotEmpty) {
                      ref
                              .read(selectedCheckoutAddressIdProvider.notifier)
                              .state =
                          next.first.id;
                    }
                  },
                  child: Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    elevation: 1,
                    shadowColor: Colors.black12,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        ref
                            .read(selectedCheckoutAddressIdProvider.notifier)
                            .state = a
                            .id;
                        context.pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(14.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Icon(
                                sel
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                                color: sel
                                    ? AppColors.primary
                                    : AppColors.greyIcon,
                                size: 22.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        a.label,
                                        fontWeight: Fonts.bold,
                                        fontSize: 15.sp,
                                      ),
                                      if (a.isDefault) ...[
                                        SizedBox(width: 8.w),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 2.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius: BorderRadius.circular(
                                              20.r,
                                            ),
                                          ),
                                          child: CustomText(
                                            'Default',
                                            fontSize: 10.sp,
                                            color: AppColors.white,
                                            fontWeight: Fonts.medium,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  CustomText(
                                    a.line,
                                    fontSize: 13.sp,
                                    color: AppColors.textSecondary,
                                    maxLines: 3,
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
