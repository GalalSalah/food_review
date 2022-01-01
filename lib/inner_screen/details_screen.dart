import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/apis/url_apis.dart';
import 'package:food_review/components/component.dart';
import 'package:food_review/components/style.dart';
import 'package:food_review/cubit/cubit.dart';
import 'package:food_review/cubit/state.dart';
import 'package:food_review/model/all_restaurant_data.dart';

class DetailsScreen extends StatelessWidget {
  // final String item;
  //
  // const DetailsScreen({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit, RestaurantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitDetails = RestaurantCubit.get(context);
        return Scaffold(
          body: cubitDetails.restaurantDetails == null||state is GetDetailsRestaurantLoadingState
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios)),
                             Text(
                              'Details',
                              style: TextStyles.kHeading1,
                            ),
                            IconButton(
                                onPressed: () {
                                  cubitDetails.insertToDatabase(cubitDetails.restaurantDetails.item);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                        Container(
                          margin:
                              const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 32.0),

                          // width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              image: NetworkImage(Urls.largeRestaurantImage(
                                  cubitDetails
                                      .restaurantDetails.item.pictureId)),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(cubitDetails.restaurantDetails.item.name,style: TextStyles.kHeading2,),
                        const SizedBox(
                          height: 15,
                        ),
                        locationAndRate('${cubitDetails.restaurantDetails.item.rating}', '${cubitDetails.restaurantDetails.item.city}'),
                        const SizedBox(
                          height: 15,
                        ),
                         Text(
                          '${cubitDetails.restaurantDetails.item.description}',
                          style: TextStyles.kRegularBody,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                         Text(
                          'Food Menu: ',
                          style: TextStyles.kMediumTitle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => buildCardFoodMenu(cubitDetails.restaurantDetails.item,index),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 10,
                                  ),
                              itemCount: cubitDetails.restaurantDetails.item.menus.foods.length),
                        ),
                        const SizedBox(height: 20,),
                         Text(
                          'Drink Menu: ',
                           style: TextStyles.kMediumTitle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => buildCardDrinkMenu(cubitDetails.restaurantDetails.item,index),
                              separatorBuilder: (context, index) =>
                              const SizedBox(
                                width: 10,
                              ),
                              itemCount: cubitDetails.restaurantDetails.item.menus.drinks.length),
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget buildCardFoodMenu(Item item,int index) {
    return Card(
        color: grey.withOpacity(.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.menus.foods[index].name,
            style: TextStyles.kRegularTitle,
          ),
        ));
  }
  Widget buildCardDrinkMenu(Item item,int index) {
    return Card(
        color: grey.withOpacity(.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.menus.drinks[index].name,
            style: TextStyles.kRegularTitle,
          ),
        ));
  }
}
