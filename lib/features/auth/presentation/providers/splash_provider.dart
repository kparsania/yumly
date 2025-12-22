import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/splash_controller.dart';

final splashProvider = StateNotifierProvider<SplashController, SplashState>((ref) {
  return SplashController();
});
