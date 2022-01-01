import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/apis/cash_helper.dart';
import 'package:food_review/apis/dio.dart';
import 'package:food_review/components/style.dart';
import 'package:food_review/cubit/cubit.dart';
import 'package:food_review/cubit/state.dart';
import 'package:food_review/screens/main_screen.dart';
import 'package:bloc/bloc.dart';
import 'bloc_observe.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer =MyBlocObserver();
  DioHelpers.init();
  await CashHelper.init();
  bool isDark=CashHelper.getData(key: 'isDark');
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RestaurantCubit()..getRestaurantData()..createDatabase()..appChangeMood(isDark),
      child: BlocConsumer<RestaurantCubit,RestaurantStates>(
        listener: (context,state){},
        builder: (context,state){
         return MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: RestaurantCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:  MainScreen(),
          );
        },
      ),
    );
  }
}

