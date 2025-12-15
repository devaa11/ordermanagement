import 'package:flutter/material.dart';
import 'package:ordermanagement/utils/theme/appbar_theme.dart';
import 'package:ordermanagement/utils/theme/textFormFieldTheme.dart';
import 'package:ordermanagement/utils/theme/text_theme.dart';



import '../constants/colors.dart';
import 'bottom_sheet_theme.dart';
import 'checkbox_theme.dart';
import 'chip_theme.dart';
import 'elevated_button_theme.dart';
import 'outlined_button_theme.dart';

class CustomAppTheme {
  CustomAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppColors.lightGrey,
    appBarTheme: AppBarrTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme:AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    cardColor: AppColors.white,

  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AppColors.grey,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarrTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
    cardColor: const Color(0xFF1E1E1E),
  );
}
