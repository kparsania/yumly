import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomDivider.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/features/tabs/widgets/dashboardShimmer.dart';
import '../../../core/route/screenNames.dart';
import '../../../core/utils/Fonts.dart';
import '../../../core/widgets/CustomSearchBar.dart';
import '../../../core/widgets/CustomText.dart';
import '../../cart/provider/cart_provider.dart';
import '../provider/dashboard_provider.dart';
import '../widgets/dashboard_categories.dart';
import '../widgets/dashboard_restaurant_card.dart';
import '../widgets/dashboard_featured_restaurants.dart';
import '../widgets/dashboard_top_sheet.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);
    final width = MediaQuery.of(context).size.width;
    final cartCount = ref
        .watch(cartProvider)
        .fold(0, (sum, e) => sum + e.quantity);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: state.isLoading
          ? const Center(child: DashboardShimmer())
          : Stack(
              children: [
                SingleChildScrollView(
                  controller: notifier.scrollController,
                  child: Column(
                    children: [
                      /// HEADER BACKGROUND + ANIMATION
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                        offset: state.isHeaderVisible
                            ? Offset.zero
                            : const Offset(0, -0.4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.r),
                              bottomRight: Radius.circular(50.r),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                top: 0,
                                child: Container(
                                  height: 351.h,
                                  width: width,
                                  color: AppColors.yellowBanner,
                                ),
                              ),
                              Column(
                                children: [
                                  CustomImage(
                                    source: Images.background,
                                    height: 350.h,
                                    width: width,
                                  ),
                                  CustomImage(
                                    source: Images.bannerBorder,
                                    width: width,
                                    color: AppColors.yellowBanner,
                                  ),
                                ],
                              ),

                              Positioned(
                                bottom: 30.h,
                                child: SizedBox(
                                  width: width,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomImage(
                                            source: Images.card,
                                            height: 100.h,
                                            width: 125.w,
                                            fit: BoxFit.contain,
                                          ),
                                          CustomImage(
                                            source: Images.card,
                                            height: 100.h,
                                            width: 125.w,
                                            fit: BoxFit.contain,
                                          ),
                                          CustomImage(
                                            source: Images.card,
                                            height: 100.h,
                                            width: 125.w,
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 0,
                                        right: 0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 125.w,
                                              child: CustomText(
                                                "Tacos\n& More",
                                                color: Colors.red,
                                                fontWeight: Fonts.bold,
                                                textAlign: TextAlign.center,
                                                fontSize: 18.sp,
                                                fontFamily: Fonts
                                                    .fontFamilyLMontaguSlab,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 125.w,
                                              child: CustomText(
                                                "Burgers\nSpecials",
                                                color: Colors.red,
                                                fontWeight: Fonts.bold,
                                                textAlign: TextAlign.center,
                                                fontSize: 18.sp,
                                                fontFamily: Fonts
                                                    .fontFamilyLMontaguSlab,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 125.w,
                                              child: CustomText(
                                                "Fulfilling\nBowls",
                                                color: Colors.red,
                                                fontWeight: Fonts.bold,
                                                textAlign: TextAlign.center,
                                                fontSize: 18.sp,
                                                fontFamily: Fonts
                                                    .fontFamilyLMontaguSlab,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Positioned(
                                bottom: 80.h,
                                width: width,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Lottie.asset(
                                        Images.tacoJump,
                                        height: 120.h,
                                        width: 120.w,
                                      ),
                                      Lottie.asset(
                                        Images.burgerJump,
                                        height: 120.h,
                                        width: 120.w,
                                      ),
                                      Lottie.asset(
                                        Images.noodleJump,
                                        height: 120.h,
                                        width: 120.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: DashboardCategories(key: notifier.categoriesKey),
                      ),
                      CustomDivider(
                        thickness: 5,
                        padding: EdgeInsets.only(top: 5.h),
                      ),

                      // Top Rated Restaurants
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'Top Rated restaurants',
                              fontSize: 20.sp,
                              fontWeight: Fonts.semiBold,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('View all'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 210,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 16),
                          itemCount: state.topRatedRestaurants.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            var item = state.topRatedRestaurants[index];
                            return GestureDetector(
                              onTap: () => context.pushNamed(
                                ScreenNames.RESTAURANT_DETAIL,
                                extra: item,
                              ),
                              child: DashboardRestaurantCard(
                                imageUrl: item['image'] ?? "",
                                rating: item['rating'] ?? "",
                                restaurantName: item['restaurant'] ?? "",
                                location: item['location'] ?? "",
                                deliveryTime: item['deliveryTime'] ?? "",
                                startingPrice: item['startingPrice'] ?? "",
                                categories: item['categories'] ?? '',
                              ),
                            );
                          },
                        ),
                      ),
                      // Featured Restaurants
                      Container(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 10.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Top 210 restaurants to explore',
                              fontSize: 20.sp,
                              fontWeight: Fonts.semiBold,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  'FEATURED RESTAURANTS',
                                  fontSize: 14.sp,
                                  fontWeight: Fonts.bold,
                                  color: Colors.grey,
                                ),
                                Expanded(
                                  child: CustomImage(
                                    margin: EdgeInsets.only(left: 4.w),
                                    source: Images.shadedLine,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.restaurantItems.length,
                              padding: EdgeInsets.only(bottom: 50.h),
                              itemBuilder: (context, index) {
                                var item = state.restaurantItems[index];
                                return GestureDetector(
                                  onTap: () => context.pushNamed(
                                    ScreenNames.RESTAURANT_DETAIL,
                                    extra: item,
                                  ),
                                  child: FeaturedRestaurantsCard(
                                    image: item['image'] ?? "",
                                    rating: item['rating'] ?? "",
                                    reviews: item['reviews'] ?? "",
                                    restaurantName: item['restaurant'] ?? "",
                                    location: item['location'] ?? "",
                                    price: item['price'].toString(),
                                    deliveryTime: item['deliveryTime'] ?? "",
                                    quantity: item['quantity'] ?? "",
                                    startingPrice: item['startingPrice'] ?? "",
                                    categories: item['categories'] ?? '',
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// HEADER STICKY BAR
                IgnorePointer(
                  ignoring: false,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    color: Colors.white.withValues(alpha: state.appBarOpacity),
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -0.2),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: state.isAddressVisible
                          ? Container(
                              // color: AppColors.yellowBanner,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                key: const ValueKey("headerWithAddress"),
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.work,
                                                  color: AppColors.primary,
                                                ),
                                                SizedBox(width: 4.w),
                                                CustomText(
                                                  "Work",
                                                  fontSize: 18.sp,
                                                ),
                                              ],
                                            ),
                                            CustomText(
                                              "Aayat Bungalows, Sindhu Bhavan Ahmedabad",
                                              fontSize: 16.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 18.w,
                                        child: Icon(Icons.person, size: 22.w),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.w),
                                  CustomSearchBar(
                                    key: const ValueKey("headerSearch"),
                                    placeholderTexts: [
                                      "Search for 'restaurants'",
                                      "Search for 'pizza'",
                                      "Search for 'Cake'",
                                      "Search for 'Sweet'",
                                      "Search for 'High Protein'",
                                    ],
                                    isSearchEnabled: false,
                                    leftIcon: Images.search,
                                    rightIcon1: Images.microphone,
                                    rightIcon2Color: AppColors.mediumGrey,
                                    rightIcon1Color: AppColors.primary,
                                    leftIconColor: AppColors.mediumGrey,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.r),
                                      ),
                                    ),
                                    onLeftIconTap: () {
                                      context.pop();
                                    },
                                    onTap: () {
                                      notifier.openTopSheet();
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              key: const ValueKey("headerIcons"),
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomSearchBar(
                                  key: const ValueKey("headerSearch"),
                                  placeholderTexts: [
                                    "Search for restaurants",
                                    "Search for pizza",
                                    "Search for pasta",
                                  ],
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  leftIcon: Images.search,
                                  rightIcon1: Images.microphone,
                                  rightIcon2Color: AppColors.mediumGrey,
                                  rightIcon1Color: AppColors.primary,
                                  leftIconColor: AppColors.mediumGrey,
                                  onTap: () {
                                    context.pop();
                                  },
                                ),
                                SizedBox(height: 16.h),
                                if (state.isCategoriesVisible)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    child: DashboardCategories(),
                                  ),
                              ],
                            ),
                    ),
                  ),
                ),

                if (state.isTopSheetOpen)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: TopSheet(onClose: notifier.closeTopSheet),
                  ),

              ],
            ),
    );
  }
}