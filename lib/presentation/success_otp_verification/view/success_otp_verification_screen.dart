// ignore_for_file: must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as UI;
import '../../../../app/common/widget.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../app/resources/routes_manager.dart';
import '../../../../app/resources/strings_manager.dart';
import '../../../../app/resources/values_manager.dart';
import '../../../app/resources/assets_manager.dart';

class SuccessOtpVerificationScreen extends StatelessWidget {
  SuccessOtpVerificationScreen({super.key});
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
            children: [
              const Spacer(),
              const Image(
                image: AssetImage(
                  AssetsManager.successOTP,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s150,
              ),
              Text(
                AppStrings.successDescriptionOTP.tr(),
                style: Theme.of(context).textTheme.displaySmall,textAlign: TextAlign.center,
              ),
              const Spacer(),
              SharedWidget.defaultButton(
                text: AppStrings.accept.tr(),
                context: context,
                function: () {
                  Navigator.pushNamed(
                    context,
                    Routes.homeRoute,
                  );
                },
                style: Theme.of(context).textTheme.headlineSmall!,
                backgroundColor: ColorManager.darkBlue,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
