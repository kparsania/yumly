// class DashboardState {
//   final bool isLoading;
//   final bool isHeaderCollapsed;
//   final List menuItems;
//   final List restaurantItems;
//   final List topRatedRestaurants;
//   final String? errorMessage;
//   final bool isHeaderVisible;
//   final bool isAddressVisible;
//   final bool isSearchSticky;
//   final double scrollOffset;
//   final int selectedCategoryIndex;
//   final String selectedAddress;
//   final bool isSearchVisible;
//   final  bool isBackgroundVisible;
//
//
//   DashboardState({
//     this.isLoading = false,
//     this.isHeaderCollapsed = false,
//     this.menuItems = const [],
//     this.restaurantItems = const [],
//     this.topRatedRestaurants = const [],
//     this.errorMessage,
//     this.isHeaderVisible = true,
//     this.isAddressVisible = true,
//     this.isSearchSticky = false,
//     this.scrollOffset = 0.0,
//     this.selectedCategoryIndex = 0,
//     this.selectedAddress = "Home - 221B Baker Street",
//     this.isSearchVisible = true,
//     this.isBackgroundVisible = false,
//   });
//
//   DashboardState copyWith({
//     bool? isLoading,
//     bool? isHeaderCollapsed,
//     List? menuItems,
//     List? restaurantItems,
//     List? topRatedRestaurants,
//     String? errorMessage,
//     bool? isHeaderVisible,
//     bool? isAddressVisible,
//     bool? isSearchSticky,
//     double? scrollOffset,
//     int? selectedCategoryIndex,
//     String? selectedAddress,
//     bool? isSearchVisible,
//     bool? isBackgroundVisible,
//   }) {
//     return DashboardState(
//       isLoading: isLoading ?? this.isLoading,
//       isHeaderCollapsed: isHeaderCollapsed ?? this.isHeaderCollapsed,
//       menuItems: menuItems ?? this.menuItems,
//       restaurantItems: restaurantItems ?? this.restaurantItems,
//       topRatedRestaurants: topRatedRestaurants ?? this.topRatedRestaurants,
//       errorMessage: errorMessage ?? this.errorMessage,
//       isHeaderVisible: isHeaderVisible ?? this.isHeaderVisible,
//       isAddressVisible: isAddressVisible ?? this.isAddressVisible,
//       isSearchSticky: isSearchSticky ?? this.isSearchSticky,
//       scrollOffset: scrollOffset ?? this.scrollOffset,
//       selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
//       selectedAddress: selectedAddress ?? this.selectedAddress,
//       isSearchVisible: isSearchVisible ?? this.isSearchVisible,
//       isBackgroundVisible: isBackgroundVisible ?? this.isBackgroundVisible,
//     );
//   }
// }
//
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:yumly/core/utils/Constants.dart';
// //
// // final class DashboardState {
// //   final bool isLoading;
// //   final List menuItems;
// //
// //   DashboardState({this.isLoading = true, this.menuItems = const []});
// //
// //   DashboardState copyWith({bool? isLoading, List? menuItems}) {
// //     return DashboardState(
// //       isLoading: isLoading ?? this.isLoading,
// //       menuItems: menuItems ?? this.menuItems,
// //     );
// //   }
// // }
// //
// // class DashboardController extends StateNotifier<DashboardState> {
// //   DashboardController() : super(DashboardState());
// //
// //   Future<void> fetchRestaurants() async {}
// //
// //   void loadSampleRestaurants() {
// //     state = state.copyWith(menuItems: menuItems);
// //   }
// // }
// //
// // final dashboardProvider =
// //     StateNotifierProvider<DashboardController, DashboardState>(
// //       (ref) => DashboardController(),
// //     );

class DashboardState {
  final bool isLoading;
  final List menuItems;
  final List restaurantItems;
  final List topRatedRestaurants;
  final String? errorMessage;

  // Header & scroll-related
  final bool isHeaderVisible;
  final bool isAddressVisible;
  final bool isCategoriesVisible;
  final double appBarOpacity;
  final double scrollOffset;

  // Search & categories
  final bool isSearchSticky;
  final bool isSearchVisible;
  final int selectedCategoryIndex;
  final String selectedAddress;

  // Banner/Background
  final bool isBackgroundVisible;

  // Top sheet
  final bool isTopSheetOpen;

  DashboardState({
    this.isLoading = false,
    this.menuItems = const [],
    this.restaurantItems = const [],
    this.topRatedRestaurants = const [],
    this.errorMessage,
    this.isHeaderVisible = true,
    this.isAddressVisible = true,
    this.isCategoriesVisible = false,
    this.appBarOpacity = 0.0,
    this.scrollOffset = 0.0,
    this.isSearchSticky = false,
    this.isSearchVisible = true,
    this.selectedCategoryIndex = 0,
    this.selectedAddress = "Home - 221B Baker Street",
    this.isBackgroundVisible = false,
    this.isTopSheetOpen = false,
  });

  DashboardState copyWith({
    bool? isLoading,
    List? menuItems,
    List? restaurantItems,
    List? topRatedRestaurants,
    String? errorMessage,
    bool? isHeaderVisible,
    bool? isAddressVisible,
    bool? isCategoriesVisible,
    double? appBarOpacity,
    double? scrollOffset,
    bool? isSearchSticky,
    bool? isSearchVisible,
    int? selectedCategoryIndex,
    String? selectedAddress,
    bool? isBackgroundVisible,
    bool? isTopSheetOpen,

  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      menuItems: menuItems ?? this.menuItems,
      restaurantItems: restaurantItems ?? this.restaurantItems,
      topRatedRestaurants: topRatedRestaurants ?? this.topRatedRestaurants,
      errorMessage: errorMessage ?? this.errorMessage,
      isHeaderVisible: isHeaderVisible ?? this.isHeaderVisible,
      isAddressVisible: isAddressVisible ?? this.isAddressVisible,
      isCategoriesVisible: isCategoriesVisible ?? this.isCategoriesVisible,
      appBarOpacity: appBarOpacity ?? this.appBarOpacity,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      isSearchSticky: isSearchSticky ?? this.isSearchSticky,
      isSearchVisible: isSearchVisible ?? this.isSearchVisible,
      selectedCategoryIndex:
      selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      isBackgroundVisible: isBackgroundVisible ?? this.isBackgroundVisible,
      isTopSheetOpen: isTopSheetOpen ?? this.isTopSheetOpen,
    );
  }
}
