import 'package:e_commerce_app/network/end_points.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/models/shop_app/register_model.dart';
import 'package:e_commerce_app/modules/shop_app/register/shop_register_states.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  ShopRegisterModel? registerModel;

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
void registerUser({
    required String name,
    required String phone,
  required String email,
  required String password,


}){
  emit(ShopRegisterLoadingState());
  DioHelper.postData(
      path: REGISTER,
      data: {
        'name': name,
        'phone':phone,
        'email':email,
        'password': password,
        'image': ''
      }).then((value) {
        registerModel = ShopRegisterModel.fromJson(value.data);
        print(registerModel!.status);
        print(registerModel!.message);
        emit(ShopRegisterSuccessState(registerModel!));
  }).catchError((error){
    print(error.toString());
    emit(ShopRegisterErrorState(error.toString()));
  });
}
  bool isShown = true;
  Widget icon = const Icon(Icons.remove_red_eye);

  void changePassword() {
    isShown = !isShown;
    isShown
        ? icon = const Icon(Icons.remove_red_eye)
        : icon = const Icon(Icons.visibility_off_rounded);
    emit(ShopRegisterChangeState());
  }

}