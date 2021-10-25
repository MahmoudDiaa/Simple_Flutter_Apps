import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/modules/shop_app/register/cubit/state.dart';
import 'package:udemy_flutter/shared/network/end_points.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterCubitStates> {
  ShopRegisterCubit() : super(ShopRegisterCubitInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(ShopRegisterCubitLoadingState());
    DioHelper.postData(path: REGISTER, data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
    }).then((value) {

      loginModel = ShopLoginModel.formJson(value.data);
      emit(ShopRegisterCubitSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterCubitErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = false;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopRegisterCubitVisibilityState());
  }
}
