import 'package:flutter/material.dart';
import 'package:food_review/apis/url_apis.dart';
import 'package:food_review/components/style.dart';

Widget containerComponent(Color color, IconData icon) => Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(7),
            topLeft: Radius.circular(7),
            bottomLeft: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
      ),
      child: Icon(
        icon,
        size: 20,
        color: Colors.white,
      ),
      width: 28,
      height: 28,
    );

Widget locationAndRate(String rate, String location) {
  return Row(
    children: [
      Expanded(
        child: Row(
          children: [
            containerComponent(customYellow, Icons.star),
            const SizedBox(
              width: 15,
            ),
            Text(
              rate,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            containerComponent(customBlue, Icons.location_on),
            const SizedBox(
              width: 15,
            ),
            Text(
              location,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    ],
  );
}

Widget buildRestaurantCard(item) {
  return Card(
    elevation: 20,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FittedBox(
                  child: Image(
                    image: NetworkImage(
                        Urls.largeRestaurantImage(item.pictureId)
                        // 'https://restaurant-api.dicoding.dev/images/small/${item.pictureId}',
                        ),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.name}',
                      style: TextStyles.kHeading2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${item.description}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.kRegularBody,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              thickness: 2,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          locationAndRate('${item.rating.toString()}', '${item.city}'),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ),
  );
}
