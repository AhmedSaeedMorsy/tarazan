import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodany/app/constant/api_constant.dart';
import 'package:sodany/app/services/dio_helper/dio_helper.dart';
import 'package:sodany/app/services/shared_prefrences/cache_helper.dart';
import 'package:sodany/model/quotation_model.dart';
import 'states.dart';

class QuotationBloc extends Cubit<QuotationStates> {
  QuotationBloc() : super(QuotationInitState());
  static QuotationBloc get(context) => BlocProvider.of(context);
  QuotationModel quotationModel = QuotationModel();

  void getQuotation({
    required int id,
  }) {
    emit(QuotationLoadingState());
    DioHelper.getData(
            path: ApiConstant.quotationPath(
              id,
            ),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      quotationModel = QuotationModel.fromJson(value.data);
      emit(QuotationSuccessState());
    }).catchError((error) {
      emit(QuotationErrorState());
    });
  }

  void allowQuotation({required int id}) {
    emit(AllowQuotationLoadingState());
    DioHelper.postData(
            path: ApiConstant.allowQuotationPath(id),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      emit(AllowQuotationSuccessState());
    }).catchError((error) {
      emit(AllowQuotationErrorState());
    });
  }

  void denyQuotation({required int id}) {
    emit(DenyQuotationLoadingState());
    DioHelper.delData(
            path: ApiConstant.denyQuotationPath(id),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      emit(DenyQuotationSuccessState());
    }).catchError((error) {
      emit(DenyQuotationErrorState());
    });
  }
}
