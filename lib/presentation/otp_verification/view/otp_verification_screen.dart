// ignore_for_file: must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../app/common/widget.dart';
import '../../../../app/resources/routes_manager.dart';
import '../../../../app/resources/strings_manager.dart';
import '../../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;

import '../../../app/resources/color_manager.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});
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
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s30,
            vertical: MediaQuery.of(context).size.height / AppSize.s80,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / AppSize.s14,
                  right: MediaQuery.of(context).size.width / AppSize.s14,
                  top: MediaQuery.of(context).size.height / AppSize.s14,
                ),
                child: Column(
                  children: [
                    Text(AppStrings.putHereYourOTP.tr(),
                        style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s220,
                    ),
                    Text(
                      AppStrings.descriptionOTP.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: ColorManager.primaryColor,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s30,
                    ),
                    Directionality(
                      textDirection: direction,
                      child: PinCodeTextField(
                        length: 4,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        cursorColor: ColorManager.primaryColor,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          activeColor: ColorManager.grey,
                          selectedColor: ColorManager.white,
                          selectedFillColor: ColorManager.white,
                          inactiveFillColor: ColorManager.white,
                          inactiveColor: ColorManager.grey,
                          activeFillColor: ColorManager.white,
                        ),
                        animationDuration: const Duration(
                          milliseconds: AppIntDuration.duration500,
                        ),
                        enableActiveFill: true,
                        controller: TextEditingController(),
                        onCompleted: (value) {
                          // print("Completed");
                        },
                        onChanged: (value) {
                          // print(value);
                        },
                        beforeTextPaste: (text) {
                          // print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                        appContext: context,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              SharedWidget.defaultButton(
                text: AppStrings.accept.tr(),
                context: context,
                function: () {
                  Navigator.pushNamed(
                    context,
                    Routes.successOtpVerificationRoute,
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
