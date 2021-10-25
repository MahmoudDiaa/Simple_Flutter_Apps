import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/search_products_model_entity.dart';
import 'package:udemy_flutter/modules/shop_app/search/cubit/state.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/end_points.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(ShopSearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchProductsModelEntity? searchProductsModel;

  void postSearchData(String searchData) {
    emit(ShopLoadingSearchDataState());
    DioHelper.postData(
        path: PRODUCT_SEARCH,
        data: {'text': searchData},
        token: token,
        lang: 'en')
        .then((value) {
      searchProductsModel = SearchProductsModelEntity().fromJson(value.data);
      emit(ShopSuccessSearchDataState(searchProductsModel!));
      print(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorSearchDataState(error.toString()));
    });
  }


}
