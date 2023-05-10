// ignore_for_file: must_be_immutable, library_prefixes

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/common/widget.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/constant/enums_extentions.dart';
import 'package:sodany/app/resources/assets_manager.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/language_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;

import '../controller/bloc.dart';
import '../controller/states.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;
  final advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc()..getUserData(),
        child: BlocBuilder<HomeBloc, HomeStates>(
          builder: (context, state) {
            return AdvancedDrawer(
              backdropColor: ColorManager.primaryColor,
              controller: advancedDrawerController,
              animationCurve: Curves.linearToEaseOut,
              animationDuration: const Duration(
                milliseconds: AppIntDuration.duration500,
              ),
              animateChildDecoration: true,
              rtlOpening: false,
              disabledGestures: false,
              childDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppSize.s10.w,
                  ),
                ),
              ),
              drawer: Directionality(
                textDirection: direction,
                child: SafeArea(
                  child: state is UserLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : ListTileTheme(
                          textColor: ColorManager.darkBlue,
                          iconColor: ColorManager.darkBlue,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s20,
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width /
                                    AppSize.s6,
                                backgroundImage: NetworkImage(
                                    "${ApiConstant.baseUrl}storage/${HomeBloc.get(context).userData.image}"),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s40,
                              ),
                              Text(
                                HomeBloc.get(context)
                                    .userData
                                    .name
                                    .toString()
                                    .toCapitalized(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      color: ColorManager.darkBlue,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s16,
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.homeRoute,
                                  );
                                },
                                leading: const Icon(
                                  Icons.home,
                                ),
                                title: Text(
                                  AppStrings.home.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: ColorManager.darkBlue,
                                      ),
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.profileRoute,
                                  );
                                },
                                leading:
                                    const Icon(Icons.account_circle_rounded),
                                title: Text(
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: ColorManager.darkBlue,
                                      ),
                                  AppStrings.profile.tr(),
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  CacheHelper.removeData(key: SharedKey.token);
                                  CacheHelper.removeData(
                                    key: SharedKey.id,
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.loginRoute,
                                  );
                                },
                                leading: const Icon(Icons.logout_outlined),
                                title: Text(
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: ColorManager.darkBlue,
                                      ),
                                  AppStrings.logOut.tr(),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    AppStrings.home.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  centerTitle: true,
                  backgroundColor: ColorManager.darkBlue,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: ColorManager.darkBlue,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  elevation: AppSize.s0,
                  leading: CacheHelper.getData(key: SharedKey.Language) ==
                          LanguageType.ENGLISH.getValue()
                      ? IconButton(
                          onPressed: handleMenuButtonPressed,
                          icon: ValueListenableBuilder<AdvancedDrawerValue>(
                            valueListenable: advancedDrawerController,
                            builder: (_, value, __) {
                              return AnimatedSwitcher(
                                duration: const Duration(
                                  milliseconds: AppIntDuration.duration300,
                                ),
                                child: Icon(
                                  value.visible ? Icons.clear : Icons.menu,
                                  color: ColorManager.white,
                                  key: ValueKey<bool>(value.visible),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  actions: [
                    CacheHelper.getData(key: SharedKey.Language) ==
                            LanguageType.ENGLISH.getValue()
                        ? Container()
                        : IconButton(
                            onPressed: handleMenuButtonPressed,
                            icon: ValueListenableBuilder<AdvancedDrawerValue>(
                              valueListenable: advancedDrawerController,
                              builder: (_, value, __) {
                                return AnimatedSwitcher(
                                  duration: const Duration(
                                    milliseconds: AppIntDuration.duration300,
                                  ),
                                  child: Icon(
                                    value.visible ? Icons.clear : Icons.menu,
                                    color: ColorManager.white,
                                    key: ValueKey<bool>(value.visible),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s30,
                        vertical:
                            MediaQuery.of(context).size.height / AppSize.s50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.travellingRoute,
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: AppSize.s30.w,
                                      backgroundColor:
                                          ColorManager.primaryColor,
                                      child: Image(
                                        image: const AssetImage(
                                          AssetsManager.bus,
                                        ),
                                        color: ColorManager.white,
                                        width: AppSize.s40.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      AppStrings.ticket.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.shippingRoute,
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: AppSize.s30.w,
                                      backgroundColor:
                                          ColorManager.primaryColor,
                                      child: Image(
                                        image: const AssetImage(
                                          AssetsManager.shipping,
                                        ),
                                        color: ColorManager.white,
                                        width: AppSize.s40.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    Text(
                                      AppStrings.shipping.tr(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s50),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.profileRoute,
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: AppSize.s30.w,
                                      backgroundColor:
                                          ColorManager.primaryColor,
                                      child: Image(
                                        image: const AssetImage(
                                          AssetsManager.profile,
                                        ),
                                        color: ColorManager.white,
                                        width: AppSize.s40.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      AppStrings.profile.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.quotationRoute,
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: AppSize.s30.w,
                                      backgroundColor:
                                          ColorManager.primaryColor,
                                      child: Image(
                                        image: const AssetImage(
                                          AssetsManager.quotation,
                                        ),
                                        color: ColorManager.white,
                                        width: AppSize.s40.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      AppStrings.quotation.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s50),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.historyRoute,
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: AppSize.s30.w,
                                      backgroundColor:
                                          ColorManager.primaryColor,
                                      child: Image(
                                        image: const AssetImage(
                                          AssetsManager.history,
                                        ),
                                        color: ColorManager.white,
                                        width: AppSize.s40.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      AppStrings.history.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  SharedWidget.changeLanguage(context);
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: AppSize.s30.w,
                                      backgroundColor:
                                          ColorManager.primaryColor,
                                      child: Image(
                                        image: const AssetImage(
                                          AssetsManager.language,
                                        ),
                                        color: ColorManager.white,
                                        width: AppSize.s40.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s80,
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      AppStrings.language.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }
}
