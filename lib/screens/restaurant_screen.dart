import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/components/component.dart';
import 'package:food_review/components/search_delegate.dart';
import 'package:food_review/components/style.dart';
import 'package:food_review/cubit/cubit.dart';
import 'package:food_review/cubit/state.dart';
import 'package:food_review/inner_screen/add_review.dart';
import 'package:food_review/inner_screen/details_screen.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit, RestaurantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RestaurantCubit.get(context);
        return cubit.restaurantModel == null
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Food Review',
                                style: TextStyles.kHeading1,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddReview()));
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showSearch(
                                            context: context,
                                            delegate: Search(
                                                resultSearch:
                                                    cubit.searchRestaurant,
                                                suggestSearch:
                                                    cubit.restaurantModel));
                                      },
                                      icon: const Icon(Icons.search)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text('Here you can know all good Restaurant',
                              style: TextStyles.kMediumTitle),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsScreen()));
                                    cubit.getRestaurantDetails(
                                        cubit.restaurantModel.items[index].id);
                                  },
                                  child: buildRestaurantCard(
                                      cubit.restaurantModel.items[index]));
                            },
                            itemCount: cubit.restaurantModel.items.length,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
