class ReorderState {
  final bool isLoading;
  final List? reorderRestaurants;


  ReorderState({
    this.isLoading = false,
    this.reorderRestaurants,
  });

  ReorderState copyWith({
    bool? isLoading,
    List? reorderRestaurants,
  }) {
    return ReorderState(
      isLoading: isLoading ?? this.isLoading,
      reorderRestaurants: reorderRestaurants ?? this.reorderRestaurants,
    );
  }
}