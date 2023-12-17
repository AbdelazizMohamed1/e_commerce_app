import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/states.dart';
import 'package:e_commerce_app/models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCatItem(ShopHomeCubit.get(context).categoriesModel!.data!.data[index]);
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Colors.grey,
                  height: 1.0,
                  thickness: 1.0,

                ),
              );
            },
            itemCount: ShopHomeCubit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }
}
Widget buildCatItem(CategoriesData model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
          height: 150.0,
          width: 150.0,
          fit: BoxFit.cover,
          image: NetworkImage('${model.image}')),
      SizedBox(
        width: 10.0,
      ),
      Text('${model.name}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),),
      Spacer(),
      Icon(Icons.arrow_forward_ios),
    ],
  ),
);
