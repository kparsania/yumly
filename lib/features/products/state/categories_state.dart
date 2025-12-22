class CategoriesState {
  final bool isLoading;
  final List categoriesList;

  CategoriesState({
    this.isLoading = false,
    this.categoriesList = const [],
  });

  CategoriesState copyWith({
    bool? isLoading,
    List? categoriesList,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      categoriesList: categoriesList ?? this.categoriesList,
    );
  }
}
