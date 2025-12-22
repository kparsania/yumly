// Handles actual products API

class AuthRepository {
  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return email == "test.dart@example.com" && password == "password123";
  }
}
