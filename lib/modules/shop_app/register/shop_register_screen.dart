import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/shopLayout.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/modules/shop_app/register/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/register/cubit/state.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterCubitStates>(
          listener: (BuildContext context, state) {

            if (state is ShopRegisterCubitSuccessState) {
              if (state.loginModel.status!) {
                CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  token = state.loginModel.data!.token!;
                  navigateAndFinish(context, ShopLayout());
                });
              } else {
                showToast(
                    message: state.loginModel.message!,
                    states: ToastStates.ERROR);
              }
            }
          },
          builder: (BuildContext context, Object? state) {
            var cubit = ShopRegisterCubit.get(context);
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: nameController,
                            textInputType: TextInputType.name,
                            label: "User Name",
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your User Name';
                              } else
                                return null;
                            },
                            prefix: Icons.person),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            label: "Email",
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your email address';
                              } else
                                return null;
                            },
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            label: "Phone",
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your Phone';
                              } else
                                return null;
                            },
                            prefix: Icons.phone),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            controller: passController,
                            onPressSuffix: () {
                              cubit.changePasswordVisibility();
                            },
                            textInputType: TextInputType.visiblePassword,
                            label: "Password",
                            obscure: cubit.isPasswordShown,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit
                                  ..userRegister(
                                    email: emailController.text,
                                    password: passController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                              }
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your password';
                              } else
                                return null;
                            },
                            prefix: Icons.lock_outline,
                            suffixIcon: cubit.suffix),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is ! ShopRegisterCubitLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('have an account ?'),
                            defaultTextButton(
                                onPress: () {
                                  navigateTo(context, ShopLoginScreen());
                                },
                                text: 'Login Here')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
