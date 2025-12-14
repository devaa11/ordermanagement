import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static final TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.dark),
    headlineMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: AppColors.dark),
    headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.dark),

    titleLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.dark),
    titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.dark),
    titleSmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.dark),

    bodyLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.dark),
    bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: AppColors.dark),
    bodySmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.dark.withOpacity(0.5)),

    labelLarge: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: AppColors.dark),
    labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: AppColors.dark.withOpacity(0.5)),
  );

  static final TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.light),
    headlineMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: AppColors.light),
    headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.light),

    titleLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.light),
    titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.light),
    titleSmall: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.light),

    bodyLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.light),
    bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: AppColors.light),
    bodySmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.light.withOpacity(0.5)),

    labelLarge: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: AppColors.light),
    labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: AppColors.light.withOpacity(0.5)),
  );
}
