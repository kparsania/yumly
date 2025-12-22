import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabBarVisibilityProvider = StateProvider<bool>((ref) => true);
final currentTabIndexProvider = StateProvider<int>((ref) => 0);
