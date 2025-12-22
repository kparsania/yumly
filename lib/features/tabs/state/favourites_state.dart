// class FavouritesState {
//   final bool isLoading;
//   final bool isRestaurants;
//
//
//   FavouritesState({
//     this.isLoading = false,
//     this.isRestaurants = true,
//   });
//
//   FavouritesState copyWith({
//     bool? isLoading,
//     bool? isRestaurants,
//   }) {
//     return FavouritesState(
//       isLoading: isLoading ?? this.isLoading,
//       isRestaurants: isRestaurants ?? this.isRestaurants,
//     );
//   }
// }
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

