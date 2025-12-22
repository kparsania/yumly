import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpFormProvider =
    StateNotifierProvider<SignUpFormNotifier, SignUpFormState>(
      (ref) => SignUpFormNotifier(),
    );

class SignUpFormState {
  final String name;
  final String number;
  final String password;
  final String confirmPassword;
  final String? nameError;
  final String? numberError;
  final String? confirmPasswordError;
  final String? passwordError;

  SignUpFormState({
    this.name = '',
    this.number = '',
    this.password = '',
    this.confirmPassword = '',
    this.nameError,
    this.numberError,
    this.confirmPasswordError,
    this.passwordError,
  });

  SignUpFormState copyWith({
    String? name,
    String? number,
    String? password,
    String? confirmPassword,
    String? numberError,
    String? nameError,
    String? confirmPasswordError,
    String? passwordError,
  }) {
    return SignUpFormState(
      name: name ?? this.name,
      number: number ?? this.number,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      numberError: numberError,
      nameError: nameError,
      confirmPasswordError: confirmPasswordError,
      passwordError: passwordError,
    );
  }
}

class SignUpFormNotifier extends StateNotifier<SignUpFormState> {
  SignUpFormNotifier() : super(SignUpFormState());

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateNumber(String number) {
    state = state.copyWith(number: number);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  bool validateForm() {
    final isNameEmpty = state.name.trim().isEmpty;
    final isNumberEmpty = state.number.trim().isEmpty;
    final isPasswordEmpty = state.password.trim().isEmpty;
    final isConfirmPasswordEmpty = state.confirmPassword.trim().isEmpty;

    if (isNameEmpty ||
        isNumberEmpty ||
        isPasswordEmpty ||
        isConfirmPasswordEmpty) {
      state = state.copyWith(
        nameError: isNameEmpty ? 'Name cannot be empty' : null,
        numberError: isNumberEmpty ? 'Number cannot be empty' : null,
        passwordError: isPasswordEmpty ? 'Password cannot be empty' : null,
        confirmPasswordError: isConfirmPasswordEmpty
            ? 'Confirm Password cannot be empty'
            : null,
      );
      return false;
    }

    final isValidName = state.name.trim().isNotEmpty;
    final isValidNumber = RegExp(r'^\d{10}$').hasMatch(state.number.trim());
    final isValidPassword = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
    ).hasMatch(state.password.trim());
    final isValidConfirmPassword = state.password == state.confirmPassword;

    state = state.copyWith(
      nameError: isValidName ? null : 'Invalid name',
      numberError: isValidNumber
          ? null
          : 'Please enter a valid 10-digit number',
      passwordError: isValidPassword
          ? null
          : 'Password must be at least 6 characters, include 1 uppercase, 1 lowercase, 1 number, and 1 special character',
      confirmPasswordError: isValidConfirmPassword
          ? null
          : 'Confirm Password and Password must match',
    );

    return isValidName &&
        isValidNumber &&
        isValidPassword &&
        isValidConfirmPassword;
  }
}
