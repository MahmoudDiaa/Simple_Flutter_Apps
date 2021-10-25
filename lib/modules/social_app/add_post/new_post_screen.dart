import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/style/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            defaultTextButton(
              onPress: () {
                if (cubit.postImage != null)
                  cubit.uploadPostImage(text: textController.text);
                else
                  cubit.createPost(text: textController.text);
              },
              text: 'Post',
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialAppPostCreateLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialAppPostCreateLoadingState)
                  SizedBox(
                    height: 5,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/woman-with-curly-hair-looks-with-flirty-expression-camera-keeps-lips-folded-listens-music-via-headphones-enjoys-spare-time-dressed-casual-t-shirt-poses_273609-51357.jpg'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mahmoud Diaa',
                              style: TextStyle(height: 1.4),
                            ),
                            Text(
                              'public',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText:
                            'what is on your mind...${cubit.userModel!.name}',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: FileImage(cubit.postImage!),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                          onPressed: () {
                          cubit.removePostImage();
                          },
                          icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.close,
                                size: 16,

                              )))
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child:
                          TextButton(onPressed: () {}, child: Text('# tags')),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
