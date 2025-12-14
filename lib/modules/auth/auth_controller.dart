import 'package:get/get.dart';
import 'package:ordermanagement/data/repositories/auth_repository.dart';
import 'package:ordermanagement/utils/routes/app_routes.dart';

class AuthController extends GetxController{

  final repo=AuthRepository();
  var isLoading=false.obs;
  var isPasswordVisible =false.obs;
  var error = "".obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final user = await repo.login(email, password);

      if (user != null) {
        Get.offAllNamed(Routes.home);
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar("Login Error", error.value);
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;
      final user = await repo.register(email, password);

      if (user != null) {
        Get.offAllNamed('/orders');
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar("Registration Error", error.value);
    } finally {
      isLoading.value = false;
    }
  }

}