import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/services/dio_helper/dio_helper.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';

import '../../../model/user_model.dart';
import 'states.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitState());
  static HomeBloc get(context) => BlocProvider.of(context);
  UserData userData = UserData();
  void getUserData() {
    emit(UserLoadingState());
    DioHelper.getData(
            path: ApiConstant.getUser,
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      userData = UserData.fromJson(value.data);
      emit(UserSuccessState());
    }).catchError((erorr) {
      emit(UserErrorState());
    });
  }

  bool isChange = false;
  void changeFromTo() {
    isChange = !isChange;
    emit(ToggleBetweenFromToState());
  }
  
}
