import 'package:e_commerce_app/models/shop_app/register_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  ShopRegisterModel registerModel;
  ShopRegisterSuccessState(
      this.registerModel
      );
}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangeState extends ShopRegisterStates{}




