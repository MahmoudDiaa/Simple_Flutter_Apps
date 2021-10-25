import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/shopLayout.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/state.dart';
import 'package:udemy_flutter/modules/shop_app/register/shop_register_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var emailController = TextEditingController();
    var passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
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
          builder: (context, state) {
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
                          'LOGIN',
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
                          'social_login now to browse our hot offers',
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
                          height: 15,
                        ),
                        defaultTextFormField(
                            controller: passController,
                            onPressSuffix: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            textInputType: TextInputType.visiblePassword,
                            label: "Password",
                            obscure:
                                ShopLoginCubit.get(context).isPasswordShown,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text);
                              }
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your password';
                              } else
                                return null;
                            },
                            prefix: Icons.lock_outline,
                            suffixIcon: ShopLoginCubit.get(context).suffix),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text);
                              }
                            },
                            text: 'social_login',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('don\'t have an account ?'),
                            defaultTextButton(
                                onPress: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'Register Here')
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
