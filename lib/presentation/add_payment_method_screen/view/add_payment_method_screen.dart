// ignore_for_file: must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sodany/app/resources/color_manager.dart';
import '../../../../app/resources/routes_manager.dart';
import '../../../../app/resources/strings_manager.dart';
import '../../../../app/resources/values_manager.dart';
import '../../../app/common/widget.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({super.key});

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
              SharedWidget.defaultTextFormField(
                controller: TextEditingController(),
                textInputType: TextInputType.name,
                context: context,
                hint: AppStrings.nameOnCard.tr(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s50,
              ),
              SharedWidget.defaultTextFormField(
                controller: TextEditingController(),
                textInputType: TextInputType.name,
                context: context,
                hint: AppStrings.cardNumber.tr(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s50,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SharedWidget.defaultTextFormField(
                      controller: TextEditingController(),
                      textInputType: TextInputType.none,
                      context: context,
                      hint: AppStrings.expiryDate.tr(),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(
                              days: 1000,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / AppSize.s50,
                  ),
                  Expanded(
                    flex: 1,
                    child: SharedWidget.defaultTextFormField(
                      controller: TextEditingController(),
                      textInputType: TextInputType.name,
                      context: context,
                      hint: AppStrings.cvv,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SharedWidget.defaultButton(
                text: AppStrings.accept.tr(),
                context: context,
                function: () {
                  Navigator.pushNamed(
                    context,
                    Routes.otpVerificationRoute,
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
