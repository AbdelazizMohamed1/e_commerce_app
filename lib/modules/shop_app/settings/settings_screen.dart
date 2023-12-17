import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/components/components.dart';
import 'package:e_commerce_app/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/states.dart';
import 'package:e_commerce_app/modules/shop_app/login/shop_login_screen.dart';


class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {
        ToastContext().init(context);
        if (state is ShopUpdateProfileSuccessState) {
          if (state.model.status && state.model.data != null) {
            showToast(message: state.model.message!, color: Colors.green);
            ShopHomeCubit.get(context).getProfile();
          } else if (state.model.data == null) {
            showToast(message: state.model.message!, color: Colors.red);
          }
          //   nameController.text = state.model.data!.name!;
          //   emailController.text = state.model.data!.email!;
          //   phoneController.text = state.model.data!.phone!;
        }
      },
      builder: (context, state) {
        var model = ShopHomeCubit.get(context).loginModel;
        if (model!.status) {
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
        }
        return ConditionalBuilder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 62.0,
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                          child: ClipOval(
                            child: Image(
                              width: 120.0,
                              height: 120.0,
                              image: NetworkImage('${model.data!.image}'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      if (state is ShopUpdateProfileLoadingState)
                        const LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      defultTextFormField(
                        controller: nameController,
                        textInputType: TextInputType.text,
                        labelText: 'UserName',
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defultTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Email Address'),
                      SizedBox(
                        height: 20.0,
                      ),
                      defultTextFormField(
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          labelText: 'phone'),
                      SizedBox(
                        height: 20.0,
                      ),
                      defultMaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ShopHomeCubit.get(context).updateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: 'Update'),
                      SizedBox(
                        height: 20.0,
                      ),
                      defultMaterialButton(
                          onPressed: () {
                            CacheHelper.clearData(key: 'token').then((value) {
                              if (value) {
                                navigateToAndFinish(context, ShopLoginScreen());
                                print(value.toString());
                              }
                            });
                          },
                          text: 'Logout'),
                    ],
                  ),
                ),
              ),
            );
            ;
          },
          condition: ShopHomeCubit.get(context).loginModel!.data != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
