import 'package:e_commerce_app/components/constants.dart';
import 'package:e_commerce_app/network/end_points.dart';
import 'package:e_commerce_app/network/local/cache_helper.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/states.dart';
import 'package:e_commerce_app/models/shop_app/categories_model.dart';
import 'package:e_commerce_app/models/shop_app/change_favorites_model.dart';
import 'package:e_commerce_app/models/shop_app/favorites_model.dart';
import 'package:e_commerce_app/models/shop_app/home_model.dart';
import 'package:e_commerce_app/models/shop_app/login_model.dart';

import 'package:e_commerce_app/modules/shop_app/categories/categories_screen.dart';
import 'package:e_commerce_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:e_commerce_app/modules/shop_app/home/home_screen.dart';
import 'package:e_commerce_app/modules/shop_app/settings/settings_screen.dart';


class ShopHomeCubit extends Cubit<ShopHomeStates>{

  ShopHomeCubit() : super(ShopHomeInitialState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomNav(int index){
    currentIndex = index;
    emit(ShopHomeChangeBottomNavState());
  }

  List<Widget> bottomScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.apps),
        label: 'Categories'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorite'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),
  ];
   HomeModel? homeModel;
   Map<int,bool> favorites ={} ;
  void getHomeData(){
    emit(ShopHomeLoadingState());
    DioHelper.getData(
        path: HOME,
        token: CacheHelper.getData('token'),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavourites
        });
      });
      emit(ShopHomeSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
      path: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);

      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
   void changeFavorites(int productId)
   {
     favorites[productId] = !favorites[productId]!;
     emit(ShopChangeFavoritesState());
     DioHelper.postData(
        path: ADD_FAVORITES,
        data: {
          'product_id' : productId
        },
     token: token
    ).then((value) {
       changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);


       print(value.data);

       if(!changeFavoritesModel!.status!){
         favorites[productId] = !favorites[productId]!;
       }else{

         getFavorites();
       }
      emit(ShopAddSuccessFavoritesState(changeFavoritesModel!));

    }).catchError((error){
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopAddFavoritesErrorState());
    });

  }
  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopGetFavoritesLoadingState());
     DioHelper.getData(
         path: ADD_FAVORITES,
         token: token,
     ).then((value) {
       favoritesModel = FavoritesModel.fromJson(value.data);
       emit(ShopGetFavoritesSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(ShopGetFavoritesErrorState());
     });

  }
   ShopLoginModel? loginModel;
void getProfile(){
  emit(ShopGetProfileLoadingState());
    DioHelper.getData(
        path: GET_PROFILE,
        token: token,
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data!);
     // print(loginModel!.data!.name);
      emit(ShopGetProfileSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetProfileErrorState());
    });
}

  void updateProfile({
    required String name,
    required String email,
    required String phone,
}){
    emit(ShopUpdateProfileLoadingState());
    DioHelper.putData(
      path: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,

      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      getProfile();
      print(value.data!);
      // print(loginModel!.data!.name);
      emit(ShopUpdateProfileSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopUpdateProfileErrorState());
    });
  }

}