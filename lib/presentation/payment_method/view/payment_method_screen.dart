// ignore_for_file: must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/resources/color_manager.dart';
import 'dart:ui' as UI;
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/routes_manager.dart';
import '../../../../app/resources/strings_manager.dart';
import '../../../../app/resources/values_manager.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.darkBlue,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.darkBlue,
          statusBarIconBrightness: Brightness.light,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorManager.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          AppStrings.paymentMethod.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: AppSize.s0,
        
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s30,
            vertical: MediaQuery.of(context).size.height / AppSize.s80,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / AppSize.s50,
                  vertical: MediaQuery.of(context).size.height / AppSize.s80,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppSize.s10.w,
                  ),
                  color: ColorManager.white,
                  boxShadow: const [
                    BoxShadow(
                      color: ColorManager.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage(
                        AssetsManager.fawry,
                      ),
                      width: AppSize.s100.w,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Image(
                image: AssetImage(
                  AssetsManager.creditCard,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s30,
              ),
              Text(AppStrings.noCardsSaved.tr(),
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s80,
              ),
              Text(
                AppStrings.addCardDescription.tr(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: FontSizeManager.s14.sp,
                    ),
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s20,
              ),
              SharedWidget.defaultButton(
                text: AppStrings.addCard.tr(),
                context: context,
                style: Theme.of(context).textTheme.headlineSmall!,
                backgroundColor: ColorManager.darkBlue,
                function: () {
                  Navigator.pushNamed(
                    context,
                    Routes.addPaymentMethodRoute,
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
