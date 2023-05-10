// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/common/widget.dart';
import 'package:sodany/app/resources/assets_manager.dart';
import 'package:sodany/app/resources/strings_manager.dart';
import 'package:sodany/presentation/login/controller/bloc.dart';
import 'package:sodany/presentation/login/controller/states.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s10,
            vertical: MediaQuery.of(context).size.height / AppSize.s8,
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s20,
                vertical: MediaQuery.of(context).size.height / AppSize.s30,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10.w),
                  color: Colors.white),
              width: double.infinity,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      SharedWidget.changeLanguage(context);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        color: ColorManager.darkBlue,
                        child: Padding(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / AppSize.s80,
                          ),
                          child: Text(
                            AppStrings.en.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: ColorManager.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s80,
                  ),
                  const Image(
                    image: AssetImage(
                      AssetsManager.logo,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                  Text(
                    AppStrings.login.tr(),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: formKey,
                      child: BlocProvider(
                        create: (context) => LoginBloc(),
                        child: BlocConsumer<LoginBloc, LoginUserStates>(
                          listener: (context, state) {
                            if (state is LoginUserErrorState) {
                              SharedWidget.toast(
                                backgroundColor: ColorManager.error,
                                message:
                                    AppStrings.anErrorOccurredTryAgain.tr(),
                              );
                            } else if (state is LoginUserSuccessState) {
                              CacheHelper.setData(
                                key: SharedKey.token,
                                value: LoginBloc.get(context).userModel.token,
                              );
                              CacheHelper.setData(
                                  key: SharedKey.id,
                                  value:
                                      LoginBloc.get(context).userModel.user.id);

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
                                Text(AppStrings.userName.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s80,
                                ),
                                SharedWidget.defaultTextFormField(
                                  textInputType: TextInputType.emailAddress,
                                  context: context,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    }
                                    if (value.contains("@") == false) {
                                      return AppStrings.emailNotationValidation
                                          .tr();
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s30,
                                ),
                                Text(AppStrings.password.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s80,
                                ),
                                SharedWidget.defaultTextFormField(
                                  textInputType: TextInputType.visiblePassword,
                                  context: context,
                                  controller: passwordController,
                                  obscure:
                                      LoginBloc.get(context).isShownPassword,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      LoginBloc.get(context)
                                          .changeVisibilityPassword();
                                    },
                                    icon: LoginBloc.get(context).suffixPassword,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.thisIsRequired.tr();
                                    } else if (value.length < 8) {
                                      return AppStrings
                                          .itMustBeAtLeast8Characters
                                          .tr();
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s80,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: Text(
                                    AppStrings.forgetPassword.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s30,
                                ),
                                state is! LoginUserLoadingState
                                    ? SharedWidget.defaultButton(
                                        context: context,
                                        function: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            LoginBloc.get(context).loginrUser(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                          }
                                        },
                                        text: AppStrings.login.tr(),
                                        backgroundColor: ColorManager.white,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              color: ColorManager.darkBlue,
                                            ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: ColorManager.primaryColor,
                                        ),
                                      ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s80,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.registerRoute,
                                      );
                                    },
                                    child: Text(
                                      AppStrings.createAccount.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s30,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
