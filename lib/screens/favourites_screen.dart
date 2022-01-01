import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/components/component.dart';
import 'package:food_review/components/style.dart';
import 'package:food_review/cubit/cubit.dart';
import 'package:food_review/cubit/state.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit, RestaurantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RestaurantCubit.get(context).restaurantModel;
        return cubit==null?const Center(child: CircularProgressIndicator()): SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Favourite',
                      style: TextStyles.kHeading1,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                ListView.separated(
                  shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildRestaurantCard(cubit.items[index]);
                    },
                    separatorBuilder: ((context, index) => const SizedBox(
                          height: 10,
                        )),
                    itemCount: 2)
              ],
            ),
          ),
        );
      },
    );
  }
}
