import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/data/repositories/auth_repository.dart';
import 'package:ordermanagement/utils/helpers/loaders.dart';
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

    } on FirebaseAuthException catch (e) {
      Loaders.errorSnackBar(
        title: "Login Error",
        message: e.message ?? "Something went wrong",
      );

    } catch (e) {
      Loaders.errorSnackBar(
        title: "Error",
        message: "Something went wrong",
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;
      final user = await repo.register(email, password);

      if (user != null) {
        Loaders.successSnackBar(
            title: "Success",
            message: "Registration Successful"
        );
        Get.offAllNamed(Routes.home);
      }

    } on FirebaseAuthException catch (e) {
      Loaders.errorSnackBar(
          title: "Registration Error",
          message: e.message ?? "Something went wrong"
      );

    } catch (e) {
      Loaders.errorSnackBar(
          title: "Error",
          message: "Unexpected error occurred"
      );

    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await repo.logout();

      Get.offAllNamed(Routes.login);

    } catch (e) {
      Loaders.errorSnackBar(
        title: "Error",
        message: "Failed to logout. Please try again.",
      );
    } finally {
      isLoading.value = false;
    }
  }


}