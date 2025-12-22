// /*
// GET https://api.spoonacular.com/recipes/complexSearch
// API Key 69f8df38d9eb4b9f99568098b1fae553
// https://spoonacular.com/food-api/docs
// * */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/Constants.dart';
import '../state/dashboard_state.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey categoriesKey = GlobalKey();

  DashboardNotifier()
      : super(
    DashboardState(
      menuItems: menuItems,
      restaurantItems: restaurants,
      topRatedRestaurants: topRatedRestaurants,
    ),
  ) {
    scrollController.addListener(_onScroll);
    _initHeaderAnimation();
    fetchData();
  }

  /// Trigger header animation on init
  void _initHeaderAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isHeaderVisible: true);
  }

  void _onScroll() {
    final offset = scrollController.offset;

    // Background fade
    final newOpacity = (offset / 120).clamp(0.0, 1.0);
    if (newOpacity != state.appBarOpacity) {
      state = state.copyWith(appBarOpacity: newOpacity);
    }

    // Address visibility
    const addressHideThreshold = 80.0;
    final shouldShowAddress = offset < addressHideThreshold;
    if (shouldShowAddress != state.isAddressVisible) {
      state = state.copyWith(isAddressVisible: shouldShowAddress);
    }

    // Category stickiness
    if (categoriesKey.currentContext != null) {
      final box =
      categoriesKey.currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      final safeTop =
          MediaQuery.of(categoriesKey.currentContext!).padding.top;
      final shouldShowCats = position.dy <= safeTop + kToolbarHeight +7.h;

      if (shouldShowCats != state.isCategoriesVisible) {
        state = state.copyWith(isCategoriesVisible: shouldShowCats);
      }
    }
  }

  // Simulated API call
  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isLoading: false,
      menuItems: menuItems,
      topRatedRestaurants: topRatedRestaurants,
    );
  }

  void changeCategory(int index) {
    state = state.copyWith(selectedCategoryIndex: index);
  }

  void changeAddress(String address) {
    state = state.copyWith(selectedAddress: address);
  }

  void toggleSearch(bool isVisible) {
    state = state.copyWith(isSearchVisible: isVisible);
  }

  void showBackground() {
    state = state.copyWith(isBackgroundVisible: true);
  }

  void openTopSheet() {
    state = state.copyWith(isTopSheetOpen: true);
  }

  void closeTopSheet() {
    state = state.copyWith(isTopSheetOpen: false);
  }

}

final dashboardProvider =
StateNotifierProvider<DashboardNotifier, DashboardState>(
      (ref) => DashboardNotifier(),
);
