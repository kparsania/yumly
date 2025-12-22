import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/core/utils/Constants.dart';

import '../state/categories_state.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  CategoriesNotifier() : super(CategoriesState(categoriesList: categories));
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>(
      (ref) => CategoriesNotifier(),
    );
