import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/services/dio_helper/dio_helper.dart';
import '../../../model/user_model.dart';
import 'states.dart';

class LoginBloc extends Cubit<LoginUserStates> {
  LoginBloc() : super(LoginUserInitState());
  static LoginBloc get(context) => BlocProvider.of(context);
  UserModel userModel = UserModel();

  bool isShownPassword = true;
  Icon suffixPassword = const Icon(Icons.visibility_off_outlined);

  void changeVisibilityPassword() {
    isShownPassword = !isShownPassword;

    suffixPassword = isShownPassword
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);

    emit(ChangeVisibilityPasswordState());
  }

  void loginrUser({
    required String email,
    required String password,
  }) {
    emit(LoginUserLoadingState());
    DioHelper.postData(
      path: ApiConstant.loginPath,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      getDeviceToken(token: userModel.token);
      emit(LoginUserSuccessState());
    }).catchError((error) {
      emit(LoginUserErrorState(error.toString()));
    });
  }

  void getDeviceToken({
    required String token,
  }) async {
    DioHelper.postData(
      path: ApiConstant.sendDeviceTokenPath,
      token: token,
      data: {
        "token": await FirebaseMessaging.instance.getToken(),
      },
    );
  }
}
