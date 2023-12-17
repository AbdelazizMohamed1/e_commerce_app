import 'package:e_commerce_app/models/shop_app/search_model.dart';

abstract class SearchStates{}

class ShopSearchInitialState extends SearchStates{}

class ShopSearchLoadingState extends SearchStates{}

class ShopSearchSuccessState extends SearchStates{
  final SearchModel model;

  ShopSearchSuccessState(this.model);
}

class ShopSearchErrorState extends SearchStates{}