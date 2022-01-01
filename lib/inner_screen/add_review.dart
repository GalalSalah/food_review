import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_review/components/style.dart';
import 'package:food_review/cubit/cubit.dart';
import 'package:food_review/cubit/state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReview extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit, RestaurantStates>(
      listener: (context, state) {
        if (state is GetReviewRestaurantSuccessState) {
          Fluttertoast.showToast(msg: 'Your Review Send Successfully'
              ,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is GetReviewRestaurantErrorState) {
          Fluttertoast.showToast(msg: state.error.toString()
              ,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        var cubitReview = RestaurantCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon:const Icon(Icons.arrow_back) ),
                         Text('Review',
                            style: TextStyles.kHeading1),
                        IconButton(onPressed: () {
                          if(formKey.currentState.validate()){
                            cubitReview.reviewRestaurant(
                                '1', nameController.text, reviewController.text);
                          }

                        }, icon: const Icon(Icons.send_outlined,

                        ),
                        ),
                      ],
                    ),
                  const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please write your name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('your name')),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: reviewController,
                    maxLines: 5,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please write your review';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                label: Text('your review'),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ],
          ),
        ),)
        ,
        )
        ,
        );
      },

    );
  }
}
