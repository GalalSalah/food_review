import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/components/style.dart';
import 'package:food_review/cubit/cubit.dart';
import 'package:food_review/cubit/state.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit,RestaurantStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=RestaurantCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            selectedItemColor: customBlue,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.view_agenda),label: 'Restaurant'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourite'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
            ],
          ),
        );
      },

    );
  }
}
