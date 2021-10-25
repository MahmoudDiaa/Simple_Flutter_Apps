import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/models/social_app/post_model.dart';
import 'package:udemy_flutter/models/social_app/social_message_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/social_app/add_post/new_post_screen.dart';
import 'package:udemy_flutter/modules/social_app/chats/chats_screen.dart';
import 'package:udemy_flutter/modules/social_app/feeds/feeds_screen.dart';
import 'package:udemy_flutter/modules/social_app/settings/settings_screen.dart';
import 'package:udemy_flutter/modules/social_app/users/users_screen.dart';
import 'package:udemy_flutter/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialAppState> {
  SocialCubit() : super(SocialAppInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialAppGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialAppGetUserSuccessState());
    }).catchError((error) {
      emit(SocialAppGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> title = [
    'News Feed',
    'Chats',
    'New Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getAllUsers();
    if (index == 2)
      emit(SocialAppAddPostState());
    else {
      currentIndex = index;
      emit(SocialAppChangeBottomNavState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialAppProfileImagePickedSuccessState());
    } else {
      emit(SocialAppProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialAppCoverImagePickedSuccessState());
    } else
      emit(SocialAppCoverImagePickedErrorState());
  }

  String profileImageUrl = '';

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userModel!.image = value;
        emit(SocialAppProfileImageUploadedSuccessState());
      }).catchError((error) {
        emit(SocialAppProfileImageUploadedErrorState());
      });
      ;
    }).catchError((error) {
      emit(SocialAppProfileImageUploadedErrorState());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userModel!.cover = value;
        emit(SocialAppCoverImageUploadedSuccessState());
      }).catchError((error) {
        emit(SocialAppCoverImagePickedErrorState());
      });
    }).catchError((error) {
      emit(SocialAppCoverImagePickedErrorState());
    });
  }

  void updateUser(
      {required String name, required String bio, required String phone}) {
    emit(SocialAppUserUpdateLoadingState());
    if (coverImageUrl.isNotEmpty) {
      uploadCoverImage();
    }
    if (profileImageUrl.isNotEmpty) {
      uploadProfileImage();
    }

    SocialUserModel model = SocialUserModel(
      name: name,
      image: profileImageUrl.isNotEmpty ? profileImageUrl : userModel!.image,
      bio: bio,
      email: userModel!.email,
      isEmailVerified: userModel!.isEmailVerified,
      uId: userModel!.uId,
      phone: phone,
      cover: coverImageUrl.isNotEmpty ? coverImageUrl : userModel!.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialAppUserUpdateErrorState());
    });
  }

  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialAppPostImagePickedSuccessState());
    } else
      emit(SocialAppPostImagePickedErrorState());
  }

  void removePostImage() {
    postImage = null;
    emit(SocialAppPostImageRemovedState());
  }

  void uploadPostImage({
    required String text,
  }) {
    emit(SocialAppPostCreateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, postImage: value);
        emit(SocialAppPostImageUploadedSuccessState());
      }).catchError((error) {
        emit(SocialAppPostImageUploadedErrorState());
      });
    }).catchError((error) {
      emit(SocialAppPostImageUploadedErrorState());
    });
  }

  void createPost({
    required String text,
    String? postImage,
  }) {
    emit(SocialAppPostCreateLoadingState());
    var dateTime = DateTime.now();
    PostModel postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime.toString(),
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialAppPostCreateSuccessState());
    }).catchError((error) {
      emit(SocialAppPostCreateErrorState());
    });
  }

  List<PostModel>? postsList = [];
  List<String>? postsId = [];
  List<int>? likes = [];
  List<int>? commentsNo = [];

  void getPosts() {
    emit(SocialAppGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          commentsNo!.add(value.docs.length);
          emit(SocialAppCommentPostSuccessState());
        }).catchError((error) {
          emit(SocialAppCommentPostErrorState());
        });

        element.reference.collection('likes').get().then((value) {
          print(element.data());
          likes!.add(value.docs.length);
          postsId!.add(element.id);
          postsList!.add(PostModel.fromJson(element.data()));
          emit(SocialAppLikePostSuccessState());
        }).catchError((error) {
          print('get likes error ' + error.toString());
          emit(SocialAppGetPostsErrorState(error.toString()));
        });
      });
      print('emit success');
      emit(SocialAppGetPostsSuccessState());
    }).catchError((error) {
      print('get posts error ' + error.toString());
      emit(SocialAppGetPostsErrorState(error.toString()));
    });
  }

  void likePost({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialAppLikePostSuccessState());
    }).catchError((error) {
      emit(SocialAppLikePostErrorState());
    });
  }

  void commentsPost({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comments': true}).then((value) {
      emit(SocialAppCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialAppCommentPostErrorState());
    });
  }

  List<SocialUserModel> allUsers = [];

  void getAllUsers() {
    allUsers.clear();
    emit(SocialAppGetAllUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel!.uId)
          allUsers.add(SocialUserModel.fromJson(element.data()));
      });

      emit(SocialAppGetAllUserSuccessState());
    }).catchError((error) {
      print('get all users error ' + error.toString());
      emit(SocialAppGetAllUserErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
  }) {
    var datetime = DateTime.now();
    MessageModel model = MessageModel(
        text: text,
        dateTime: datetime.toString(),
        receiverId: receiverId,
        senderId: userModel!.uId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialAppSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialAppSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialAppSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialAppSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      print("event length${event.docs.length}");
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      print(messages.length);
      emit(SocialAppGetMessageSuccessState());
    }).onError((error) {
      emit(SocialAppGetMessageErrorState());
    });
  }
}
