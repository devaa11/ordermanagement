import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';


class AppBarrTheme{
  AppBarrTheme._();

  static final lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.black, size: AppSizes.iconMd.sp),
    actionsIconTheme: IconThemeData(color: AppColors.black, size: AppSizes.iconMd.sp),
    titleTextStyle: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.w600, color: AppColors.black),
  );
  static final darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.white, size: AppSizes.iconMd.sp),
    actionsIconTheme: IconThemeData(color: AppColors.white, size: AppSizes.iconMd.sp),
    titleTextStyle: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.w600, color: AppColors.white),
  );
}