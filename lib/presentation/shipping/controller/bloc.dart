import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/constant/enums_extentions.dart';
import 'states.dart';

class ShippingBloc extends Cubit<ShippingStates> {
  ShippingBloc() : super(ShippingInitState());
  static ShippingBloc get(context) => BlocProvider.of(context);
  ShippingEnum shippingRadioButtonValue = ShippingEnum.regular;

  void changeRadioButton(ShippingEnum value) {
    shippingRadioButtonValue = value;
    emit(ChangeRadioButtonState());
  }
}
