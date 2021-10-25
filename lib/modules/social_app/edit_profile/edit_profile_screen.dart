import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/style/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var cubit = SocialCubit.get(context);
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: defaultTextButton(
                  onPress: () {
                    cubit.updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text);
                  },
                  text: 'update'),
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state is SocialAppUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(userModel.cover!)
                                                as ImageProvider
                                            : FileImage(coverImage),
                                        fit: BoxFit.cover)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16,
                                      )))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                                radius: 65,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(userModel.image!)
                                          as ImageProvider
                                      : FileImage(profileImage),
                                )),
                            IconButton(
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                                icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      if(cubit.profileImageUrl.isNotEmpty)
                      Expanded(
                          child: defaultButton(
                              function: () {},
                              text: 'upload profile',
                              background: Colors.red)),
                      SizedBox(width: 5,),
                      if(cubit.coverImageUrl.isNotEmpty)
                      Expanded(
                          child: defaultButton(
                              function: () {},
                              text: 'upload cover ',
                              background: Colors.red)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    label: 'Name',
                    prefix: IconBroken.User,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Name must not empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    textInputType: TextInputType.name,
                    label: 'Bio',
                    prefix: IconBroken.Info_Square,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Name must not empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    label: 'Phone',
                    prefix: IconBroken.Info_Square,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Name must not empty';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
