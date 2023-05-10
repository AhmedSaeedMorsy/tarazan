import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/language_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class SharedWidget {
  static Widget defaultTextFormField({
    final TextEditingController? controller,
    required TextInputType textInputType,
    bool obscure = false,
    void Function(String?)? onChange,
    required BuildContext context,
    void Function()? onTap,
    String? hint,
    bool? enabled,
    String? Function(String?)? validator,
    IconButton? suffixIcon,
    void Function(String)? onFieldSubmitted,
    int maxLines = 1,
    int minLines = 1,
  }) =>
      TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodySmall,
        cursorColor: ColorManager.primaryColor,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: ColorManager.white,
          filled: true,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10.h),
            borderSide: const BorderSide(
              color: ColorManager.darkBlue,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10.h),
            borderSide: const BorderSide(
              color: ColorManager.darkBlue,
            ),
          ),
          contentPadding: EdgeInsetsDirectional.only(
            top: AppPadding.p12.h,
            start: AppPadding.p16.w,
          ),
          // hint style
          hintStyle: Theme.of(context).textTheme.displayMedium,
        ),
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChange,
        onTap: onTap,
        enabled: enabled,
        minLines: minLines,
        validator: validator,
        keyboardType: textInputType,
        maxLines: maxLines,
      );

  static Widget defaultButton({
    required BuildContext context,
    required Function() function,
    required String text,
    required Color backgroundColor,
    required TextStyle style,
  }) {
    return Container(
      height: AppSize.s42.h,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.darkBlue,
        ),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AppSize.s50.h,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  static toast({required String message, required Color backgroundColor}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: ColorManager.white,
      fontSize: FontSizeManager.s14.sp,
    );
  }

  static void changeLanguage(context) {
    changeAppLanguage();
    Phoenix.rebirth(context);
  }

  static Future tripTicketDetailsDialog({
    required BuildContext context,
    required String price,
    required String fromLocation,
    required String toLocation,
    required String date,
    required String time,
  }) =>
      showDialog(
        context: context,
        builder: (context) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.height / AppSize.s50,
            ),
            color: ColorManager.white,
          ),
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / AppSize.s4,
            horizontal: MediaQuery.of(context).size.height / AppSize.s50,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / AppSize.s30,
              horizontal: MediaQuery.of(context).size.width / AppSize.s50,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    AppStrings.tripData.tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              color: ColorManager.white,
                              child: Text(
                                AppStrings.from.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: ColorManager.greyWithOpacity),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s50,
                            ),
                            Text(
                              fromLocation,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: ColorManager.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s20,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              color: ColorManager.white,
                              child: Text(
                                AppStrings.to.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: ColorManager.greyWithOpacity),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s50,
                            ),
                            Text(
                              toLocation,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: ColorManager.primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s80,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              color: ColorManager.white,
                              child: Text(
                                AppStrings.date.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: ColorManager.greyWithOpacity),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s80,
                            ),
                            Text(
                              date,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: ColorManager.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s20,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              color: ColorManager.white,
                              child: Text(
                                AppStrings.time.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: ColorManager.greyWithOpacity),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s50,
                            ),
                            Text(
                              time,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: ColorManager.primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s80,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              color: ColorManager.white,
                              child: Text(
                                AppStrings.price.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: ColorManager.greyWithOpacity),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s80,
                            ),
                            Text(
                              price,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: ColorManager.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.paymentMethodRoute,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / AppSize.s2,
                      padding: EdgeInsets.symmetric(
                        vertical:
                            MediaQuery.of(context).size.height / AppSize.s80,
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s6,
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.s80.w,
                        ),
                        color: ColorManager.darkBlue,
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.pay.tr(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
