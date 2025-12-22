// Handles actual SignUp API

class SignUpRepository {
  Future<bool> signUp(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return email == "test.dart@example.com" && password == "password123";
  }
}
