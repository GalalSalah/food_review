import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/components/component.dart';
import 'package:food_review/cubit/cubit.dart';
import 'package:food_review/cubit/state.dart';
import 'package:food_review/model/all_restaurant_data.dart';

class Search extends SearchDelegate {
  var suggestSearch;
  var resultSearch;

  Search({this.suggestSearch, this.resultSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider<RestaurantCubit>(
      create: (context) => RestaurantCubit()..getSearch(query),
      child: BlocConsumer<RestaurantCubit, RestaurantStates>(
        listener: (context, state) {},
        builder: (context, state) {
          resultSearch = RestaurantCubit.get(context);

          return
           state is GetSearchRestaurantLoadingState
              ? const Center(child: CircularProgressIndicator())
              :
          ListView.separated(
                  itemBuilder: (context, index) {
                    return buildRestaurantCard(resultSearch.searchRestaurant.items[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: resultSearch.searchRestaurant.items.length);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return Container(
    //   child: Center(
    //     child: Text('Search for your favourite Restaurant'),
    //   ),
    // );
    return BlocConsumer<RestaurantCubit, RestaurantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var getSearch = RestaurantCubit.get(context).searchRestaurant.where((e) => e.getSearch(query).toLowerCase().startsWith(query));
         suggestSearch = RestaurantCubit.get(context);
        // var suggesttionSearch =
        //     query.isEmpty ? suggestSearch.restaurantModel.items : getSearch;
        return ListView.separated(
            itemBuilder: (context, index) {
              return buildRestaurantCard(suggestSearch.restaurantModel.items[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount:suggestSearch.restaurantModel.items.length);
      },
    );

  }
}
