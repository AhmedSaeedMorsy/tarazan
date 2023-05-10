import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodany/app/common/widget.dart';
import '../../../app/constant/api_constant.dart';
import '../../../app/services/dio_helper/dio_helper.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../../model/ticket_trip_model.dart';
import '../../../model/travelling_model.dart';
import 'states.dart';

class SelectTravellingTicketsBloc extends Cubit<SelectTripTravellingStates> {
  SelectTravellingTicketsBloc() : super(SelectTripTravellingInitStates());
  static SelectTravellingTicketsBloc get(context) => BlocProvider.of(context);
  TravellingModel travellingModel = TravellingModel();
  void travellingTicket({
    required String fromLocation,
    required String toLocation,
    required String typeId,
  }) {
    emit(TravellingTicketsLoadingState());
    DioHelper.postData(
        path: ApiConstant.travellingTicketPath,
        token: CacheHelper.getData(
          key: SharedKey.token,
        ),
        data: {
          "from_location": fromLocation,
          "to_location": toLocation,
          "type_id": typeId,
        }).then((value) {
      travellingModel = TravellingModel.fromJson(value.data);
      emit(TravellingTicketsSuccessState());
    }).catchError((error) {
      emit(TravellingTicketsErrorState());
    });
  }

  int numberOfSeats = 1;
  void incrementNumberOfSeats() {
    numberOfSeats++;
    emit(IncrementNumberOfSeatsState());
  }

  void decrementNumberOfSeats() {
    if (numberOfSeats <= 1) {
      numberOfSeats = 1;
    } else {
      numberOfSeats--;
    }

    emit(DecrementNumberOfSeatsState());
  }

  TicketTirpModel ticketTirpModel = TicketTirpModel();
  void bookTicket({
    required int travelId,
    required int userId,
    required int seats,
    required BuildContext context,
    required String date,
    required String time,
    required String fromLocation,
    required String toLocation,
  }) {
    emit(BookTicketLoadingState());
    DioHelper.postData(
      path: ApiConstant.bookAticketPath,
      data: {
        "travel_id": travelId,
        "user_id": userId,
        "seats": seats,
      },
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      ticketTirpModel = TicketTirpModel.fromJson(value.data);
      SharedWidget.tripTicketDetailsDialog(
        context: context,
        date: date,
        time: time,
        fromLocation: fromLocation,
        toLocation: toLocation,
        price: ticketTirpModel.data.cost.toString(),
      );
      emit(BookTicketSuccessState());
    }).catchError((error) {
      emit(BookTicketErrorState());
    });
  }
}
