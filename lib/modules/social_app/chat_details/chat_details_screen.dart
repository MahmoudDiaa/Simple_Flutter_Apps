import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/models/social_app/social_message_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/style/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel receiverModel;
  final textController = TextEditingController();

  ChatDetailsScreen({required this.receiverModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var cubit = SocialCubit.get(context);
        cubit.getMessages(receiverId: receiverModel.uId!);
        return BlocConsumer<SocialCubit, SocialAppState>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, Object? state) {
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(receiverModel.image!),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(receiverModel.name!)
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: cubit.messages.isNotEmpty,
                  builder: (BuildContext context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message = cubit.messages[index];

                                if (cubit.userModel!.uId == message.senderId) {
                                  return buildSenderMessage(message);
                                }
                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10,
                                  ),
                              itemCount: cubit.messages.length),
                        ),
                        Spacer(),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[300]!,
                              )),


                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    controller: textController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'type your message here ....'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: defaultColor,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: () {
                                    cubit.sendMessage(
                                        receiverId: receiverModel.uId!,
                                        text: textController.text);
                                    textController.clear();
                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
              );
            });
      },
    );
  }

  Widget buildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10))),
            child: Text(message.text!)),
      );
}

Widget buildSenderMessage(MessageModel message) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.4),
              borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10))),
          child: Text(message.text!)),
    );
