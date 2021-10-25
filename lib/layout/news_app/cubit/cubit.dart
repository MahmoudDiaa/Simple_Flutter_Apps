import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/modules/news_app/business/business_screen.dart';
import 'package:udemy_flutter/modules/news_app/science/science_screen.dart';
import 'package:udemy_flutter/modules/news_app/sports/sport_screen.dart';
import 'package:udemy_flutter/modules/settings_screen/settings_screen.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewInitialState());

  //variables
  // bottom  nav index
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_rounded), label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_rounded), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sport'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportScreen(),
    SettingsScreen()
  ];

  List<dynamic> science = [];

  List<dynamic> sport = [];
  List<dynamic> searchResult = [];
  bool isDark = false;

  //shared  cubit
  static NewsCubit get(context) => BlocProvider.of(context);

  //methods

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 2)
      getSport();
    else if (index == 1) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  // List<bool> businessSelectedItem = [];
int? selectedItemIndex;
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '888b49a4699c46408060403005857261',
      }).then((value) {
        print('data ${value.data['articles']}');
        business = value.data['articles'];
        // business.forEach((element) {
          // businessSelectedItem.add(false);
        // });
        print(business);

        print(' business $business.length');
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print('error $error');
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  void selectBusinessItem(index) {
    selectedItemIndex=index;
    // for (int i = 0; i < businessSelectedItem.length; i++) {
    //   if (i == index)
    //     businessSelectedItem[i] = true;
    //   else
    //     businessSelectedItem[i] = false;
    // }


    emit(NewsGetSelectBusinessState());
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '888b49a4699c46408060403005857261',
      }).then((value) {
        science = value.data['articles'];
        print(science);

        print(' Science $science.length');
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print('error $error');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSport() {
    emit(NewsGetSportsLoadingState());
    if (sport.isEmpty) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '888b49a4699c46408060403005857261',
      }).then((value) {
        sport = value.data['articles'];
        print(sport);

        print(' Sports $sport.length');
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print('error $error');
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getSearchResult(value) {
    searchResult = [];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(path: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '888b49a4699c46408060403005857261'
    }).then((value) {
      searchResult = value.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error));
    });
  }
}
