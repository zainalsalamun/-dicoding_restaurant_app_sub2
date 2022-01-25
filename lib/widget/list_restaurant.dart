import 'package:dicoding_restaurant_app_sub2/component/navigation.dart';
import 'package:dicoding_restaurant_app_sub2/data/model/restaurant_model.dart';
import 'package:dicoding_restaurant_app_sub2/page/detail_restaurant_page.dart';
import 'package:flutter/material.dart';


class ListRestaurant extends StatefulWidget {
  final Restaurant restaurant;

  const ListRestaurant({required this.restaurant});

  @override
  _ListRestaurantState createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {

  @override
  Widget build(BuildContext context) {

    return Material(
        child: ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: widget.restaurant.pictureId,
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/small/' +
              widget.restaurant.pictureId,
          width: 100,
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                widget.restaurant.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(widget.restaurant.city),
            ],
          ),
          Row(
            children: [
              Text(widget.restaurant.rating.toString()),
            ],
          ),
        ],
      ),
          onTap: () => {
            Navigation.intentWithData(DetailRestaurantPage.routeName, widget.restaurant.id),
          },
    ));
  }
}
