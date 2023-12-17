import 'package:e_commerce_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/models/shop_app/search_model.dart';
import 'package:e_commerce_app/modules/shop_app/search/cubit.dart';
import 'package:e_commerce_app/modules/shop_app/search/states.dart';

class SearchScreen extends StatelessWidget {

var searchController = TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {
        },
        builder: (context, state) {

          return  Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defultTextFormField(
                        controller: searchController,
                        textInputType: TextInputType.text,
                      labelText: 'Search',
                      onChange: (String value){
                          if(formKey.currentState!.validate()) {
                            SearchCubit.get(context).searchProduct(
                                text: searchController.text);
                          }
                      },
                      validate: (value) {
                        if(value!.isEmpty){
                          'search must not be empty';
                        }else{
                         return null ;
                        }

                      },
                    ),
                   SizedBox(
                     height: 20.0,
                   ),
                   if(state is ShopSearchLoadingState)
                     const LinearProgressIndicator(),
                    const SizedBox(
                      height: 40.0,
                    ),
                    if(state is ShopSearchSuccessState && state.model.status == true)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return buildListProduct(SearchCubit.get(context).searchModel!.data.data[index],context);
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 1.0,
                              color: Colors.grey,
                              thickness: 1.0,
                            );
                          },
                          itemCount: SearchCubit.get(context).length
                      ),
                    ),
                    if(state is ShopSearchSuccessState && state.model.data.data.isEmpty)
                      const Center(child: Text('No Product'))


                  ],
                ),
              ),
            ),
          );
        },

      ),
    );

  }
}
Widget buildListProduct(SearchDataModel model,context) => Padding(

  padding: const EdgeInsets.all(20.0),

  child: Container(

    height: 150.0,

    child: Row(

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

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model.name}',

                maxLines: 3,

                overflow: TextOverflow.ellipsis,

              ),



              Spacer(),

              Row(

                children: [

                  Text(

                    'Price: ${model.price}',

                    style:

                    TextStyle(fontSize: 12.0, color: Colors.deepOrange),

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                  ),

                  const SizedBox(

                    width: 10.0,

                  ),

                  Spacer(),

                  CircleAvatar(

                    radius: 20.0,

                    backgroundColor:

                        model.inFavorites! ?

                    // ShopHomeCubit.get(context).favorites[model.id]! ?

                    Colors.deepOrange :

                     Colors.grey,

                      child: Icon(

                        Icons.favorite_border_outlined,

                        color: Colors.white,

                      ),

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


