// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../state/login_controller.dart';
// import '../../data/login_repository.dart';
//
// // Repository Provider
// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   return AuthRepository();
// });
//
// // StateNotifier Provider
// final authControllerProvider =
// StateNotifierProvider<AuthController, AuthState>((ref) {
//   final repo = ref.read(authRepositoryProvider);
//   return AuthController(repo);
// });
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>(
      (ref) => LoginFormNotifier(),
    );

class LoginFormState {
  final String number;
  final String password;
  final String? numberError;
  final String? passwordError;

  LoginFormState({
    this.number = '',
    this.password = '',
    this.numberError,
    this.passwordError,
  });

  LoginFormState copyWith({
    String? number,
    String? password,
    String? numberError,
    String? passwordError,
  }) {
    return LoginFormState(
      number: number ?? this.number,
      password: password ?? this.password,
      numberError: numberError ?? this.numberError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

  void updateNumber(String number) {
    state = state.copyWith(
      number: number,
      numberError: "",
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordError: "",
    );
  }

  bool validateForm() {
    final isValidNumber = RegExp(r'^\d{10}$').hasMatch(state.number.trim());
    final isValidPassword = state.password.trim().length >= 6;

    state = state.copyWith(
      numberError: isValidNumber
          ? null
          : 'Please enter a valid 10-digit number',
      passwordError: isValidPassword
          ? null
          : 'Password must be at least 6 characters',
    );
    return isValidNumber && isValidPassword;
  }
}
