import 'package:e_commerce_app/models/shop_app/change_favorites_model.dart';
import 'package:e_commerce_app/models/shop_app/login_model.dart';

abstract class ShopHomeStates{}

class ShopHomeInitialState extends ShopHomeStates{}

class ShopHomeChangeBottomNavState extends ShopHomeStates{}

class ShopHomeLoadingState extends ShopHomeStates{}

class ShopHomeSuccessState extends ShopHomeStates{}

class ShopHomeErrorState extends ShopHomeStates{}

class ShopCategoriesSuccessState extends ShopHomeStates{}

class ShopCategoriesErrorState extends ShopHomeStates{}

class ShopChangeFavoritesState extends ShopHomeStates{}

class ShopAddSuccessFavoritesState extends ShopHomeStates{
  final ChangeFavoritesModel model;

  ShopAddSuccessFavoritesState(this.model);
}

class ShopAddFavoritesErrorState extends ShopHomeStates{}

class ShopGetFavoritesLoadingState extends ShopHomeStates{}

class ShopGetFavoritesSuccessState extends ShopHomeStates{}

class ShopGetFavoritesErrorState extends ShopHomeStates{}

class ShopGetProfileLoadingState extends ShopHomeStates{}

class ShopGetProfileSuccessState extends ShopHomeStates{
  final ShopLoginModel model;

  ShopGetProfileSuccessState(this.model);

}

class ShopGetProfileErrorState extends ShopHomeStates{}

class ShopUpdateProfileLoadingState extends ShopHomeStates{}

class ShopUpdateProfileSuccessState extends ShopHomeStates{
  final ShopLoginModel model;

  ShopUpdateProfileSuccessState(this.model);


}

class ShopUpdateProfileErrorState extends ShopHomeStates{}








