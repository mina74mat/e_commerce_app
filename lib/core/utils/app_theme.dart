import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
          color: AppColors.primaryColor
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showUnselectedLabels: false, showSelectedLabels: false, elevation: 0),
  );
}
