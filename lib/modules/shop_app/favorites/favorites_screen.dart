import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/states.dart';
import 'package:e_commerce_app/models/shop_app/favorites_model.dart';


class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) =>  ListView.separated(
              itemBuilder: (context, index) {
                return buildListProduct(ShopHomeCubit.get(context).favoritesModel!.data.data[index].product,context);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1.0,
                  color: Colors.grey,
                  thickness: 1.0,
                );
              },
              itemCount: ShopHomeCubit.get(context).favoritesModel!.data.data.length
          ) ,
          fallback:(context) =>  const Center(child: CircularProgressIndicator()),
          condition:  ShopHomeCubit.get(context).favoritesModel != null

        );
      },

    );
  }
}

Widget buildListProduct(Product model,context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(

    height: 150.0,
    child: Row(
      children: [
        Stack(

          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              height: 150.0,
              width: 150.0,
              errorBuilder: (context, error, stackTrace) {
                return Text('Error loading image: $error');
              },


            ),

              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: 90.0,
                  height: 30.0,
                  color: Colors.red,
                  child: Center(
                      child: Text(
                        'Discount',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                style: TextStyle(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    'Price: ${model.price.round()}',
                    style:
                    TextStyle(fontSize: 12.0, color: Colors.deepOrange),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),

                    if (model.discount != 0 )
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  Spacer(),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor:

                    ShopHomeCubit.get(context).favorites[model.id]! ?
                    Colors.deepOrange
                     : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                            ShopHomeCubit.get(context).changeFavorites(model.id!);
                          // ShopHomeCubit.get(context).getFavorites();
                        },
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);