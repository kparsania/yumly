// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yumly/core/utils/Colors.dart';
// import 'package:yumly/core/utils/Constants.dart';
// import 'package:yumly/core/utils/Fonts.dart';
// import 'package:yumly/core/utils/Images.dart';
// import 'package:yumly/core/widgets/CustomImage.dart';
// import 'package:yumly/core/widgets/CustomText.dart';
//
// import '../widgets/favorites_shimmer.dart';
//
// class FavoritesScreen extends StatefulWidget {
//   const FavoritesScreen({super.key});
//
//   @override
//   State<FavoritesScreen> createState() => _FavoritesScreenState();
// }
//
// class _FavoritesScreenState extends State<FavoritesScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   Widget _buildCard(Map<String, dynamic> item) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(16),
//                 ),
//                 child: CustomImage(source:
//                   item["image"],
//                   height: 180.h,
//                   isNetwork: true,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 right: 12.w,
//                 top: 12.h,
//                 child: Container(
//                   padding: EdgeInsets.all(6.w),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.w),
//                     color: AppColors.white,
//                   ),
//                   child: CustomImage(
//                     source: Images.heartFilled,
//                     height: 18.h,
//                     width: 18.w,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     item["vendor"] == null
//                         ? Container()
//                         : CustomText(
//                             item["vendor"] ?? "",
//                             fontSize: 12.sp,
//                             color: AppColors.mediumGrey,
//                           ),
//                     CustomText(
//                       item["name"],
//                       fontSize: 16.sp,
//                       fontWeight: Fonts.bold,
//                     ),
//                     SizedBox(height: 6.h),
//                     Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomImage(
//                           source: Images.star,
//                           height: 18.h,
//                           width: 18.w,
//                           isSvg: true,
//                           color: AppColors.mediumGrey,
//                         ),
//                         SizedBox(width: 4.w),
//                         CustomText(
//                           "4.9",
//                           color: AppColors.mediumGrey,
//                           fontSize: 16.sp,
//                         ),
//                         SizedBox(width: 8.w),
//                         CustomImage(
//                           source: Images.clock,
//                           height: 18.h,
//                           width: 18.w,
//                           isSvg: true,
//                           color: AppColors.mediumGrey,
//                         ),
//                         SizedBox(width: 4.w),
//                         CustomText(
//                           "20 - 30 min",
//                           fontSize: 16.sp,
//                           color: AppColors.mediumGrey,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Container(
//                   child: CustomText(
//                     "₹ ${item["price"]}",
//                     color: AppColors.red,
//                     fontSize: 20.sp,
//                     fontWeight: Fonts.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildList(List<Map<String, dynamic>> data) {
//     return ListView.builder(
//       itemCount: data.length,
//       padding: EdgeInsets.only(top: 12.h,bottom: 50.h),
//       itemBuilder: (context, index) => _buildCard(data[index]),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         elevation: 0,
//         title: CustomText(
//           "Favorites",
//           fontSize: 24.sp,
//           fontWeight: Fonts.medium,
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: AppColors.textPrimary,
//           padding: EdgeInsets.only(bottom: 6.h),
//           labelStyle: TextStyle(
//             fontFamily: Fonts.fontFamilyLexend,
//             fontSize: 16.sp,
//           ),
//           indicatorColor: AppColors.red,
//           unselectedLabelColor: AppColors.greyText,
//           dividerHeight: 0,
//           tabs: const [
//             Tab(text: "Restaurant"),
//             Tab(text: "Food"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           state.isLoading
//               ? const FavoritesShimmer()
//               : _buildList(favouritesRestaurantList),
//           state.isLoading
//               ? const FavoritesShimmer()
//               : _buildList(favouritesFoodList),
//           // _buildList(favouritesRestaurantList),
//           // _buildList(favouritesFoodList),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import '../provider/favourites_provider.dart';
import '../widgets/favorites_shimmer.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load favorites on screen init
    Future.microtask(() => ref.read(favoritesProvider.notifier).loadFavorites());
  }

  Widget _buildCard(item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: CustomImage(
                  source: item["image"],
                  height: 180.h,
                  isNetwork: true,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 12.w,
                top: 12.h,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppColors.white,
                  ),
                  child: CustomImage(
                    source: Images.heartFilled,
                    height: 18.h,
                    width: 18.w,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item["vendor"] != null)
                      CustomText(
                        item["vendor"]!,
                        fontSize: 12.sp,
                        color: AppColors.mediumGrey,
                      ),
                    CustomText(
                      item["name"],
                      fontSize: 16.sp,
                      fontWeight: Fonts.bold,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        CustomImage(
                          source: Images.star,
                          height: 18.h,
                          width: 18.w,
                          isSvg: true,
                          color: AppColors.mediumGrey,
                        ),
                        SizedBox(width: 4.w),
                        CustomText("4.9", color: AppColors.mediumGrey, fontSize: 16.sp),
                        SizedBox(width: 8.w),
                        CustomImage(
                          source: Images.clock,
                          height: 18.h,
                          width: 18.w,
                          isSvg: true,
                          color: AppColors.mediumGrey,
                        ),
                        SizedBox(width: 4.w),
                        CustomText("20 - 30 min", color: AppColors.mediumGrey, fontSize: 16.sp),
                      ],
                    ),
                  ],
                ),
                CustomText(
                  "₹ ${item["price"]}",
                  color: AppColors.red,
                  fontSize: 20.sp,
                  fontWeight: Fonts.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List items) {
    return ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.only(top: 12.h, bottom: 50.h),
      itemBuilder: (context, index) => _buildCard(items[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          "Favorites",
          fontSize: 24.sp,
          fontWeight: Fonts.medium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.greyText,
          indicatorColor: AppColors.red,
          padding: EdgeInsets.only(bottom: 6.h),
          labelStyle: TextStyle(fontFamily: Fonts.fontFamilyLexend, fontSize: 16.sp),
          dividerHeight: 0,
          tabs: const [
            Tab(text: "Restaurant"),
            Tab(text: "Food"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          state.isLoading
              ? const FavoritesShimmer()
              : _buildList(state.restaurantFavorites),
          state.isLoading
              ? const FavoritesShimmer()
              : _buildList(state.foodFavorites),
        ],
      ),
    );
  }
}
