import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_services.dart';

class AuthRepository {
  final AuthService service = AuthService();

  Future<User?> login(String email, String password) async {
    try {
      return await service.login(email, password);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      return await service.register(email, password);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() => service.logout();
}
