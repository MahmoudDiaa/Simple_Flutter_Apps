import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = SocialCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.allUsers.isNotEmpty,
            builder: (BuildContext context) => ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => chatItem(userModel: cubit.allUsers[index],context: context),
                separatorBuilder: (context, index) => divider(),
                itemCount: cubit.allUsers.length),
             fallback:(context) =>  Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget chatItem({required SocialUserModel userModel,required BuildContext context}) => InkWell(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(userModel.image!),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                userModel.name!,
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
    ),
    onTap: (){

      navigateTo(context, ChatDetailsScreen(receiverModel: userModel));
    },
  );
}
