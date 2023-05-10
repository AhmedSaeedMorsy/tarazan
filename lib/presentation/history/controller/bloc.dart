import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/services/dio_helper/dio_helper.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';
import 'package:sodany/presentation/history/controller/states.dart';

import '../../../model/history_shipping_model.dart';
import '../../../model/history_ticket_model.dart';

class HistoryBloc extends Cubit<HistoryStates> {
  HistoryBloc() : super(HistoryInitState());
  static HistoryBloc get(context) => BlocProvider.of(context);
  HistoryShippingModel historyShippingModel = HistoryShippingModel();
  void getShippingHistory() {
    emit(HistoryShippingLoadingState());
    DioHelper.getData(
            path: ApiConstant.historyShippingPath(
              CacheHelper.getData(key: SharedKey.id),
            ),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      historyShippingModel = HistoryShippingModel.fromJson(value.data);
      emit(HistoryShippingSuccessState());
    }).catchError((error) {
      emit(HistoryShippingSuccessState());
    });
  }

  HistoryTicketModel historyTicketModel = HistoryTicketModel();
  void getTicketHistory() {
    emit(HistoryTicketLoadingState());
    DioHelper.getData(
            path: ApiConstant.historyTicketPath(
              CacheHelper.getData(key: SharedKey.id),
            ),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      historyTicketModel = HistoryTicketModel.fromJson(value.data);
      emit(HistoryTicketSuccessState());
    }).catchError((error) {
      emit(HistoryTicketSuccessState());
    });
  }
}
