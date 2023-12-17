import 'package:e_commerce_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:e_commerce_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:e_commerce_app/modules/shop_app/register/shop_register_cubit.dart';
import 'package:e_commerce_app/modules/shop_app/register/shop_register_states.dart';


class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),

      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          ToastContext().init(context);
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              showToast(
                  message: state.registerModel.message, color: Colors.green);
              navigateToAndFinish(context, ShopLoginScreen());
            } else {
              showToast(
                  message: state.registerModel.message, color: Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text('Register',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25.0,
                            )),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text('Register now to can join us shopping',
                            style: TextStyle(
                              fontSize: 20.0,
                            )),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defultTextFormField(
                          focusNode: nameFocusNode,
                          onSubmit: (value) {
                            fromFormToNext(context: context,
                              currentFocusNode: nameFocusNode,
                              nextFocusNode: phoneFocusNode,);
                          },
                          controller: nameController,
                          textInputType: TextInputType.name,
                          labelText: 'name',
                          prefix: Icon(Icons.lock),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'name must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defultTextFormField(
                          focusNode: phoneFocusNode,
                          onSubmit: (value) {
                            fromFormToNext(context: context,
                              currentFocusNode: phoneFocusNode,
                              nextFocusNode: emailFocusNode,);
                          },
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          labelText: 'phone number',
                          prefix: Icon(Icons.phone_android),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'phone must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defultTextFormField(
                          focusNode: emailFocusNode,
                          onSubmit: (value) {
                            fromFormToNext(context: context,
                              currentFocusNode: emailFocusNode,
                              nextFocusNode: passwordFocusNode,);
                          },
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'email',
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
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).registerUser(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'password',
                          prefix: Icon(Icons.lock),
                          suffix: IconButton(onPressed: () {
                            ShopRegisterCubit.get(context).changePassword();
                          },
                            icon: ShopRegisterCubit
                                .get(context)
                                .icon
                            ,),
                          obscureText: ShopRegisterCubit
                              .get(context)
                              .isShown,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defultMaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).registerUser(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'Register',
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            const Text('Already have an account',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                            Expanded(
                                child: defultTextButton(
                                    onPressed: () {
                                      navigateTo(context, ShopLoginScreen());
                                    },
                                    text: 'login now')),
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
      ),
    );
  }
}
