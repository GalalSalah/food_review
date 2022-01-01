import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/apis/cash_helper.dart';
import 'package:food_review/apis/dio.dart';
import 'package:food_review/apis/url_apis.dart';

import 'package:food_review/cubit/state.dart';
import 'package:food_review/model/all_restaurant_data.dart';
import 'package:food_review/screens/favourites_screen.dart';
import 'package:food_review/screens/restaurant_screen.dart';
import 'package:food_review/screens/setting_screen.dart';
import 'package:sqflite/sqflite.dart';

class RestaurantCubit extends Cubit<RestaurantStates> {
  RestaurantCubit() : super(InitialState());

  static RestaurantCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    RestaurantScreen(),
    FavouritesScreen(),
    SettingScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  Restaurants restaurantModel;

  void getRestaurantData() {
    emit(GetRestaurantLoadingState());
    DioHelpers.getData(url: '/list').then((value) {
      restaurantModel = Restaurants.fromMap(value.data);
      emit(GetRestaurantSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetRestaurantErrorState(error.toString()));
    });
  }

  Restaurant restaurantDetails;

  void getRestaurantDetails(String id) {
    emit(GetDetailsRestaurantLoadingState());
    DioHelpers.getData(url: '/detail/$id').then((value) {
      restaurantDetails = Restaurant.fromMap(value.data);
      emit(GetDetailsRestaurantSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDetailsRestaurantErrorState(error.toString()));
    });
  }

  Restaurants searchRestaurant;

  getSearch(String search) {
    emit(GetSearchRestaurantLoadingState());
    DioHelpers.getData(url: '/search', query: {
      'q': '$search',
    }).then((value) {
      searchRestaurant = Restaurants.fromSearchMap(value.data);
      print(value.data);
      emit(GetSearchRestaurantSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchRestaurantErrorState(error.toString()));
    });
  }

  Database database;
  String tableName = 'favourite';

  void createDatabase() {
    openDatabase(
      'favourite_restaurant.db',
      version: 1,
      onCreate: (database, version) {
        print('create Database');
        database
            .execute(
                'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name Text, description TEXT, pictureId TEXT, city TEXT, rating DOUBLE)')
            .then((value) {
          print('table create');
        }).catchError(
          (error) {
            print('error when created table ${error.toString()}');
          },
        );
      },
      onOpen: (database) {
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(RestaurantCreateDatabaseState());
    });
  }

  Future<void> insertToDatabase(Item restaurant) async {
    await database
        .insert(
            '$tableName (name) VALUES (${restaurant.name})', restaurant.toMap())
        .then((value) {
      // print('$value insert successfully');
      emit(RestaurantInsertToDatabaseSuccessfullyState());
    }).catchError((error) {
      print(error.toString());
      emit(RestaurantInsertToDatabaseErrorState(error.toString()));
      print("${error.toString()}");
    });
  }

  CustomerReview customerReview;

  reviewRestaurant(String id, String name, String review) {
    emit(GetReviewRestaurantSuccessState());
    DioHelpers.reviewById(id: id, name: name, review: review).then((value) {
      customerReview = CustomerReview.fromMap(value.data());
      print(value.data);
      emit(GetReviewRestaurantSuccessState());
    }).catchError((error) {
      emit(GetReviewRestaurantErrorState(error.toString()));
      print(error.toString());
    });
  }

  ThemeMode appMode = ThemeMode.dark;
  bool isDark = false;

  void appChangeMood(bool fromShared) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CashHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
