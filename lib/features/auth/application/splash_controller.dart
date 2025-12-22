import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashState {
  final bool isComplete;
  final List<bool> visibleLetters;

  SplashState({required this.isComplete, required this.visibleLetters});

  SplashState copyWith({bool? isComplete, List<bool>? visibleLetters}) {
    return SplashState(
      isComplete: isComplete ?? this.isComplete,
      visibleLetters: visibleLetters ?? this.visibleLetters,
    );
  }
}

class SplashController extends StateNotifier<SplashState> {
  SplashController()
    : super(
        SplashState(isComplete: false, visibleLetters: List.filled(5, false)),
      );

  void showLetter(int index) {
    final updated = [...state.visibleLetters];
    updated[index] = true;
    state = state.copyWith(visibleLetters: updated);
  }

  void completeSplash() {
    state = state.copyWith(isComplete: true);
  }
}
