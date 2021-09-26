import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/newsapp/business_screen.dart';
import 'package:newsapp/newsapp/science_screen.dart';
import 'package:newsapp/newsapp/sports_screen.dart';
import 'package:newsapp/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),

  ];

  List<Widget>screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index){
    currentIndex = index ;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'371b84bdf88e4ec4a8f1ab696483393f',
        }
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }

  List<dynamic> sports = [];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'371b84bdf88e4ec4a8f1ab696483393f',
        }
    ).then((value) {
      sports = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error));
    });
  }

  List<dynamic> science = [];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'371b84bdf88e4ec4a8f1ab696483393f',
        }
    ).then((value) {
      science = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error));
    });
  }


  List<dynamic> search = [];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
        url:'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'371b84bdf88e4ec4a8f1ab696483393f',
        }
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });
  }


}
