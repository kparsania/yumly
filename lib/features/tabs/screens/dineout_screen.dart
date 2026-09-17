// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../provider/dineout_provider.dart';
// import '../widgets/dineout_header.dart';
//
// class DineoutScreen extends ConsumerStatefulWidget {
//   const DineoutScreen({super.key});
//
//   @override
//   ConsumerState<DineoutScreen> createState() => _DineoutScreenState();
// }
//
// class _DineoutScreenState extends ConsumerState<DineoutScreen> {
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }
//
//   void _onScroll() {
//     final offset = _scrollController.offset;
//     final shouldShowAddress = offset < 80; // smooth fade threshold
//     ref.read(dineoutHeaderProvider.notifier).updateScroll(offset, shouldShowAddress);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final headerState = ref.watch(dineoutHeaderProvider);
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             controller: _scrollController,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 120), // header space
//                 const DineoutSpotlight(),
//                 const SizedBox(height: 16),
//                 const DineoutMindSection(),
//                 const SizedBox(height: 16),
//                 const DineoutMindSection(),
//               ],
//             ),
//           ),
//
//           /// Sticky header
//           DineoutHeader(state: headerState),
//         ],
//       ),
//     );
//   }
// }


import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/tabs/widgets/dineout_drinks&desserts_card.dart';
import 'package:yumly/features/tabs/widgets/dineout_shimmer.dart';
import '../../../core/utils/Colors.dart';
import '../../../core/utils/Fonts.dart';
import '../../../core/utils/Images.dart';
import '../../../core/widgets/CustomSearchBar.dart';
import '../provider/dineout_provider.dart';
import '../widgets/dineout_popular_restaurants_card.dart';
import '../widgets/featured_indicator.dart';

class DineOutScreen extends ConsumerStatefulWidget {
  const DineOutScreen({super.key});

  @override
  ConsumerState<DineOutScreen> createState() => _DineOutScreenState();
}

class _DineOutScreenState extends ConsumerState<DineOutScreen> {
  late ScrollController _scrollController;
  late SwiperController featuredSwiperController;
  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    featuredSwiperController = SwiperController();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      ref
          .read(dineoutHeaderProvider.notifier)
          .updateScroll(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget heading(title) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.h,
        right: 16.h,
        bottom: 16.h,
        top: 24.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: RotatedBox(
              quarterTurns: 2,
              child: CustomImage(
                margin: EdgeInsets.only(left: 8.w),
                source: Images.shadedLine,
                height: 1.5,
              ),
            ),
          ),
          CustomText(
            title.toUpperCase() ?? "Title",
            fontSize: 18.sp,
            fontWeight: Fonts.regular,
            color: AppColors.mediumGrey,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: CustomImage(
              margin: EdgeInsets.only(left: 8.w),
              source: Images.shadedLine,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget spotlightListItem(BuildContext context, int index, List item) {
    //horizontal
    return Container(
      width: 305.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: CustomImage(
              source: item[index]["image"],
              isNetwork: true,
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
              width: 200.w,
              height: 180.h,
            ),
          ),
          CustomImage(
            source: Images.spotlightOverlay,
            width: 157.w,
            height: 180.h,
            color: item[index]["bannerColor"],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w),
              bottomLeft: Radius.circular(10.w),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            width: 130.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 8.w, top: 6.h, bottom: 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.w)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white24,
                        Colors.white12,
                        Colors.white10,
                        Colors.transparent,
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.discount_sharp,
                        color: AppColors.white,
                        size: 12.w,
                      ),
                      SizedBox(width: 3.h),
                      CustomText(
                        item[index]["discount"],
                        fontSize: 12.sp,
                        fontWeight: Fonts.bold,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      item[index]["restaurant"],
                      fontSize: 20.sp,
                      fontWeight: Fonts.bold,
                      color: AppColors.white,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      item[index]["tagline"],
                      fontSize: 12.sp,
                      fontWeight: Fonts.light,
                      color: AppColors.white,
                      maxLines: 4,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.w)),
                    color: Colors.black54,
                  ),
                  child: CustomText(
                    item[index]["cta"],
                    fontSize: 10.sp,
                    fontWeight: Fonts.semiBold,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget popularRestaurantsListItem(
    BuildContext context,
    int index,
    List item,
  ) {
    return Container(height: 305.w);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dineoutHeaderProvider);
    final notifier = ref.read(dineoutHeaderProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: state.isLoading
            ? DineoutShimmer()
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    backgroundColor: AppColors.primary,
                    expandedHeight: 50.h,
                    foregroundColor: AppColors.primary,
                    flexibleSpace: Container(
                      color: AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.work,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(width: 4.w),
                                    CustomText("Work", fontSize: 18.sp),
                                  ],
                                ),
                                CustomText(
                                  "Tatvasoft house, rajpath club road, Iskon, Ahmedabad",
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
                    ),
                  ),
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: AppColors.white,
                    expandedHeight: 50.h,
                    toolbarHeight: 60.h,
                    foregroundColor: AppColors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.w),
                            bottomRight: Radius.circular(16.w),
                          ),
                        ),
                        child: CustomSearchBar(
                          placeholderTexts: [
                            "Search for restaurants",
                            "Search for pizza",
                            "Search for pasta",
                          ],
                          showLeftIcon: false,
                          rightIcon2: Images.search,
                          rightIcon2Color: AppColors.mediumGrey,
                          rightIcon1Color: AppColors.primary,
                          rightIcon1: Images.microphone,
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: heading("In the Spotlight")),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 180.h,
                      child: CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: state.spotlightRestaurants!.length,
                        options: CarouselOptions(
                          autoPlayInterval: const Duration(milliseconds: 3000),
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.755,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            notifier.updateSpotlightHighlightIndex(index);
                          },
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                              if (state.spotlightRestaurants == null ||
                                  state.spotlightRestaurants!.isEmpty) {
                                return SizedBox(); // return empty widget
                              }
                              return spotlightListItem(
                                context,
                                index,
                                state.spotlightRestaurants!,
                              );
                            },
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: heading("MUST-TRIES IN AHMEDABAD")),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (a, index) => Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 200.h,
                              width: 155.w,
                              margin: EdgeInsets.only(left: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16.w),
                                  bottomRight: Radius.circular(16.w),
                                  topLeft: Radius.circular(70.w),
                                  topRight: Radius.circular(70.w),
                                ),
                                color: AppColors.black,
                              ),
                            ),
                            CustomImage(
                              source: state.mustTriesArray![index]["image"],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16.w),
                                bottomRight: Radius.circular(16.w),
                                topLeft: Radius.circular(70.w),
                                topRight: Radius.circular(70.w),
                              ),
                              isNetwork: true,
                              height: 200.h,
                              width: 155.w,
                            ),
                            Container(
                              height: 130.h,
                              width: 155.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.w),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.black87,
                                    Colors.black87,
                                    Colors.black54,
                                    Colors.black45,
                                    Colors.black38,
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),

                            Container(
                              // alignment: Alignment.center,
                              width: 140.w,
                              margin: EdgeInsets.only(bottom: 10.h),
                              child: CustomText(
                                state.mustTriesArray![index]["title"],
                                fontSize: 20.sp,
                                maxLines: 2,
                                fontWeight: Fonts.semiBold,
                                color: AppColors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        separatorBuilder: (a, b) => SizedBox(width: 8.w),
                        itemCount: state.mustTriesArray!.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: heading("What are you looking for?"),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 180.h,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                      ),
                      itemCount: state.lookingFor!.length,
                      itemBuilder: (a, index) {
                        return Container(
                          padding: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blueBorder),
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.w),
                            ),
                            color: AppColors.blueLight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                // width: 140.w,
                                margin: EdgeInsets.only(top: 10.h, left: 4.w),
                                child: CustomText(
                                  state.lookingFor![index]["title"],
                                  fontSize: 20.sp,
                                  maxLines: 2,
                                  fontWeight: Fonts.semiBold,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: CustomImage(
                                  source: state.lookingFor![index]["image"],
                                  height:
                                      state.lookingFor![index]["title"] ==
                                          "Premium dining"
                                      ? 80.h
                                      : 110.h,
                                  width:
                                      state.lookingFor![index]["title"] ==
                                          "Rooftops"
                                      ? 110.h
                                      : 100.w,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 26.h,
                      ),
                      child: Stack(
                        children: [
                          CustomImage(
                            source:
                                "https://b.zmtcdn.com/data/o2_assets/85e14f93411a6b584888b6f3de3daf081716296829.png",
                            isNetwork: true,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.sp),
                            ),
                            width: double.infinity,
                            height: 110.h,
                          ),
                          Positioned(
                            top: 22,
                            child: Container(
                              width: 100.w,
                              height: 20.h,
                              padding: EdgeInsets.only(left: 8),
                              color: Color.fromRGBO(9, 19, 25, 1),
                              child: CustomText(
                                "Yumly Dining",
                                color: AppColors.white,
                                fontSize: 16.sp,
                                fontWeight: Fonts.medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: heading("Featured this week")),
                  SliverToBoxAdapter(
                    child: Swiper(
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CustomImage(
                                source:
                                    state.featuredRestaurants![index]['image'],
                                isNetwork: true,
                                fit: BoxFit.cover,
                                height: 500.h,
                                width: double.infinity,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(16.w),
                                  padding: EdgeInsets.all(16.w),
                                  alignment: Alignment.bottomCenter,
                                  // height: 70,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.w),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        state
                                            .featuredRestaurants![index]['title'],
                                        fontSize: 18.sp,
                                      ),
                                      SizedBox(height: 6.h),
                                      CustomImage(
                                        source: Images.shadedLine,
                                        height: 2.h,
                                        width: double.infinity,
                                      ),
                                      SizedBox(height: 6.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            state
                                                .featuredRestaurants![index]["address"],
                                          ),
                                          SizedBox(width: 6.h),

                                          // Dot separator
                                          CustomText("•", fontSize: 16.sp),
                                          SizedBox(width: 6.h),

                                          // Delivery time
                                          CustomText(
                                            state
                                                .featuredRestaurants![index]["cuisine"],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomImage(
                                            source: Images.percentageOffer,
                                          ),
                                          CustomText(
                                            state
                                                .featuredRestaurants![index]["offer"],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      itemCount: state.featuredRestaurants!.length,
                      layout: SwiperLayout.STACK,
                      itemWidth: 350.w,
                      itemHeight: 400.h,
                      autoplay: true,
                      axisDirection: AxisDirection.right,
                      scrollDirection: Axis.horizontal,
                      index: state.featuredRestaurants!.length,
                      onIndexChanged: (index) {
                        notifier.updateFeaturedIndex(index);
                      },
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: FeaturedIndicator(
                        currentIndex: state.featuredFocusedIndex,
                        itemCount: state.mustTriesArray!.length,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: heading("Drinks and Deserts")),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 280.h,
                      // width: 290.w,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.drinksDessertsRestaurants!.length,
                        itemBuilder: (context, index) {
                          final item = state.drinksDessertsRestaurants![index];
                          return DrinksDessertsCard(
                            image: item['image'],
                            restaurantName: item['restaurantName'],
                            cuisine: item['cuisine'],
                            location: item['location'],
                            rating: item['rating'],
                            price: item['price'],
                            offers: item['offers'],
                          );
                        },
                      ),
                    ),
                  ),

                  // SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     height: 250.h, // match card height
                  //     child: ListView.separated(
                  //       scrollDirection: Axis.horizontal,
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  //
                  //     ),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: heading("Popular restaurants\n around you"),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = state.popularRestaurants![index];
                      return PopularRestaurantsCard(
                        image: item['image'],
                        restaurantName: item['restaurantName'],
                        cuisine: item['cuisine'],
                        location: item['location'],
                        rating: item['rating'],
                        price: item['price'],
                        offers: item['offers'],
                      );
                    }, childCount: state.popularRestaurants!.length),
                  ),
                ],
              ),
      ),
    );
  }
}
