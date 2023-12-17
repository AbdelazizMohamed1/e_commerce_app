import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/states.dart';
import 'package:e_commerce_app/models/shop_app/categories_model.dart';
import 'package:e_commerce_app/models/shop_app/home_model.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {

        if(state is ShopAddSuccessFavoritesState){
         if(!state.model.status!){

           showToast(message: state.model.message!, color: Colors.red);
         }else{
           showToast(message: state.model.message!, color: Colors.green);
         }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopHomeCubit.get(context).homeModel != null && ShopHomeCubit.get(context).categoriesModel != null,
          builder: (context) =>
              productsBuilder(ShopHomeCubit.get(context).homeModel,ShopHomeCubit.get(context).categoriesModel,context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget productsBuilder(HomeModel? model,CategoriesModel? categoriesModel,context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ).toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Categories',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 120.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoryItem(categoriesModel!.data!.data[index]),
                    separatorBuilder:(context, index) =>  const SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoriesModel!.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text('Products',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.52,
              crossAxisCount: 2,
              children: List.generate(
                model.data.products.length,
                (index) => buildGridProduct(model.data.products[index],context),
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );

Widget buildGridProduct(ProductsModel model,context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  '${model.image}',
                ),
                width: double.infinity,
                height: 200.0,
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      'Price:${model.price.round()}',
                      style:
                          TextStyle(fontSize: 12.0, color: Colors.deepOrange),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 20.0,
                      backgroundColor: ShopHomeCubit.get(context).favorites[model.id]! ? Colors.deepOrange : Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            ShopHomeCubit.get(context).changeFavorites(model.id);
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
    );

Widget buildCategoryItem(CategoriesData model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(
              '${model.image}',
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 120.0,
          height: 20.0,
          color: Colors.black.withOpacity(0.4),
          child: Text(
            '${model.name}',
            style: TextStyle(
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
