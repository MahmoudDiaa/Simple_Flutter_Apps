import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/modules/social_app/social_login/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/social_login/cubit/state.dart';
import 'package:udemy_flutter/modules/social_app/social_register/social_register_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var emailController = TextEditingController();
    var passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
          listener: (context, state) {
            if (state is SocialLoginErrorState) {
              // if (state.loginModel.status!) {

              // } else {
              showToast(message: state.error, states: ToastStates.ERROR);
              // }
            }

            if (state is SocialLoginSuccessState) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                uId = state.uId;
                navigateAndFinish(context, SocialLayout());
              });
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
                          'login now to communicate with new friends .',
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
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            textInputType: TextInputType.visiblePassword,
                            label: "Password",
                            obscure:
                                SocialLoginCubit.get(context).isPasswordShown,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
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
                            suffixIcon: SocialLoginCubit.get(context).suffix),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text);
                              }
                            },
                            text: 'login',
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
                                  navigateTo(context, SocialRegisterScreen());
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
