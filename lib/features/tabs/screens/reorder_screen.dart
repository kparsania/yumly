import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomButton.dart';
import 'package:yumly/core/widgets/CustomDivider.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../../core/widgets/CustomImage.dart';
import '../../../core/widgets/CustomSearchBar.dart';
import '../provider/reorder_provider.dart';

// ---- Provider to track whether filters should stay pinned
final pinFiltersProvider = StateProvider<bool>((ref) => true);

class ReorderScreen extends ConsumerStatefulWidget {
  const ReorderScreen({super.key});

  @override
  ConsumerState<ReorderScreen> createState() => _ReorderScreenState();
}

class _ReorderScreenState extends ConsumerState<ReorderScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final current = ref.read(pinFiltersProvider.notifier).state;
    final shouldPin = _controller.offset < 120;
    if (shouldPin != current) {
      ref.read(pinFiltersProvider.notifier).state = shouldPin;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reorderProvider);
    final notifier = ref.read(reorderProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            // --- Header: Reorder title (not pinned)
            SliverAppBar(
              pinned: false,
              expandedHeight: 60,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 16, bottom: 8),
                title: CustomText(
                  'REORDER',
                  fontWeight: Fonts.medium,
                  fontSize: 16.sp,
                ),
              ),
            ),

            // --- Pinned Search Bar
            SliverAppBar(
              pinned: false,
              toolbarHeight: 70.h,
              floating: true,
              flexibleSpace: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: CustomSearchBar(
                  key: const ValueKey("headerSearch"),
                  placeholderTexts: ["Search restaurant or dish"],
                  // isSearchEnabled: false,
                  showRightVerticalDivider: false,
                  showLeftIcon: false,
                  rightIcon1: Images.search,
                  rightIcon1Color: AppColors.mediumGrey,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.divider),
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                  onTap: () {
                    // customLogPrint('openTopSheet');
                    // notifier.openTopSheet();
                  },
                ),
              ),
            ),

            // --- Filters (pinned until scroll threshold is reached)
            SliverPersistentHeader(
              pinned: true,
              delegate: _HeaderDelegate(
                50,
                Container(
                  color: AppColors.lightGrey,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterChip(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        label: CustomText(
                          'Favourites',
                          fontWeight: Fonts.medium,
                          fontSize: 15.sp,
                        ),
                        onSelected: (_) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          side: BorderSide(
                            color: AppColors.divider,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        label: CustomText(
                          'Price 149-300',
                          fontWeight: Fonts.medium,
                          fontSize: 15.sp,
                        ),
                        onSelected: (_) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          side: BorderSide(
                            color: AppColors.divider,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        label: CustomText(
                          'Price >300',
                          fontWeight: Fonts.medium,
                          fontSize: 15.sp,
                        ),
                        onSelected: (_) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          side: BorderSide(
                            color: AppColors.divider,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Content for scrolling
            DecoratedSliver(
              decoration: const BoxDecoration(color: AppColors.lightGrey),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.reorderRestaurants!.length,
                  (context, index) {
                    final r = state.reorderRestaurants![index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.divider,
                          width: 1.5.w,
                        ),
                      ),
                      // shape: RoundedRectangleBorder(
                      // ),
                      margin: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        bottom: 16.w,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with image, name, time and favorite button
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightGrey,
                                    AppColors.lightGrey,
                                    AppColors.lightGrey,
                                    AppColors.lightGrey,
                                    AppColors.lightGrey,
                                    AppColors.lightGrey,
                                    AppColors.white,
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14.r),
                                  topRight: Radius.circular(14.r),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: CustomImage(
                                      source: r['image'],
                                      isNetwork: true,
                                      width: 55.h,
                                      height: 55.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                r['restaurantName'],
                                                fontSize: 16.sp,
                                                fontWeight: Fonts.bold,
                                              ),
                                            ),
                                            SizedBox(width: 6.w),
                                          ],
                                        ),
                                        CustomText(
                                          r['location'],
                                          color: AppColors.mediumGrey,
                                          fontWeight: Fonts.medium,
                                        ),
                                        Row(
                                          children: [
                                            CustomImage(
                                              source: Images.priceTag,
                                              color: AppColors.primary,
                                              height: 10.h,
                                              width: 10.w,
                                            ),
                                            SizedBox(width: 4.w),
                                            CustomText(
                                              r['benefits'],
                                              color: AppColors.mediumGrey,
                                              fontWeight: Fonts.medium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      r['isFavourite']
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: r['isFavourite']
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () => {
                                      // notifier.toggleFavorite(index)
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            // Dishes list
                            ...r['items'].map(
                              (dish) => Padding(
                                padding: EdgeInsets.only(
                                  top: 10.h,
                                  left: 10.w,
                                  right: 10.w,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 2.h,
                                                ),
                                                child: CustomImage(
                                                  source: Images.veg,
                                                  height: 14.h,
                                                  width: 14.w,
                                                ),
                                              ),
                                              SizedBox(width: 6.w),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      dish['name'],
                                                      fontSize: 16.sp,
                                                      maxLines: 2,
                                                      fontWeight: Fonts.medium,
                                                    ),

                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          '₹${dish['price'].toStringAsFixed(0)}',
                                                          fontWeight:
                                                              Fonts.semiBold,
                                                          color: AppColors
                                                              .mediumGrey,
                                                        ),
                                                        if (dish['originalPrice'] !=
                                                            null) ...[
                                                          SizedBox(width: 4.w),
                                                          CustomText(
                                                            '₹${dish['originalPrice']}',
                                                            fontSize: 12.sp,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: AppColors
                                                                .mediumGrey,
                                                          ),
                                                        ],
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    // Add spacing between text and button
                                    InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(8.w),
                                        // width: 50.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.r),
                                          ),
                                          border: Border.all(
                                            color: AppColors.divider,
                                            width: 1.3.w,
                                          ),
                                        ),
                                        child: CustomImage(
                                          source: Images.addDark,
                                          color: AppColors.green,
                                          height: 12.h,
                                          width: 12.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(height: 12.w),
                            CustomDivider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        'Order placed on ${r["orderPlacedOn"]}',
                                        fontSize: 12.sp,
                                        color: AppColors.mediumGrey,
                                      ),
                                      CustomText(
                                        'Delivered',
                                        fontSize: 12.sp,
                                        color: AppColors.mediumGrey,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomText(
                                        '₹${r["totalAmount"]}',
                                        fontSize: 16.sp,
                                      ),
                                      CustomImage(
                                        source: Images.downArrow,
                                        color: AppColors.mediumGrey,
                                        // color: AppColors.green,
                                        height: 24.h,
                                        width: 24.w,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            CustomDivider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.all(8.h),
                                  margin: EdgeInsets.only(right: 10.h,bottom: 6.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.refresh_sharp,
                                        color: AppColors.white,
                                        size: 16.w,
                                      ),
                                      SizedBox(width: 2.w),
                                      CustomText(
                                        'Reorder',
                                        fontWeight: Fonts.medium,
                                        fontSize: 16.sp,
                                        color: AppColors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 50.h, bottom: 100.h, left: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Live it \nup!",
                      color: AppColors.textSecondary,
                      fontSize: 60.sp,
                      fontWeight: Fonts.black,
                      fontFamily: Fonts.fontFamilyLexend,
                      height: 0.8,
                    ),
                    SizedBox(height: 14.h),
                    CustomText(
                      "Crafted with 🩷, by khushi",
                      color: AppColors.textSecondary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w100,
                      fontFamily: Fonts.fontFamilyGilroy,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Delegate for pinned headers
class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  const _HeaderDelegate(this.height, this.child);

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) =>
      height != oldDelegate.height || child != oldDelegate.child;
}
