import 'package:e_commerce_app/components/constants.dart';
import 'package:e_commerce_app/network/end_points.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/models/shop_app/search_model.dart';

import 'package:e_commerce_app/modules/shop_app/search/states.dart';


class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(ShopSearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
    dynamic length;
  SearchModel? searchModel;
  void searchProduct({
    required String text,
  }){
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        path: SEARCH_PRODUCT,
        token: token,
        data: {
          'text':text,
        }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
        length = searchModel!.data.data.length;
      print(value.data);
      print(searchModel!.data.data.length);

      emit(ShopSearchSuccessState(searchModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}

