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
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/shipping_model.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class SelectTripShippingScreen extends StatelessWidget {
  const SelectTripShippingScreen({
    super.key,
    required this.from,
    required this.fromLocation,
    required this.shippingType,
    required this.to,
    required this.toLocation,
    required this.typeId,
    required this.cost,
    required this.categoryId,
    required this.productName,
  });
  final String shippingType;
  final String from;
  final String to;
  final String typeId;
  final String fromLocation;
  final String toLocation;
  final String cost;
  final String productName;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectShippingTicketsBloc()
        ..shippingTicket(
          fromLocation: fromLocation,
          toLocation: toLocation,
          typeId: typeId,
        ),
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
              AppStrings.availableTrips.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            elevation: AppSize.s0,
          ),
          body:
              BlocConsumer<SelectShippingTicketsBloc, SelectTripShippingStates>(
            listener: (context, state) {
              if (state is BookTicketSuccessState) {
                Navigator.pushNamed(context, Routes.paymentMethodRoute);
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
                                AppStrings.priceCategory.tr(),
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
                            Text(
                              cost,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: ColorManager.primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: ColorManager.white,
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s80,
                        ),
                        child: Text(
                          AppStrings.amount.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: ColorManager.greyWithOpacity),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SelectShippingTicketsBloc.get(context)
                              .incrementAmount();
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorManager.primaryColor,
                          child: Text(
                            "+",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ),
                      Text(
                        "${SelectShippingTicketsBloc.get(context).amount}",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: ColorManager.primaryColor,
                                ),
                      ),
                      InkWell(
                        onTap: () {
                          SelectShippingTicketsBloc.get(context)
                              .decrementAmount();
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorManager.primaryColor,
                          child: Text(
                            "-",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                  Expanded(
                    child: ConditionalBuilderRec(
                      condition: SelectShippingTicketsBloc.get(context)
                          .shippingModel
                          .data
                          .isNotEmpty,
                      builder: (context) {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => tripItem(
                              state: state,
                              context: context,
                              function: () {
                                SelectShippingTicketsBloc.get(context)
                                    .bookTicket(
                                        shippingId:
                                            SelectShippingTicketsBloc.get(
                                                    context)
                                                .shippingModel
                                                .data[index]
                                                .id,
                                        userId: CacheHelper.getData(
                                            key: SharedKey.id),
                                        context: context,
                                        categoryId: categoryId.toString(),
                                        amount: SelectShippingTicketsBloc.get(
                                                context)
                                            .amount
                                            .toString(),
                                        productName: productName);
                              },
                              model: SelectShippingTicketsBloc.get(context)
                                  .shippingModel
                                  .data[index]),
                          separatorBuilder: (context, index) => SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s50,
                          ),
                          itemCount: SelectShippingTicketsBloc.get(context)
                              .shippingModel
                              .data
                              .length,
                        );
                      },
                      fallback: (context) => Center(
                        child: Text(
                          AppStrings.notFoundItem.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                ],
              );
            },
          )),
    );
  }

  Widget tripItem({
    required BuildContext context,
    required ShippingDataModel model,
    required Function() function,
    required state,
  }) {
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
            Text(
              model.id.toString(),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: ColorManager.greyWithOpacity),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / AppSize.s80),
            Row(
              children: [
                Image(
                  image: const AssetImage(
                    AssetsManager.shipping,
                  ),
                  width: AppSize.s50.w,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / AppSize.s30,
                ),
                Text(
                  model.departureTime,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
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
