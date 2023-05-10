import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/services/dio_helper/dio_helper.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';

import '../../../model/category_shipping_model.dart';
import 'states.dart';

class CategoryShippingBloc extends Cubit<CategoryShippingStates> {
  CategoryShippingBloc() : super(CategoryShippingInitState());
  static CategoryShippingBloc get(context) => BlocProvider.of(context);
  CategoryShippingModel categoryShippingModel = CategoryShippingModel();
  List<CategoryShippingDataModel> categoryWithoutOther = [];
  void getCategoris() {
    emit(CategoryShippingLoadingState());
    DioHelper.getData(
      path: ApiConstant.categoriesPath,
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      categoryShippingModel = CategoryShippingModel.fromJson(value.data);
      for (var element in categoryShippingModel.data) {
        if (element.id != 1) {
          categoryWithoutOther.add(element);
        }
      }
      emit(CategoryShippingSuccessState());
    }).catchError((error) {
      emit(CategoryShippingErrorState());
    });
  }
}
