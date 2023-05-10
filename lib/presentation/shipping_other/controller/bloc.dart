import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/services/dio_helper/dio_helper.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';

import 'states.dart';

class ShippingOtherBloc extends Cubit<ShippingOtherStates> {
  ShippingOtherBloc() : super(ShippingOtherInitState());
  static ShippingOtherBloc get(context) => BlocProvider.of(context);

  File? productImage;
  var picker = ImagePicker();
  Future<void> getproductImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
    }
    emit(ChooseImageState());
  }

  productCoverImage() {
    if (productImage != null) {
      return FileImage(productImage!);
    } else {
      return const AssetImage("");
    }
  }

  void shippingOtherCategory({
    required String shippingId,
    required String amount,
    required String productName,
    required File profileNewImage,
  }) async {
    emit(ShippingOtherLoadingState());
    String fileName = profileNewImage.path.split('/').last;
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        profileNewImage.path,
        filename: fileName,
      ),
      "shipping_id": shippingId,
      "user_id": CacheHelper.getData(key: SharedKey.id),
      "category_id": 1,
      "amount": amount,
      "product_name": productName,
    });
    DioHelper.postData(
      path: ApiConstant.bookShippingTicketPath,
      token: CacheHelper.getData(key: SharedKey.token),
      data: data,
    ).then((value) {
      emit(ShippingOtherSuccessState());
    }).catchError((error) {
      emit(ShippingOtherErrorState());
    });
  }
}
