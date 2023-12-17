import 'package:e_commerce_app/network/end_points.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/models/shop_app/login_model.dart';
import 'package:e_commerce_app/modules/shop_app/login/shop_login_states.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());


  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      path: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {

      loginModel = ShopLoginModel.fromJson(value.data);
      //print(loginModel!.message);
      //print(loginModel!.data!.name);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  bool isShown = true;
  Widget icon = const Icon(Icons.remove_red_eye);

  void changePassword() {
    isShown = !isShown;
    isShown
        ? icon = const Icon(Icons.remove_red_eye)
        : icon = const Icon(Icons.visibility_off_rounded);
    emit(ShopLoginChangeState());
  }
}
