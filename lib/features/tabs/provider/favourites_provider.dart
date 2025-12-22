// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../state/favourites_state.dart';
//
// class FavouritesNotifier extends StateNotifier<FavouritesState> {
//   late ScrollController scrollController;
//
//   FavouritesNotifier() : super(FavouritesState()) {}
//
//   void onTabTap(isRestaurants) {
//     state = state.copyWith(isRestaurants: isRestaurants ? true : false);
//   }
//
//   void isImageLoading(isLoading) {
//     state = state.copyWith(isLoading: isLoading);
//   }
// }
//
// final favouritesProvider =
//     StateNotifierProvider<FavouritesNotifier, FavouritesState>(
//       (ref) => FavouritesNotifier(),
//     );

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/Constants.dart';

// State
class FavoritesState {
  final bool isLoading;
  final List restaurantFavorites;
  final List foodFavorites;

  FavoritesState({
    this.isLoading = false,
    this.restaurantFavorites = const [],
    this.foodFavorites = const [],
  });

  FavoritesState copyWith({
    bool? isLoading,
    List? restaurantFavorites,
    List? foodFavorites,
  }) {
    return FavoritesState(
      isLoading: isLoading ?? this.isLoading,
      restaurantFavorites: restaurantFavorites ?? this.restaurantFavorites,
      foodFavorites: foodFavorites ?? this.foodFavorites,
    );
  }
}

// Notifier
class FavoritesNotifier extends StateNotifier<FavoritesState> {
  FavoritesNotifier() : super(FavoritesState());

  // Simulated fetch
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(
      isLoading: false,
      restaurantFavorites: favouritesRestaurantList,
      foodFavorites: favouritesFoodList,
    );
  }
}

// Provider
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>(
      (ref) => FavoritesNotifier(),
    );
