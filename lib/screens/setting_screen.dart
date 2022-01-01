import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/components/style.dart';
import 'package:food_review/cubit/cubit.dart';
import 'package:food_review/cubit/state.dart';


class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit,RestaurantStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=RestaurantCubit.get(context);
      return  SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
          child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Dark Mode',style: TextStyles.kMediumTitle,),
                Switch(
                  activeColor: customBlue,
                  value: cubit.isDark,
                    onChanged: (value){
                  cubit.isDark =value;
                  cubit.appChangeMood(value);
                },

                ),

              ],)
            ],),
        ),
      );
      },

    );
  }
}
