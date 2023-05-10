import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/common/widget.dart';
import 'package:sodany/app/constant/enums_extentions.dart';
import 'package:sodany/presentation/shipping_other/view/shipping_other_screen.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/category_shipping_model.dart';
import '../../select_trip_shipping/view/select_trip_shipping.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';

class CategoryShippingScreen extends StatelessWidget {
  const CategoryShippingScreen({
    super.key,
    required this.from,
    required this.fromLocation,
    required this.shippingType,
    required this.to,
    required this.toLocation,
    required this.typeId,
  });
  final String shippingType;
  final String from;
  final String to;
  final String typeId;
  final String fromLocation;
  final String toLocation;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryShippingBloc()..getCategoris(),
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
        body: BlocBuilder<CategoryShippingBloc, CategoryShippingStates>(
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
                            width:
                                MediaQuery.of(context).size.width / AppSize.s30,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.category.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        Expanded(
                          child: ConditionalBuilderRec(
                            condition: CategoryShippingBloc.get(context)
                                .categoryShippingModel
                                .data
                                .isNotEmpty,
                            builder: (context) {
                              return GridView.builder(
                                shrinkWrap: true,
                                itemCount: CategoryShippingBloc.get(context)
                                    .categoryWithoutOther
                                    .length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return categoryItem(
                                      context: context,
                                      model: CategoryShippingBloc.get(context)
                                          .categoryWithoutOther[index]);
                                },
                                semanticChildCount: 2,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: AppSize.s20.w,
                                  crossAxisSpacing: AppSize.s20.h,
                                  childAspectRatio: 1 / 1.3,
                                ),
                              );
                            },
                            fallback: (context) => Center(
                              child: Text(
                                AppStrings.notFoundItem.tr(),
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ),
                        ),
                        SharedWidget.defaultButton(
                          context: context,
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShippingOtherScreen(
                                  from: from,
                                  shippingType: shippingType,
                                  to: to,
                                  typeId: typeId,
                                ),
                              ),
                            );
                          },
                          text: AppStrings.otherCategory.tr(),
                          backgroundColor: ColorManager.darkBlue,
                          style: Theme.of(context).textTheme.headlineLarge!,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget categoryItem({
    required BuildContext context,
    required CategoryShippingDataModel model,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectTripShippingScreen(
              from: from,
              to: to,
              categoryId: model.id,
              productName: model.name,
              typeId: typeId,
              shippingType: shippingType,
              fromLocation: fromLocation,
              toLocation: toLocation,
              cost: typeId == 1.toString()
                  ? model.basicCost ?? ""
                  : model.fastCost ?? "",
            ),
          ),
        );
      },
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image(
                image: NetworkImage(
                  "${ApiConstant.baseUrl}storage/${model.image}",
                ),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s50,
            ),
            Text(
              model.name.toCapitalized(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: FontSizeManager.s16.sp,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
