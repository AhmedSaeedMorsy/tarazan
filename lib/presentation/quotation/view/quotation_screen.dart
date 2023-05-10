import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';
import 'package:sodany/presentation/quotation/controller/states.dart';

import '../../../app/constant/api_constant.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/quotation_model.dart';
import '../controller/bloc.dart';

class QuotationScreen extends StatelessWidget {
  const QuotationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuotationBloc()
        ..getQuotation(id: CacheHelper.getData(key: SharedKey.id)),
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
            AppStrings.quotation.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          elevation: AppSize.s0,
        ),
        body: BlocConsumer<QuotationBloc, QuotationStates>(
          listener: (context, state) {
            if (state is AllowQuotationSuccessState) {
              Navigator.pushNamed(context, Routes.paymentMethodRoute);
            } else if (state is DenyQuotationSuccessState) {
              Navigator.pushReplacementNamed(
                context,
                Routes.homeRoute,
              );
            }
          },
          builder: (context, state) {
            return ConditionalBuilderRec(
              condition:
                  QuotationBloc.get(context).quotationModel.data.isNotEmpty,
              builder: (context) => ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / AppSize.s30,
                  vertical: MediaQuery.of(context).size.height / AppSize.s40,
                ),
                itemBuilder: (context, index) {
                  return quotationWidget(
                      context: context,
                      allowFunction: () {
                        QuotationBloc.get(context).allowQuotation(
                            id: QuotationBloc.get(context)
                                .quotationModel
                                .data[index]
                                .id!);
                      },
                      denyFunction: () {
                        QuotationBloc.get(context).denyQuotation(
                            id: QuotationBloc.get(context)
                                .quotationModel
                                .data[index]
                                .id!);
                      },
                      model: QuotationBloc.get(context)
                          .quotationModel
                          .data[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  );
                },
                itemCount:
                    QuotationBloc.get(context).quotationModel.data.length,
              ),
              fallback: (context) => Center(
                child: Text(
                  AppStrings.notFoundItem.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget quotationWidget({
    required BuildContext context,
    required QuotationDataModel model,
    required Function() denyFunction,
    required Function() allowFunction,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / AppSize.s50,
        vertical: MediaQuery.of(context).size.height / AppSize.s80,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(
          AppSize.s10.w,
        ),
        boxShadow: const [
          BoxShadow(
            color: ColorManager.grey,
            blurRadius: AppSize.s5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s80,
                vertical: MediaQuery.of(context).size.height / AppSize.s100,
              ),
              child: Image(
                image: NetworkImage(
                  "${ApiConstant.baseUrl}storage/custom_shippings/${model.image}",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / AppSize.s50,
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${AppStrings.price.tr()}: ${model.cost}",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: denyFunction,
              child: Text(
                AppStrings.deny.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: allowFunction,
              child: Text(
                AppStrings.allow.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
