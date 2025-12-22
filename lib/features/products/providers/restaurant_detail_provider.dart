// import 'dart:ui';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:yumly/core/utils/Colors.dart';
// import '../../state/restaurant_detail_state.dart';
//
// class RestaurantDetailNotifier extends StateNotifier<RestaurantDetailState> {
//   RestaurantDetailNotifier() : super(RestaurantDetailState());
//
//   void setRestaurant(Map<String, dynamic> restaurant) {
//     state = state.copyWith(restaurant: restaurant);
//   }
//
//   final statusBarColorProvider = StateProvider<Color>((ref) {
//     return AppColors.primary;
//   });
// }
//
// final restaurantDetailProvider =
//     StateNotifierProvider<RestaurantDetailNotifier, RestaurantDetailState>(
//       (ref) => RestaurantDetailNotifier(),
//     );

import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/core/utils/Constants.dart';

import '../state/restaurant_detail_state.dart';

// Notifier for restaurant detail state
class RestaurantDetailNotifier extends StateNotifier<RestaurantDetailState> {
  RestaurantDetailNotifier() : super(RestaurantDetailState());

  void setRestaurant(Map<String, dynamic> restaurant) {
    state = state.copyWith(restaurant: restaurant, filters: filters);
  }
}

// Providers must be top-level
final restaurantDetailProvider =
    StateNotifierProvider<RestaurantDetailNotifier, RestaurantDetailState>(
      (ref) => RestaurantDetailNotifier(),
    );
