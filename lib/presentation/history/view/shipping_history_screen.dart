import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/presentation/history/controller/bloc.dart';
import 'package:sodany/presentation/history/controller/states.dart';

import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/history_shipping_model.dart';

class ShippingHistoryScreen extends StatelessWidget {
  const ShippingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryStates>(builder: (context, state) {
      return ConditionalBuilderRec(
        condition:
            HistoryBloc.get(context).historyShippingModel.data.isNotEmpty,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height / AppSize.s50,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) => tripItem(
                  context: context,
                  model: HistoryBloc.get(context)
                      .historyShippingModel
                      .data[index]),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s50,
                );
              },
              itemCount:
                  HistoryBloc.get(context).historyShippingModel.data.length,
            ),
          );
        },
        fallback: (context) => Center(
          child: Text(
            AppStrings.notFoundItem.tr(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      );
    });
  }

  Widget tripItem({
    required BuildContext context,
    required HistoryShippingDataModel model,
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
              model.shippingId.toString(),
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
                Expanded(
                  child: Text(
                    DateFormat("dd-MM").format(DateTime.parse(model.createdAt)),
                    style: Theme.of(context).textTheme.headlineLarge,
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
          ],
        ),
      ),
    );
  }

  // Future tripDetailsDialog({
  //   required BuildContext context,
  // }) =>
  //     showDialog(
  //       context: context,
  //       builder: (context) => Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(
  //             MediaQuery.of(context).size.height / AppSize.s50,
  //           ),
  //           color: ColorManager.white,
  //         ),
  //         margin: EdgeInsets.symmetric(
  //           vertical: MediaQuery.of(context).size.height / AppSize.s3,
  //           horizontal: MediaQuery.of(context).size.height / AppSize.s50,
  //         ),
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(
  //             vertical: MediaQuery.of(context).size.height / AppSize.s30,
  //             horizontal: MediaQuery.of(context).size.width / AppSize.s30,
  //           ),
  //           child: SingleChildScrollView(
  //             physics: const BouncingScrollPhysics(),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   AppStrings.tripData.tr(),
  //                   style: Theme.of(context).textTheme.headlineLarge,
  //                 ),
  //                 SizedBox(
  //                   height: MediaQuery.of(context).size.height / AppSize.s30,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             color: ColorManager.white,
  //                             child: Text(
  //                               AppStrings.from.tr(),
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .displayMedium!
  //                                   .copyWith(
  //                                       color: ColorManager.greyWithOpacity),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width /
  //                                 AppSize.s50,
  //                           ),
  //                           Text(
  //                             AppStrings.sudan.tr(),
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .headlineSmall!
  //                                 .copyWith(color: ColorManager.primaryColor),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: MediaQuery.of(context).size.width / AppSize.s20,
  //                     ),
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             color: ColorManager.white,
  //                             child: Text(
  //                               AppStrings.to.tr(),
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .displayMedium!
  //                                   .copyWith(
  //                                       color: ColorManager.greyWithOpacity),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width /
  //                                 AppSize.s50,
  //                           ),
  //                           Text(
  //                             AppStrings.egypt.tr(),
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .headlineSmall!
  //                                 .copyWith(
  //                                   color: ColorManager.primaryColor,
  //                                 ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: MediaQuery.of(context).size.height / AppSize.s80,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             color: ColorManager.white,
  //                             child: Text(
  //                               AppStrings.date.tr(),
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .displayMedium!
  //                                   .copyWith(
  //                                       color: ColorManager.greyWithOpacity),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width /
  //                                 AppSize.s80,
  //                           ),
  //                           Text(
  //                             "15-2-2023",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .headlineSmall!
  //                                 .copyWith(color: ColorManager.primaryColor),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: MediaQuery.of(context).size.width / AppSize.s20,
  //                     ),
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             color: ColorManager.white,
  //                             child: Text(
  //                               AppStrings.time.tr(),
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .displayMedium!
  //                                   .copyWith(
  //                                       color: ColorManager.greyWithOpacity),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width /
  //                                 AppSize.s50,
  //                           ),
  //                           Text(
  //                             "05:15:00",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .headlineSmall!
  //                                 .copyWith(
  //                                   color: ColorManager.primaryColor,
  //                                 ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: MediaQuery.of(context).size.height / AppSize.s80,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             color: ColorManager.white,
  //                             child: Text(
  //                               AppStrings.price.tr(),
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .displayMedium!
  //                                   .copyWith(
  //                                       color: ColorManager.greyWithOpacity),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width /
  //                                 AppSize.s80,
  //                           ),
  //                           Text(
  //                             "150 EGP",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .headlineSmall!
  //                                 .copyWith(color: ColorManager.primaryColor),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: MediaQuery.of(context).size.width / AppSize.s20,
  //                     ),
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             color: ColorManager.white,
  //                             child: Text(
  //                               AppStrings.type.tr(),
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .displayMedium!
  //                                   .copyWith(
  //                                       color: ColorManager.greyWithOpacity),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: MediaQuery.of(context).size.width /
  //                                 AppSize.s50,
  //                           ),
  //                           Expanded(
  //                             child: Text(
  //                               AppStrings.regularShipping.tr(),
  //                               style: Theme.of(context)
  //                                   .textTheme
  //                                   .headlineSmall!
  //                                   .copyWith(
  //                                     color: ColorManager.primaryColor,
  //                                   ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     Container(
  //                       color: ColorManager.white,
  //                       child: Text(
  //                         AppStrings.category.tr(),
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .displayMedium!
  //                             .copyWith(color: ColorManager.greyWithOpacity),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: MediaQuery.of(context).size.width / AppSize.s50,
  //                     ),
  //                     Expanded(
  //                       child: Text(
  //                         "Category Name",
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .headlineSmall!
  //                             .copyWith(
  //                               color: ColorManager.primaryColor,
  //                             ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: MediaQuery.of(context).size.height / AppSize.s10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
}
