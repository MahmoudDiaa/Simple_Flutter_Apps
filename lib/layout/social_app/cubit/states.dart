abstract class SocialAppState {}

class SocialAppInitialState extends SocialAppState {}

class SocialAppGetUserLoadingState extends SocialAppState {}

class SocialAppGetUserSuccessState extends SocialAppState {}

class SocialAppGetUserErrorState extends SocialAppState {
  final String error;

  SocialAppGetUserErrorState(this.error);
}
//get All users
class SocialAppGetAllUserLoadingState extends SocialAppState {}

class SocialAppGetAllUserSuccessState extends SocialAppState {}

class SocialAppGetAllUserErrorState extends SocialAppState {
  final String error;

  SocialAppGetAllUserErrorState(this.error);
}

class SocialAppChangeBottomNavState extends SocialAppState {}

class SocialAppAddPostState extends SocialAppState {}

/*
*pick profile image
*  */
class SocialAppProfileImagePickedSuccessState extends SocialAppState {}

class SocialAppProfileImagePickedErrorState extends SocialAppState {}

//upload profile image
class SocialAppProfileImageUploadedSuccessState extends SocialAppState {}

class SocialAppProfileImageUploadedErrorState extends SocialAppState {}

//pick cover image
class SocialAppCoverImagePickedSuccessState extends SocialAppState {}

class SocialAppCoverImagePickedErrorState extends SocialAppState {}

//cover image upload
class SocialAppCoverImageUploadedSuccessState extends SocialAppState {}

class SocialAppCoverImageUploadedErrorState extends SocialAppState {}

//user update
class SocialAppUserUpdateErrorState extends SocialAppState {}

class SocialAppUserUpdateLoadingState extends SocialAppState {}

//create post
class SocialAppPostCreateErrorState extends SocialAppState {}

class SocialAppPostCreateLoadingState extends SocialAppState {}

class SocialAppPostCreateSuccessState extends SocialAppState {}

// post image pick
class SocialAppPostImagePickedSuccessState extends SocialAppState {}

class SocialAppPostImageRemovedState extends SocialAppState {}

class SocialAppPostImagePickedErrorState extends SocialAppState {}

//upload post image
class SocialAppPostImageUploadedSuccessState extends SocialAppState {}

class SocialAppPostImageUploadedErrorState extends SocialAppState {}

//get posts
class SocialAppGetPostsLoadingState extends SocialAppState {}

class SocialAppGetPostsSuccessState extends SocialAppState {}

class SocialAppGetPostsErrorState extends SocialAppState {
  final String error;

  SocialAppGetPostsErrorState(this.error);
}

class SocialAppLikePostErrorState extends SocialAppState {}


class SocialAppLikePostSuccessState extends SocialAppState {}


class SocialAppCommentPostErrorState extends SocialAppState {}


class SocialAppCommentPostSuccessState extends SocialAppState {}

//chat

class SocialAppSendMessageErrorState extends SocialAppState {}
class SocialAppSendMessageSuccessState extends SocialAppState {}

class SocialAppGetMessageErrorState extends SocialAppState {}
class SocialAppGetMessageSuccessState extends SocialAppState {}

