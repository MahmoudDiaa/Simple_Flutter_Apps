import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/add_post/new_post_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/style/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppState>(
      listener: (BuildContext context, state) {
        if (state is SocialAppAddPostState)
          navigateTo(context, NewPostScreen());
      },
      builder: (BuildContext context, Object? state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Location'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Setting')
            ],
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
//fire base verification with email
// if (!FirebaseAuth.instance.currentUser!.emailVerified)
//   Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     color: Colors.grey.withOpacity(0.4),
//     height: 50,
//     child: Row(
//       children: [
//         Icon(
//           Icons.info_outline,
//         ),
//         SizedBox(
//           width: 15,
//         ),
//         Expanded(child: Text('please verify your email')),
//         defaultTextButton(
//           text: 'send',
//           onPress: () {
//             FirebaseAuth.instance.currentUser!
//                 .sendEmailVerification().then((value) {
//                   showToast(message: 'check your email', states: ToastStates.SUCCESS);
//             }).catchError((error){
//
//             });
//           },
//         ),
//       ],
//     ),
//   )
