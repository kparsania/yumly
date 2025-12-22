import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/login_repository.dart';

// State
class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? error;

  AuthState({this.isLoading = false, this.isLoggedIn = false, this.error});
}

// Notifier
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = AuthState(isLoading: true);
    final success = await _repository.login(email, password);
    if (success) {
      state = AuthState(isLoggedIn: true);
    } else {
      state = AuthState(error: 'Invalid credentials');
    }
  }
}
