// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/presentation/history/controller/bloc.dart';
import 'package:sodany/presentation/history/view/shipping_history_screen.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../app/resources/values_manager.dart';
import '../../../app/resources/strings_manager.dart';
import 'travelling_history_screen.dart';

class HistoryLayout extends StatefulWidget {
  const HistoryLayout({super.key});

  @override
  _HistoryLayoutState createState() => _HistoryLayoutState();
}

class _HistoryLayoutState extends State<HistoryLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc()
        ..getShippingHistory()
        ..getTicketHistory(),
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
            AppStrings.history.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          elevation: AppSize.s0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s50,
            ),
            TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppSize.s80.w,
                ),
                border: Border.all(
                  color: ColorManager.primaryColor,
                ),
              ),
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              unselectedLabelColor: ColorManager.darkBlue,
              labelColor: ColorManager.primaryColor,
              labelStyle: Theme.of(context).textTheme.headlineLarge,
              tabs: [
                Tab(
                  text: AppStrings.shipping.tr(),
                ),
                Tab(
                  text: AppStrings.ticket.tr(),
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s50,
            ),
            Expanded(
              child: SizedBox(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _tabController,
                  children: const [
                    ShippingHistoryScreen(),
                    TravellingHistoryScreen(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
