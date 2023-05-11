import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/presentation/shipping_other/controller/bloc.dart';
import 'package:sodany/presentation/shipping_other/controller/states.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';

class ShippingOtherScreen extends StatelessWidget {
  ShippingOtherScreen({
    super.key,
    required this.from,
    required this.shippingType,
    required this.to,
    required this.typeId,
  });
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final String shippingType;
  final String from;
  final String to;
  final String typeId;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShippingOtherBloc(),
      child: Scaffold(
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
              AppStrings.shipping.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            elevation: AppSize.s0,
          ),
          body: BlocConsumer<ShippingOtherBloc, ShippingOtherStates>(
            listener: (context, state) {
              if (state is ShippingOtherSuccessState) {
                Navigator.pushNamed(
                  context,
                  Routes.homeRoute,
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorManager.darkBlue,
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s30,
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              AppSize.s30,
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    color: ColorManager.white,
                                    child: Text(
                                      AppStrings.from.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            color: ColorManager.greyWithOpacity,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        AppSize.s30,
                                  ),
                                  Text(
                                    from,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: ColorManager.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s20,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    color: ColorManager.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              AppSize.s30,
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    child: Text(
                                      AppStrings.to.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              color:
                                                  ColorManager.greyWithOpacity),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        AppSize.s30,
                                  ),
                                  Text(
                                    to,
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
                          height:
                              MediaQuery.of(context).size.height / AppSize.s30,
                        ),
                        Row(
                          children: [
                            Container(
                              color: ColorManager.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                                vertical: MediaQuery.of(context).size.height /
                                    AppSize.s80,
                              ),
                              child: Text(
                                AppStrings.type.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: ColorManager.greyWithOpacity),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                shippingType,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: ColorManager.primaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s30,
                        vertical:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.name.tr(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s80,
                              ),
                              SharedWidget.defaultTextFormField(
                                  textInputType: TextInputType.name,
                                  context: context,
                                  controller: nameController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s30,
                              ),
                              Text(
                                AppStrings.amount.tr(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s80,
                              ),
                              SharedWidget.defaultTextFormField(
                                  textInputType: TextInputType.number,
                                  controller: amountController,
                                  context: context,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s30,
                              ),
                              InkWell(
                                onTap: () {
                                  ShippingOtherBloc.get(context)
                                      .getproductImage();
                                },
                                child: Container(
                                  height: AppSize.s150.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppSize.s10.w,
                                    ),
                                    image: DecorationImage(
                                        image: ShippingOtherBloc.get(context)
                                            .productCoverImage(),
                                        fit: BoxFit.fill),
                                    border: Border.all(
                                      color: ColorManager.darkBlue,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppStrings.addPhoto.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s30,
                              ),
                              state is ShippingOtherLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorManager.primaryColor,
                                      ),
                                    )
                                  : SharedWidget.defaultButton(
                                      context: context,
                                      function: () {
                                        if (ShippingOtherBloc.get(context)
                                                .productImage !=
                                            null) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            ShippingOtherBloc.get(context)
                                                .shippingOtherCategory(
                                              shippingId: typeId,
                                              amount: amountController.text,
                                              productName: nameController.text,
                                              profileNewImage:
                                                  ShippingOtherBloc.get(context)
                                                      .productImage!,
                                            );
                                          }
                                        } else {
                                          SharedWidget.toast(
                                            message: AppStrings.imageIsRequired.tr(),
                                            backgroundColor: ColorManager.error,
                                          );
                                        }
                                      },
                                      text: AppStrings.send.tr(),
                                      backgroundColor: ColorManager.darkBlue,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            color: ColorManager.white,
                                          ),
                                    ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
