import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/route/screenNames.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/tabs/provider/favourites_provider.dart';
import 'package:yumly/features/tabs/widgets/dashboard_featured_restaurants.dart';

import '../data/restaurant_catalog.dart';

class RestaurantListScreen extends ConsumerStatefulWidget {
  const RestaurantListScreen({
    super.key,
    required this.title,
    required this.restaurants,
  });

  final String title;
  final List<Map<String, dynamic>> restaurants;

  @override
  ConsumerState<RestaurantListScreen> createState() =>
      _RestaurantListScreenState();
}

class _RestaurantListScreenState extends ConsumerState<RestaurantListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final saved = ref.watch(savedRestaurantNamesProvider);
    final visible = restaurantsForQuery(_query, source: widget.restaurants);

    return Scaffold(
      backgroundColor: AppColors.white,
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
          widget.title,
          fontWeight: Fonts.bold,
          fontSize: 18.sp,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: "Search in ${widget.title}",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.mediumGrey,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.greyIcon,
                  size: 22.sp,
                ),
                filled: true,
                fillColor: AppColors.blueLight,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? Center(
                    child: CustomText(
                      'No restaurants found',
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                    itemCount: visible.length,
                    itemBuilder: (context, index) {
                      final item = visible[index];
                      final name = (item['restaurant'] ?? '').toString();
                      return GestureDetector(
                        onTap: () => context.pushNamed(
                          ScreenNames.RESTAURANT_DETAIL,
                          extra: item,
                        ),
                        child: FeaturedRestaurantsCard(
                          image: item['image'] ?? '',
                          rating: '${item['rating'] ?? ''}',
                          reviews: '${item['reviews'] ?? ''}',
                          restaurantName: name,
                          location: item['location'] ?? item['address'] ?? '',
                          price: '${item['price'] ?? ''}',
                          deliveryTime: item['deliveryTime'] ?? '',
                          quantity: '${item['quantity'] ?? ''}',
                          startingPrice: '${item['startingPrice'] ?? ''}',
                          categories: item['categories'] ?? '',
                          isFavourite: saved.contains(name),
                          onFavouriteTap: () => ref
                              .read(savedRestaurantNamesProvider.notifier)
                              .update((names) {
                                final next = {...names};
                                if (!next.add(name)) next.remove(name);
                                return next;
                              }),
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
