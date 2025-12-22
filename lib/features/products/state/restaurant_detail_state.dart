class RestaurantDetailState {
  final bool isLoading;
  final Map<String, dynamic>? restaurant;
  final List? filters;

  RestaurantDetailState({this.isLoading = false, this.restaurant, this.filters});

  RestaurantDetailState copyWith({
    bool? isLoading,
    Map<String, dynamic>? restaurant,
    List? filters,
  }) {
    return RestaurantDetailState(
      isLoading: isLoading ?? this.isLoading,
      restaurant: restaurant ?? this.restaurant,
      filters: filters ?? this.filters,
    );
  }
}