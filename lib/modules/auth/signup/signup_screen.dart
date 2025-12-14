import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/spacing_styles.dart';
import '../../../utils/routes/app_routes.dart';
import '../auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController _authController=Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signupformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppSpacingStyles.paddingWithAppBarHeight,
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _signupformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.spaceBtwSections *2),

                  Text("Create an \naccount",style: Theme.of(context).textTheme.headlineLarge,),

                  SizedBox(height: AppSizes.spaceBtwSections),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your name";
                      }
                      final name = value.trim();
                      if (name.length < 2) {
                        return "Name must be at least 2 characters";
                      }
                      final pattern = r"^[A-Za-z\s'-]+$";
                      final regex = RegExp(pattern);
                      if (!regex.hasMatch(name)) {
                        return "Name can only contain letters, spaces, hyphens and apostrophes";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: AppSizes.spaceBtwInputFields,),

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
                  SizedBox(height: AppSizes.spaceBtwInputFields,),

                  Obx(() {
                    return TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_authController.isPasswordVisible.value,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm Password is required";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        if (value != _passwordController.text.trim()) {
                          return "Passwords do not match";
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          onPressed: () => _authController.isPasswordVisible.toggle(),
                          icon: Icon(
                            _authController.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: AppSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                          if(_signupformKey.currentState!.validate()){
                            final email=_emailController.text.trim();
                            final pass=_passwordController.text.trim();
                            _authController.register(email,pass);
                          }

                        },
                        child: Text("Create Account")),
                  ),

                  SizedBox(height: AppSizes.spaceBtwSections,),

                  Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("I Already Have an Account",style: Theme.of(context).textTheme.bodyLarge,),
                          TextButton(onPressed: (){
                            Get.offAllNamed(Routes.login);
                          },
                              child: Text("Log in",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
