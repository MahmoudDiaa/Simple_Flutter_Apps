

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/modules/social_app/social_login/social_login_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/style/themes.dart';

import 'layout/news_app/cubit/cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print('on messaging background ${message.data}');
  showToast(
      message: 'on messaging background ${message}',
      states: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // set min width and height app

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  var token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    showToast(message: 'on messaging', states: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(message: 'on messaging OpenedApp', states: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print('firebase messaging token : $token');

  bool? isDark = CacheHelper.getData(key: 'isDark');
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');

  Widget widget;
  // if (onBoarding != null) {
  //   if (token!=null)
  //     widget = ShopLayout();
  //   else
  //     widget = ShopLoginScreen();
  // } else
  //   widget = OnBoardingScreen();
  if (uId != null && uId.isNotEmpty) {
    widget = SocialLayout();
  } else
    widget = SocialLoginScreen();

  runApp(MyApp(
    isDark: isDark ?? false,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget widget;

  MyApp({required this.isDark, required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()..getBusiness()),
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            themeMode:
                // isDark ? ThemeMode.dark :
                ThemeMode.light,
            darkTheme: darkTheme,
            home: widget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
