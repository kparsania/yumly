// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final dineoutHeaderProvider = StateNotifierProvider<DineOutHeaderNotifier, DineoutHeaderState>((ref) {
//   return DineOutHeaderNotifier();
// });
//
// class DineoutHeaderState {
//   final double opacity;
//   final bool showAddress;
//
//   DineoutHeaderState({this.opacity = 0.0, this.showAddress = true});
//
//   DineoutHeaderState copyWith({double? opacity, bool? showAddress}) {
//     return DineoutHeaderState(
//       opacity: opacity ?? this.opacity,
//       showAddress: showAddress ?? this.showAddress,
//     );
//   }
// }
//
// class DineOutHeaderNotifier extends StateNotifier<DineoutHeaderState> {
//   DineOutHeaderNotifier() : super(DineoutHeaderState());
//
//   void updateScroll(double offset, bool showAddress) {
//     final newOpacity = (offset / 120).clamp(0.0, 1.0);
//     if (newOpacity != state.opacity || showAddress != state.showAddress) {
//       state = state.copyWith(opacity: newOpacity, showAddress: showAddress);
//     }
//   }
// }
//
// class DineoutScrollNotifier extends StateNotifier<bool> {
//   DineoutScrollNotifier() : super(false);
//
//   void updateScroll(double offset) {
//     if (offset > 40 && state == false) {
//       state = true;
//     } else if (offset <= 40 && state == true) {
//       state = false;
//     }
//   }
// }
// final dineoutScrollProvider =
// StateNotifierProvider<DineoutScrollNotifier, bool>((ref) {
//   return DineoutScrollNotifier();
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/core/utils/Constants.dart';

import '../state/dineout_state.dart';

/// ----------------------
/// NOTIFIER
/// ----------------------
class DineOutHeaderNotifier extends StateNotifier<DineoutHeaderState> {
  DineOutHeaderNotifier()
      : super(
    DineoutHeaderState(
      spotlightRestaurants: spotlightRestaurants,
      mustTriesArray: mustTries,
      lookingFor: lookingFor,
      featuredRestaurants: featuredRestaurants,
      drinksDessertsRestaurants: drinksDesserts,
      popularRestaurants: popularRestaurants,
    )
  ){
    setInitialLoading();
  }

  /// Call this from scroll listener
  void updateScroll(double offset) {
    // Fade out address smoothly (0 → invisible at 100px scroll)
    final newOpacity = (1 - (offset / 100)).clamp(0.0, 1.0);

    // Address should be visible only when opacity > 0
    final shouldShowAddress = newOpacity > 0.05;

    // Stick search bar when offset passes threshold
    final isSearchSticky = offset > 60;

    state = state.copyWith(
      opacity: newOpacity,
      showAddress: shouldShowAddress,
      searchSticky: isSearchSticky,
    );
  }

  void updateSpotlightHighlightIndex(index) {
    state = state.copyWith(focusedIndex: index);
  }

  // void updateFeaturedIndex(index) {
  //   state.copyWith(featuredFocusedIndex: index);
  // }

  void updateFeaturedIndex(int index) {
    print('updated index:: ${index}');
    state = state.copyWith(featuredFocusedIndex: index);
  }

  Future<void> setInitialLoading() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
  }
}


/// ----------------------
/// PROVIDER
/// ----------------------
final dineoutHeaderProvider =
StateNotifierProvider<DineOutHeaderNotifier, DineoutHeaderState>((ref) {
  return DineOutHeaderNotifier();
});
