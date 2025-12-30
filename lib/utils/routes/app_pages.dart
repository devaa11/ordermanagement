
import 'package:get/get.dart';
import 'package:ordermanagement/modules/Home/home_screen.dart';
import 'package:ordermanagement/modules/Prodcuts/add_product_screen.dart';
import 'package:ordermanagement/modules/auth/signup/signup_screen.dart';
import 'package:ordermanagement/modules/orders/views/add_order_Screen.dart';
import 'package:ordermanagement/modules/orders/views/order_details_screen.dart';

import '../../modules/auth/login/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.signup,
      page: () => SignupScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.addOrders,
      page: () => AddOrderScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.orderdetails,
      page: () => OrderDetailsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.addProducts,
      page: () => AddProductScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}
