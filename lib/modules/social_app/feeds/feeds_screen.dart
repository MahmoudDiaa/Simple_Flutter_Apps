import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/models/social_app/post_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          builder: (BuildContext context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://image.freepik.com/free-photo/happy-curly-haired-african-american-woman-laughs-positively-points-aside-copy-space-wears-black-t-shirt_273609-38585.jpg',
                        ),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  itemBuilder: (context, index) => buildPostItem(
                      context: context,
                      userModel: cubit.userModel!,
                      postModel: cubit.postsList![index],
                      cubit: cubit,
                      index: index),
                  itemCount: cubit.postsList!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 10,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          condition: cubit.postsList != null && cubit.postsList!.isNotEmpty,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(
          {required context,
          required SocialUserModel userModel,
          required PostModel postModel,
          required SocialCubit cubit,
          required int index}) =>
      Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(postModel.image!),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            postModel.name!,
                            style: TextStyle(height: 1.4),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          )
                        ],
                      ),
                      Text(
                        postModel.dateTime!,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16.0,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: divider(padding: EdgeInsets.zero),
              ),
              Text(
                postModel.text!,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6),
                        child: Container(
                          child: MaterialButton(
                            height: 20.0,
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#software',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                            ),
                          ),
                          height: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6),
                        child: Container(
                          child: MaterialButton(
                            height: 20.0,
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                            ),
                          ),
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (postModel.postImage!.trim() != '' &&
                  postModel.postImage!.isNotEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                            image: NetworkImage(
                              postModel.postImage!,
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Heart,
                                  size: 16,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${cubit.likes![index]}',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${cubit.commentsNo![index]} comment',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        cubit.commentsPost(postId: cubit.postsId![index]);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(userModel.image!),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('write a comment ...',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {
                      cubit.likePost(postId: cubit.postsId![index]);
                    },
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.ios_share,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Share',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
