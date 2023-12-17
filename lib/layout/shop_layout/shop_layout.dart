import 'package:e_commerce_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/states.dart';
import 'package:e_commerce_app/modules/shop_app/search/search_scrren.dart';


class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopHomeCubit cubit = ShopHomeCubit.get(context);
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('E-commerce'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);

            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
