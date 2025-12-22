import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ----------------------
/// STATE
/// ----------------------
class DineoutHeaderState {
  final bool isLoading;
  final double opacity;
  final bool showAddress;
  final bool searchSticky;
  final int focusedIndex;
  final int featuredFocusedIndex;
  final List<dynamic>? spotlightRestaurants;
  final List<dynamic>? mustTriesArray;
  final List<dynamic>? lookingFor;
  final List<dynamic>? featuredRestaurants;
  final List<dynamic>? drinksDessertsRestaurants;
  final List<dynamic>? popularRestaurants;

  DineoutHeaderState({
    this.isLoading = false,
    this.opacity = 1.0,
    this.showAddress = true,
    this.searchSticky = false,
    this.focusedIndex =0,
    this.featuredFocusedIndex =0,
    this.spotlightRestaurants,
    this.mustTriesArray,
    this.lookingFor,
    this.featuredRestaurants,
    this.drinksDessertsRestaurants,
    this.popularRestaurants,
  });

  DineoutHeaderState copyWith({
    bool? isLoading,
    double? opacity,
    bool? showAddress,
    bool? searchSticky,
    int? focusedIndex,
    int? featuredFocusedIndex,
    List? spotlightRestaurants,
    List? mustTriesArray,
    List? lookingFor,
    List? featuredRestaurants,
    List? drinksDessertsRestaurants,
    List? popularRestaurants,
  }) {
    return DineoutHeaderState(
      isLoading: isLoading ?? this.isLoading,
      opacity: opacity ?? this.opacity,
      showAddress: showAddress ?? this.showAddress,
      searchSticky: searchSticky ?? this.searchSticky,
      focusedIndex: focusedIndex ?? this.focusedIndex,
      featuredFocusedIndex: featuredFocusedIndex ?? this.featuredFocusedIndex,
      spotlightRestaurants: spotlightRestaurants ?? this.spotlightRestaurants,
      mustTriesArray: mustTriesArray ?? this.mustTriesArray,
      lookingFor: lookingFor ?? this.lookingFor,
      featuredRestaurants: featuredRestaurants ?? this.featuredRestaurants,
      drinksDessertsRestaurants: drinksDessertsRestaurants ?? this.drinksDessertsRestaurants,
      popularRestaurants: popularRestaurants ?? this.popularRestaurants,
    );
  }
}