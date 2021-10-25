
abstract class SocialRegisterCubitStates {}

class SocialRegisterCubitInitialState extends SocialRegisterCubitStates {}



class SocialRegisterCubitLoadingState extends SocialRegisterCubitStates {
}
class SocialRegisterCubitSuccessState extends SocialRegisterCubitStates {


}

class SocialRegisterCubitErrorState extends SocialRegisterCubitStates {
  final error;

  SocialRegisterCubitErrorState(this.error);
}
class SocialCreateUserCubitSuccessState extends SocialRegisterCubitStates {


}

class SocialCreateUserCubitErrorState extends SocialRegisterCubitStates {
  final error;

  SocialCreateUserCubitErrorState(this.error);
}


class SocialRegisterCubitVisibilityState extends SocialRegisterCubitStates {}
