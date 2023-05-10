import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/common/widget.dart';
import 'package:sodany/app/resources/assets_manager.dart';
import 'package:sodany/app/resources/strings_manager.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/travelling_model.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class SelectTripTravellingScreen extends StatelessWidget {
  const SelectTripTravellingScreen({
    super.key,
    required this.vehicle,
    required this.from,
    required this.to,
    required this.typeId,
    required this.fromLocation,
    required this.toLocation,
  });
  final String vehicle;
  final String from;
  final String to;
  final String typeId;
  final String fromLocation;
  final String toLocation;

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
          AppStrings.availableTrips.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: AppSize.s0,
      ),
      body: BlocProvider(
        create: (context) => SelectTravellingTicketsBloc()
          ..travellingTicket(
            fromLocation: fromLocation,
            toLocation: toLocation,
            typeId: typeId,
          ),
        child: BlocConsumer<SelectTravellingTicketsBloc,
            SelectTripTravellingStates>(
          listener: (context, state) {
            if (state is BookTicketErrorState) {
              SharedWidget.toast(
                message: AppStrings.seatsMoreThanAvailable.tr(),
                backgroundColor: ColorManager.error,
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
                    horizontal: MediaQuery.of(context).size.width / AppSize.s30,
                    vertical: MediaQuery.of(context).size.height / AppSize.s20,
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
                                            color:
                                                ColorManager.greyWithOpacity),
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
                            width:
                                MediaQuery.of(context).size.width / AppSize.s20,
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
                      Container(
                        color: ColorManager.white,
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s80,
                        ),
                        child: Text(
                          vehicle,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: ColorManager.greyWithOpacity),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s30,
                ),
                Expanded(
                  child: ConditionalBuilderRec(
                    condition: SelectTravellingTicketsBloc.get(context)
                        .travellingModel
                        .data
                        .isNotEmpty,
                    builder: (context) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                color: ColorManager.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          AppSize.s30,
                                  vertical: MediaQuery.of(context).size.height /
                                      AppSize.s80,
                                ),
                                child: Text(
                                  AppStrings.selectNumberOfSeats.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: ColorManager.greyWithOpacity),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  SelectTravellingTicketsBloc.get(context)
                                      .incrementNumberOfSeats();
                                },
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.primaryColor,
                                  child: Text(
                                    "+",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              ),
                              Text(
                                "${SelectTravellingTicketsBloc.get(context).numberOfSeats}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      color: ColorManager.primaryColor,
                                    ),
                              ),
                              InkWell(
                                onTap: () {
                                  SelectTravellingTicketsBloc.get(context)
                                      .decrementNumberOfSeats();
                                },
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.primaryColor,
                                  child: Text(
                                    "-",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s30,
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => tripItem(
                                model: SelectTravellingTicketsBloc.get(context)
                                    .travellingModel
                                    .data[index],
                                context: context,
                                state: state,
                                function: () {
                                  SelectTravellingTicketsBloc.get(context)
                                      .bookTicket(
                                    context: context,
                                    travelId:
                                        SelectTravellingTicketsBloc.get(context)
                                            .travellingModel
                                            .data[index]
                                            .id,
                                    userId:
                                        CacheHelper.getData(key: SharedKey.id),
                                    seats:
                                        SelectTravellingTicketsBloc.get(context)
                                            .numberOfSeats,
                                    fromLocation: from,
                                    toLocation: to,
                                    date: DateFormat("dd-MM-yyyy").format(
                                        DateTime.parse(
                                            SelectTravellingTicketsBloc.get(
                                                    context)
                                                .travellingModel
                                                .data[index]
                                                .departureTime)),
                                    time:
                                        SelectTravellingTicketsBloc.get(context)
                                            .travellingModel
                                            .data[index]
                                            .departureTime
                                            .split(" ")
                                            .last,
                                  );
                                },
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              itemCount:
                                  SelectTravellingTicketsBloc.get(context)
                                      .travellingModel
                                      .data
                                      .length,
                            ),
                          ),
                        ],
                      );
                    },
                    fallback: (context) => Center(
                      child: Text(
                        AppStrings.notFoundItem.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s50,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget tripItem(
      {required BuildContext context,
      required TravellingDataModel model,
      required Function() function,
      required state}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / AppSize.s20,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s20,
          vertical: MediaQuery.of(context).size.height / AppSize.s50,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.s10.w,
          ),
          color: ColorManager.white,
          boxShadow: const [
            BoxShadow(color: ColorManager.grey, blurRadius: AppSize.s5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.id.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: ColorManager.greyWithOpacity),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateFormat("dd-MM")
                      .format(DateTime.parse(model.departureTime)),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / AppSize.s80),
            Row(
              children: [
                Image(
                  image: AssetImage(
                    typeId == "1" ? AssetsManager.bus : AssetsManager.airplane,
                  ),
                  width: AppSize.s50.w,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / AppSize.s30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.departureTime.split(" ").last,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        "${model.seats} ${AppStrings.seatsAvailable.tr()}",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Text(
                  model.cost,
                  style: Theme.of(context).textTheme.headlineLarge,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s50,
            ),
            state is BookTicketLoadingState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  )
                : SharedWidget.defaultButton(
                    context: context,
                    function: function,
                    text: AppStrings.buyingATicket.tr(),
                    backgroundColor: ColorManager.white,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: ColorManager.primaryColor,
                        ),
                  ),
          ],
        ),
      ),
    );
  }
}
