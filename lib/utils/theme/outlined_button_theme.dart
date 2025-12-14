import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class AppOutlinedButtonTheme {
  AppOutlinedButtonTheme._();


  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.dark,
      side: const BorderSide(color: AppColors.borderPrimary),
      textStyle:  TextStyle(fontSize: 16.sp, color: AppColors.black, fontWeight: FontWeight.w600),
      padding:  EdgeInsets.symmetric(vertical: AppSizes.buttonHeight.h, horizontal:AppSizes.buttonHeight.w+2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius.r)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.light,
      side: const BorderSide(color: AppColors.borderPrimary),
      textStyle:  TextStyle(fontSize: 16.sp, color: AppColors.textWhite, fontWeight: FontWeight.w600),
      padding:  EdgeInsets.symmetric(vertical: AppSizes.buttonHeight.h, horizontal: AppSizes.buttonHeight.w+2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
    ),
  );
}
