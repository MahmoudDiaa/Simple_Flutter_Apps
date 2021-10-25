abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState {}

class SocialLoginSuccessState extends SocialLoginState {

  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginLoadingState extends SocialLoginState {}

class SocialLoginErrorState extends SocialLoginState {
  final error;

  SocialLoginErrorState(this.error);
}

class SocialLoginVisibilityState extends SocialLoginState {}
