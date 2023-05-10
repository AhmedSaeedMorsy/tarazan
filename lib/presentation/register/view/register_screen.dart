// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';
import 'package:sodany/presentation/register/controller/bloc.dart';
import 'package:sodany/presentation/register/controller/states.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s10,
            vertical: MediaQuery.of(context).size.height / AppSize.s10,
          ),
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / AppSize.s20,
                    vertical: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppSize.s10.w,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage(
                          AssetsManager.logo,
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s30,
                      ),
                      Text(
                        AppStrings.createAccount.tr(),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Form(
                          key: formKey,
                          child: BlocProvider(
                              create: (context) => RegisterBloc(),
                              child: BlocConsumer<RegisterBloc,
                                  RegisterUserStates>(
                                listener: (context, state) {
                                  if (state is RegisterUserErrorState) {
                                    SharedWidget.toast(
                                      backgroundColor: ColorManager.error,
                                      message: AppStrings
                                          .anErrorOccurredTryAgain
                                          .tr(),
                                    );
                                  } else if (state
                                      is RegisterUserSuccessState) {
                                    CacheHelper.setData(
                                      key: SharedKey.token,
                                      value: RegisterBloc.get(context)
                                          .userModel
                                          .token,
                                    );

                                    CacheHelper.setData(
                                        key: SharedKey.id,
                                        value: RegisterBloc.get(context)
                                            .userModel
                                            .user
                                            .id);

                                    Navigator.pushNamed(
                                      context,
                                      Routes.homeRoute,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.bottomStart,
                                          children: [
                                            CircleAvatar(
                                              radius: AppSize.s50.w,
                                              backgroundColor:
                                                  ColorManager.darkBlue,
                                              backgroundImage:
                                                  RegisterBloc.get(context)
                                                      .profileCoverImage(),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                RegisterBloc.get(context)
                                                    .getProfileImage();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    ColorManager.white,
                                                radius: AppSize.s16.w,
                                                child: const Icon(
                                                  Icons.edit_outlined,
                                                  color:
                                                      ColorManager.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s80,
                                      ),
                                      Text(AppStrings.name.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s80,
                                      ),
                                      SharedWidget.defaultTextFormField(
                                        textInputType: TextInputType.name,
                                        context: context,
                                        controller: nameController,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.thisIsRequired
                                                .tr();
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s30,
                                      ),
                                      Text(
                                        AppStrings.email.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s80,
                                      ),
                                      SharedWidget.defaultTextFormField(
                                          textInputType:
                                              TextInputType.emailAddress,
                                          context: context,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return AppStrings.thisIsRequired
                                                  .tr();
                                            }
                                            if (value.contains("@") == false) {
                                              return AppStrings
                                                  .emailNotationValidation
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          controller: emailController),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s30,
                                      ),
                                      Text(
                                        AppStrings.phoneNumber.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s80,
                                      ),
                                      SharedWidget.defaultTextFormField(
                                        textInputType: TextInputType.phone,
                                        context: context,
                                        controller: phoneNumberController,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.thisIsRequired
                                                .tr();
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s30,
                                      ),
                                      Text(
                                        AppStrings.password.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s80,
                                      ),
                                      SharedWidget.defaultTextFormField(
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        context: context,
                                        controller: passwordController,
                                        obscure: RegisterBloc.get(context)
                                            .isShownPassword,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            RegisterBloc.get(context)
                                                .changeVisibilityPassword();
                                          },
                                          icon: RegisterBloc.get(context)
                                              .suffixPassword,
                                        ),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.thisIsRequired
                                                .tr();
                                          } else if (confirmPasswordController
                                                  .text !=
                                              passwordController.text) {
                                            return AppStrings
                                                .confirmPasswordNotEqualPasswordValidation
                                                .tr();
                                          } else if (value.length < 8) {
                                            return AppStrings
                                                .itMustBeAtLeast8Characters
                                                .tr();
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s30,
                                      ),
                                      Text(AppStrings.confirmPassword.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s80,
                                      ),
                                      SharedWidget.defaultTextFormField(
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        context: context,
                                        controller: confirmPasswordController,
                                        obscure: RegisterBloc.get(context)
                                            .isShownConfirmPassword,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            RegisterBloc.get(context)
                                                .changeVisibilityConfirmPassword();
                                          },
                                          icon: RegisterBloc.get(context)
                                              .suffixConfirmPassword,
                                        ),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.thisIsRequired
                                                .tr();
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s20,
                                      ),
                                      state is! RegisterUserLoadingState
                                          ? SharedWidget.defaultButton(
                                              context: context,
                                              function: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  RegisterBloc.get(context)
                                                      .registerUser(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    passwordConfirmation:
                                                        confirmPasswordController
                                                            .text,
                                                    password:
                                                        passwordController.text,
                                                    phone: phoneNumberController
                                                        .text,
                                                    profileImageFile:
                                                        RegisterBloc.get(
                                                      context,
                                                    ).profileImage!,
                                                  );
                                                }
                                              },
                                              text:
                                                  AppStrings.createAccount.tr(),
                                              backgroundColor:
                                                  ColorManager.white,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                    color:
                                                        ColorManager.darkBlue,
                                                  ),
                                            )
                                          : const Center(
                                              child: CircularProgressIndicator(
                                                color:
                                                    ColorManager.primaryColor,
                                              ),
                                            ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s80,
                                      ),
                                    ],
                                  );
                                },
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
