import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/buisness/buisness_layout.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sport/sport_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isSearch = false;
  List<Widget> screens = [
    const BuisnessScreen(),
    const SportScreen(),
    const ScienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Buisness',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_baseball_rounded,
      ),
      label: 'Sport',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),
  ];

  void changeBottomBar(int index) {
    currentIndex = index;

    if (index == 1) getSport();
    if (index == 2) getScience();

    emit(AppChangeBottomNavBarState());
  }

  List<dynamic> buisness = [];

  void getBuissnes() {
    emit(NewsGetBuisnessLodingState());

    DioHelper.getData(url: 'v2/top-headlines/', query: {
      'country': 'ma',
      'category': 'business',
      'apiKey': '3434306e64be4fe29ed1aeacb3602964'
    }).then((value) {
      buisness = value.data['articles'];

      emit(NewsGetBuisnessSuccessState());
    }).catchError((error) {
      emit(NewsGetBuisnessErrorState(error.toString()));
    });
  }

  int selectedBuisnessItem = 0;
  void selectedBuisnesItem(index) {
    selectedBuisnessItem = index;
    emit(NewsSelectedBuisnessItemState());
  }

  List<dynamic> sport = [];

  void getSport() {
    emit(NewsGetSportLodingState());
    if (sport.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'fr',
        'category': 'sport',
        'apiKey': '3434306e64be4fe29ed1aeacb3602964'
      }).then((value) {
        sport = value.data['articles'];

        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        emit(NewsGetSportErrorState(error.toString()));
      });
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLodingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'fr',
        'category': 'science',
        'apiKey': '3434306e64be4fe29ed1aeacb3602964'
      }).then((value) {
        science = value.data['articles'];

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLodingState());

    DioHelper.getData(
            url: 'v2/everything',
            query: {'q': value, 'apiKey': '3434306e64be4fe29ed1aeacb3602964'})
        .then((value) {
      search = value.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
