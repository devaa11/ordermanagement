import 'package:flutter/cupertino.dart';

import '../../utils/constants/sizes.dart';

class AppSpacingStyles {

  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight, // Assuming the app bar height is 56.0
    left: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
  );
  // Add more spacing constants as needed
}