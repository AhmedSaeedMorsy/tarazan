import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/services/dio_helper/dio_helper.dart';
import 'package:sodany/presentation/register/controller/states.dart';
import '../../../model/user_model.dart';

class RegisterBloc extends Cubit<RegisterUserStates> {
  RegisterBloc() : super(RegisterUserInitState());
  static RegisterBloc get(context) => BlocProvider.of(context);
  UserModel userModel = UserModel();

  bool isShownConfirmPassword = true;
  bool isShownPassword = true;
  Icon suffixConfirmPassword = const Icon(Icons.visibility_off_outlined);
  Icon suffixPassword = const Icon(Icons.visibility_off_outlined);

  void changeVisibilityPassword() {
    isShownPassword = !isShownPassword;

    suffixPassword = isShownPassword
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);

    emit(ChangeVisibilityPasswordState());
  }

  void changeVisibilityConfirmPassword() {
    isShownConfirmPassword = !isShownConfirmPassword;

    suffixConfirmPassword = isShownConfirmPassword
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);
    emit(ChangeVisibilityPasswordState());
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
    }
  }

  profileCoverImage() {
    if (profileImage != null) {
      return FileImage(profileImage!);
    } else {
      return null;
    }
  }

  void registerUser({
    required String name,
    required String email,
    required String passwordConfirmation,
    required String password,
    required String phone,
    required File profileImageFile,
  }) async {
    emit(RegisterUserLoadingState());
    String fileName = profileImageFile.path.split('/').last;
    FormData data = FormData.fromMap({
      "name": name,
      "email": email,
      "password_confirmation": passwordConfirmation,
      "password": password,
      "phone": phone,
      "image": await MultipartFile.fromFile(
        profileImageFile.path,
        filename: fileName,
      ),
    });
    DioHelper.postData(
      path: ApiConstant.registerPath,
      data: data,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(RegisterUserSuccessState());
    }).catchError((error) {
      emit(RegisterUserErrorState(error.toString()));
    });
  }
}
