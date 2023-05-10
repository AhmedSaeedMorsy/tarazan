import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/resources/font_manager.dart';
import 'package:sodany/app/resources/styles_manager.dart';
import 'color_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // main color

    // primarySwatch: MaterialColor(),
    primaryColor: ColorManager.primaryColor,
    primarySwatch: Colors.grey,
    //text theme

    textTheme: TextTheme(
      displayMedium: getMediumStyle(
        fontSize: FontSizeManager.s18.sp,
        color: ColorManager.primaryColor,
      ),
      displayLarge: getBoldStyle(
        fontSize: FontSizeManager.s24.sp,
        color: ColorManager.darkBlue,
      ),
      displaySmall: getRegularStyle(
        fontSize: FontSizeManager.s12.sp,
        color: ColorManager.darkBlue,
      ),
      headlineLarge: getBoldStyle(
        fontSize: FontSizeManager.s16.sp,
        color: ColorManager.primaryColor,
      ),
      headlineSmall: getRegularStyle(
        fontSize: FontSizeManager.s16.sp,
        color: ColorManager.white,
      ),
      bodySmall: getRegularStyle(
        fontSize: FontSizeManager.s14.sp,
        color: ColorManager.darkBlue,
      ),
      bodyMedium: getMediumStyle(
        fontSize: FontSizeManager.s14.sp,
        color: ColorManager.darkBlue,
      ),
    ),
  );
}
