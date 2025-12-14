import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_services.dart';

class AuthRepository {
  final AuthService service = AuthService();

  Future<User?> login(String email, String password) async {
    try {
      return await service.login(email, password);
    } catch (e) {
      throw "Login failed: $e";
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      return await service.register(email, password);
    } catch (e) {
      throw "Registration failed: $e";
    }
  }

  Future<void> logout() => service.logout();
}
