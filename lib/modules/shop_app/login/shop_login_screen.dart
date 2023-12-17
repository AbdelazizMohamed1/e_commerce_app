import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/components/components.dart';
import 'package:e_commerce_app/components/constants.dart';
import 'package:e_commerce_app/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toast/toast.dart';
import 'package:e_commerce_app/layout/shop_layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/shop_layout/shop_layout.dart';

import 'package:e_commerce_app/modules/shop_app/login/shop_login_cubit.dart';
import 'package:e_commerce_app/modules/shop_app/login/shop_login_states.dart';
import 'package:e_commerce_app/modules/shop_app/register/register_screen.dart';


class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void fieldFocusChange(BuildContext context, FocusNode currentFocusNode,
      FocusNode nextFocusNode) {
    currentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text('Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25.0,
                            )),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text('Welcome Back!',
                            style: TextStyle(
                              fontSize: 20.0,
                            )),
                        const SizedBox(
                          height: 50.0,
                        ),
                        defultTextFormField(
                          focusNode: emailFocusNode,
                          onSubmit: (value) {
                            fieldFocusChange(
                                context, emailFocusNode, passwordFocusNode);
                          },
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          hintText: 'example@gmail.com',
                          labelText: 'Email Address',
                          prefix: Icon(Icons.email),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defultTextFormField(
                          focusNode: passwordFocusNode,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          prefix: Icon(Icons.lock),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                          },
                          obscureText: ShopLoginCubit.get(context).isShown,
                          suffix: IconButton(
                              onPressed: () {
                                ShopLoginCubit.get(context).changePassword();
                              },
                              icon: ShopLoginCubit.get(context).icon),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defultMaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Login'),
                            fallback: (context) =>
                                const CircularProgressIndicator()),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have an account!',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                            Expanded(
                                child: defultTextButton(
                                    onPressed: () {
                                      navigateTo(context, ShopRegisterScreen());
                                    },
                                    text: 'register now')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          ToastContext().init(context);
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
              Toast.show(
                state.loginModel.message!,
                backgroundColor: Colors.green,
                gravity: Toast.bottom,
                duration: Toast.lengthLong,
              );
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                token = state.loginModel.data!.token;
                navigateToAndFinish(context, ShopLayout());
                ShopHomeCubit.get(context).getHomeData();
                ShopHomeCubit.get(context).getCategoriesData();
                ShopHomeCubit.get(context).getFavorites();
                ShopHomeCubit.get(context).getProfile();

              });
              print(state.loginModel.status);
              print(state.loginModel.message);
              print(state.loginModel.data!.name);
              print(state.loginModel.data!.token);
            }else{
              showToast(message: state.loginModel.message!, color: Colors.red);
              print(state.loginModel.status);
              print(state.loginModel.message);
            }
          }
        },
      ),
    );
  }
}
