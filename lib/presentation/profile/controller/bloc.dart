import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/services/dio_helper/dio_helper.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';
import 'package:sodany/presentation/profile/controller/states.dart';

import '../../../model/user_model.dart';

class ProfileBloc extends Cubit<ProfileStates> {
  ProfileBloc() : super(ProfileInitState());
  static ProfileBloc get(context) => BlocProvider.of(context);

  EditProfileModel editProfileModel = EditProfileModel();
  void editProfile(dynamic data) {
    isShowEmail = false;
    isShowName = false;
    isShowPhone = false;
    emit(EditProfileLoadingState());
    DioHelper.updateData(
      path: ApiConstant.editProfilePath(
        CacheHelper.getData(key: SharedKey.id).toString(),
      ),
      token: CacheHelper.getData(key: SharedKey.token),
      data: data,
    ).then((value) {
      editProfileModel = EditProfileModel.fromJson(value.data);
      emit(EditProfileSuccessState());
    }).catchError((error) {
      emit(EditProfileErrorState());
    });
  }

  bool isShowName = false;
  bool isShowEmail = false;
  bool isShowPhone = false;
  void showNameField() {
    isShowName = !isShowName;
    emit(ShowNameFieldState());
  }

  void showEmailField() {
    isShowEmail = !isShowEmail;
    emit(ShowEmailFieldState());
  }

  void showPhoneField() {
    isShowPhone = !isShowPhone;
    emit(ShowPhoneFieldState());
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
    emit(ChangeImageState());
  }

  profileCoverImage() {
    if (profileImage != null) {
      return FileImage(profileImage!);
    } else {
      return NetworkImage(
          "${ApiConstant.baseUrl}storage/${editProfileModel.data.image}");
    }
  }

  void editProfileImage({required File profileNewImage}) async {
    emit(EditProfileLoadingState());
    String fileName = profileNewImage.path.split('/').last;
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        profileNewImage.path,
        filename: fileName,
      ),
    });
    DioHelper.postData(
      path: ApiConstant.editProfileImagePath(
          CacheHelper.getData(key: SharedKey.id).toString()),
      token: CacheHelper.getData(key: SharedKey.token),
      data: data,
    ).then((value) {
      editProfileModel = EditProfileModel.fromJson(value.data);
      emit(EditProfileSuccessState());
    }).catchError((error) {
      emit(EditProfileErrorState());
    });
  }
}
