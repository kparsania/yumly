import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/signup_repository.dart';

// State
class SignUpState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? error;

  SignUpState({this.isLoading = false, this.isLoggedIn = false, this.error});
}

// Notifier
class SignUpController extends StateNotifier<SignUpState> {
  final SignUpRepository _repository;

  SignUpController(this._repository) : super(SignUpState());

  Future<void> signUp(String email, String password) async {
    state = SignUpState(isLoading: true);
    final success = await _repository.signUp(email, password);
    if (success) {
      state = SignUpState(isLoggedIn: true);
    } else {
      state = SignUpState(error: 'Invalid credentials');
    }
  }
}
