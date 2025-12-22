import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/Constants.dart';
import '../state/reorder_state.dart';

class ReorderNotifier extends StateNotifier<ReorderState> {
  ReorderNotifier()
      : super(
    ReorderState(
      reorderRestaurants:  reorderRestaurants,
    ))  ;

  // void toggleFavorite(int index) {
  //   final updated = [...state];
  //   final restaurant = updated[index];
  //   updated[index] = Restaurant(
  //     name: restaurant.name,
  //     image: restaurant.image,
  //     time: restaurant.time,
  //     subtitle: restaurant.subtitle,
  //     dishes: restaurant.dishes,
  //     isFavorite: !restaurant.isFavorite,
  //   );
  //   state = updated;
  // }
}

final reorderProvider =
StateNotifierProvider<ReorderNotifier, ReorderState>((ref) {
  return ReorderNotifier();
});
