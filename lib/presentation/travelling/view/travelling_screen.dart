// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodany/app/common/widget.dart';
import 'package:sodany/app/constant/enums_extentions.dart';
import 'package:sodany/app/resources/color_manager.dart';
import 'package:sodany/app/resources/strings_manager.dart';
import 'package:sodany/app/resources/values_manager.dart';
import 'package:sodany/presentation/travelling/controller/bloc.dart';
import 'package:sodany/presentation/travelling/controller/states.dart';
import '../../home/controller/bloc.dart';
import '../../home/controller/states.dart';
import '../../select_trip_travelling/view/select_trip_travelling_screen.dart';

class TravellingScreen extends StatelessWidget {
  const TravellingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => TravellingBloc(),
        )
      ],
      child: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.ticket.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
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
              backgroundColor: ColorManager.darkBlue,
              centerTitle: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: ColorManager.darkBlue,
                statusBarIconBrightness: Brightness.light,
              ),
              elevation: AppSize.s0,
            ),
            body: SingleChildScrollView(
              child: BlocBuilder<TravellingBloc, TravellingStates>(
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
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s30,
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              AppSize.s80,
                                        ),
                                        color: ColorManager.white,
                                        child: Text(
                                          AppStrings.from.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                color:
                                                    ColorManager.primaryColor,
                                              ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s100,
                                      ),
                                      Text(
                                        HomeBloc.get(context).isChange
                                            ? AppStrings.egypt.tr()
                                            : AppStrings.sudan.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              color: ColorManager.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.change_circle_outlined,
                                      color: ColorManager.white,
                                    ),
                                    onPressed: () {
                                      HomeBloc.get(context).changeFromTo();
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: ColorManager.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s30,
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              AppSize.s80,
                                        ),
                                        child: Text(
                                          AppStrings.to.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  color: ColorManager
                                                      .primaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s100,
                                      ),
                                      Text(
                                        HomeBloc.get(context).isChange
                                            ? AppStrings.sudan.tr()
                                            : AppStrings.egypt.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              color: ColorManager.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppStrings.bus.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: ColorManager.primaryColor,
                                            ),
                                      ),
                                    ),
                                    Radio(
                                      value: TravellingEnum.bus,
                                      groupValue: TravellingBloc.get(context)
                                          .travellingRadioButtonValue,
                                      onChanged: (value) {
                                        TravellingBloc.get(context)
                                            .changeRadioButton(value!);
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppStrings.airplane.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: ColorManager.primaryColor,
                                            ),
                                      ),
                                    ),
                                    Radio(
                                      value: TravellingEnum.airplane,
                                      groupValue: TravellingBloc.get(context)
                                          .travellingRadioButtonValue,
                                      onChanged: (value) {
                                        TravellingBloc.get(context)
                                            .changeRadioButton(value!);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30,
                        ),
                        child: SharedWidget.defaultButton(
                          context: context,
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SelectTripTravellingScreen(
                                  vehicle: TravellingBloc.get(context)
                                              .travellingRadioButtonValue ==
                                          TravellingEnum.bus
                                      ? AppStrings.bus.tr()
                                      : AppStrings.airplane.tr(),
                                  from: HomeBloc.get(context).isChange
                                      ? AppStrings.egypt.tr()
                                      : AppStrings.sudan.tr(),
                                  to: HomeBloc.get(context).isChange
                                      ? AppStrings.sudan.tr()
                                      : AppStrings.egypt.tr(),
                                  typeId: TravellingBloc.get(context)
                                              .travellingRadioButtonValue ==
                                          TravellingEnum.bus
                                      ? "1"
                                      : "2",
                                  fromLocation: HomeBloc.get(context).isChange
                                      ? "cairo"
                                      : "sudan",
                                  toLocation: HomeBloc.get(context).isChange
                                      ? "sudan"
                                      : "cairo",
                                ),
                              ),
                            );
                          },
                          text: AppStrings.next.tr(),
                          backgroundColor: ColorManager.white,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: ColorManager.darkBlue,
                              ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
