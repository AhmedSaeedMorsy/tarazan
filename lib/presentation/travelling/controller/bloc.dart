import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodany/presentation/travelling/controller/states.dart';
import '../../../app/constant/enums_extentions.dart';

class TravellingBloc extends Cubit<TravellingStates> {
  TravellingBloc() : super(TravellingInitState());
  static TravellingBloc get(context) => BlocProvider.of(context);
  TravellingEnum travellingRadioButtonValue = TravellingEnum.bus;


  void changeRadioButton(TravellingEnum value) {
    travellingRadioButtonValue = value;
    emit(ChangeRadioButtonState());
  }
}
