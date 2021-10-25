import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/social_app/social_register/cubit/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterCubitStates> {
  SocialRegisterCubit() : super(SocialRegisterCubitInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // SocialLoginModel? loginModel;
  //
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(SocialRegisterCubitLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(email: email, phone: phone, name: name, uId: value.user!.uid);
    }).catchError((error) {
      emit(SocialRegisterCubitErrorState(error));
    });
  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(name:name, email: email,phone:  phone,uId:  uId,isEmailVerified:  false,
        image: 'https://image.freepik.com/free-photo/horizontal-shot-surprised-young-european-woman-with-natural-curly-hair-reacts-something-has-wondered-expression-dressed-casual-black-t-shirt-isolated-yellow-wall_273609-49400.jpg'
    ,bio: 'write your bio ...');

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserCubitSuccessState());
    }).catchError((error) {
      SocialCreateUserCubitErrorState(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = false;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialRegisterCubitVisibilityState());
  }
}
