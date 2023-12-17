import 'package:e_commerce_app/bloc_observier.dart';
import 'package:e_commerce_app/components/constants.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/states.dart';
import 'package:e_commerce_app/layout/shop_layout/shop_layout.dart';
import 'package:e_commerce_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:e_commerce_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce_app/network/local/cache_helper.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:e_commerce_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();

  Widget widget;

  dynamic onboarding = CacheHelper.getData('onBoarding');
  token = CacheHelper.getData('token');
  if (onboarding != null) {
    if (token != null) {
      print(token);
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  print(onboarding.toString());
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;

  MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopHomeCubit(

          )..getHomeData()..getCategoriesData()..getFavorites()..getProfile(),
        ),
      ],
      child: BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            themeMode: ThemeMode.light,
            // NewsCubit.get(context).isDark
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
            darkTheme: darkTheme(),
            home: widget,
          );
        },
      ),
    );
  }
}
