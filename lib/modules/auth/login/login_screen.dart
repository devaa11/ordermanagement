import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/modules/auth/auth_controller.dart';
import 'package:ordermanagement/utils/constants/colors.dart';
import 'package:ordermanagement/utils/constants/sizes.dart';
import 'package:ordermanagement/utils/constants/spacing_styles.dart';
import 'package:ordermanagement/utils/routes/app_routes.dart';
import 'package:ordermanagement/utils/theme/text_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    final AuthController _authController=Get.put(AuthController());
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final _loginformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppSpacingStyles.paddingWithAppBarHeight,
        child: SingleChildScrollView  (
          child: Center(
            child: Form(
              key: _loginformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.spaceBtwSections *2),
              
                  Text("Welecome \n Back!",style: Theme.of(context).textTheme.headlineLarge,),
              
                  SizedBox(height: AppSizes.spaceBtwSections),
              
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
              
                      return null;
                    },
                  ),
              
                  SizedBox(height: AppSizes.spaceBtwInputFields,),


                  Obx(() {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: !_authController
                          .isPasswordVisible.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(

                        labelText: "Password",
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              _authController.isPasswordVisible.toggle(),
                          icon: Icon(
                              _authController.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                        ),
                      ),
                    );
                  }),
              
                  SizedBox(height: AppSizes.spaceBtwSections),

                  Obx((){
                    return  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: (){
                            if(_loginformKey.currentState!.validate()){
                              final email=_emailController.text.trim();
                              final pass=_passwordController.text.trim();
                              _authController.login(email,pass);
                            }

                          },
                          child: _authController.isLoading.value? CircularProgressIndicator(): Text("Login")),
                    );

                  }),
              

                  SizedBox(height: AppSizes.spaceBtwSections,),

                  Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: Theme.of(context).textTheme.bodyLarge,),
                      TextButton(onPressed: (){
                        Get.toNamed(Routes.signup);
                      },
                          child: Text("Sign up",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.buttonPrimary.withAlpha(200)
                          )))
                    ],
                  )),
              
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
