
import 'package:dicoding_restaurant_app_sub2/component/navigation.dart';
import 'package:dicoding_restaurant_app_sub2/data/model/restaurant_model.dart';
import 'package:dicoding_restaurant_app_sub2/page/detail_restaurant_page.dart';
import 'package:flutter/material.dart';

class Resto extends StatefulWidget {
  final List<Restaurant> restaurant;
  const Resto({Key? key, required this.restaurant}) : super(key: key);

  @override
  _Resto createState() => _Resto();
}

class _Resto extends State<Resto> {

  Widget _listitem(BuildContext context , Restaurant resto){
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Hero(
        tag: resto.id,
        child: Image.network(resto.mediumPictureUrl),
      ),
      onTap: () => {
        Navigation.intentWithData(DetailRestaurantPage.routeName, resto.id),
      },
      title: Text(resto.name, overflow: TextOverflow.ellipsis,),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(resto.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
            ],
          ),
          Row(
            children: [
              Text(resto.city)
            ],
          ),
          Row(
            children: [
              Text(resto.rating.toString()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.restaurant.length,
      separatorBuilder: (context, index){
        return const Divider(height: 2, color: Color(0xff6c5ecf),);
      },
      itemBuilder: (context, index){
        Restaurant restaurant = widget.restaurant[index];
        return _listitem(context, restaurant);
      },
    );
  }
}
