import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/shipping_model.dart';
import 'states.dart';

class SelectShippingTicketsBloc extends Cubit<SelectTripShippingStates> {
  SelectShippingTicketsBloc() : super(SelectTripShippingInitStates());
  static SelectShippingTicketsBloc get(context) => BlocProvider.of(context);

  ShippingModel shippingModel = ShippingModel();
  void shippingTicket({
    required String fromLocation,
    required String toLocation,
    required String typeId,
  }) {
    emit(ShippingTicketsLoadingState());
    DioHelper.postData(
        path: ApiConstant.shippingTicketPath,
        token: CacheHelper.getData(
          key: SharedKey.token,
        ),
        data: {
          "from_location": fromLocation,
          "to_location": toLocation,
          "type_id": typeId,
        }).then((value) {
      shippingModel = ShippingModel.fromJson(value.data);
      emit(ShippingTicketsSuccessState());
    }).catchError((error) {
      emit(ShippingTicketsErrorState());
    });
  }

  int amount = 1;
  void incrementAmount() {
    amount++;
    emit(IncrementAmountState());
  }

  void decrementAmount() {
    if (amount <= 1) {
      amount = 1;
    } else {
      amount--;
    }

    emit(DecrementAmountState());
  }

  void bookTicket({
    required int shippingId,
    required int userId,
    required BuildContext context,
    required String categoryId,
    required String amount,
    required String productName,
  }) {
    emit(BookTicketLoadingState());
    DioHelper.postData(
      path: ApiConstant.bookShippingTicketPath,
      data: {
        "shipping_id": shippingId,
        "user_id": userId,
        "category_id": categoryId,
        "amount": amount,
        "product_name": productName
      },
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      emit(BookTicketSuccessState());
    }).catchError((error) {
      emit(BookTicketErrorState());
    });
  }
}
