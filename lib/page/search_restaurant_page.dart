import 'dart:async';

import 'package:dicoding_restaurant_app_sub2/component/theme.dart';
import 'package:dicoding_restaurant_app_sub2/data/model/restaurant_model.dart';
import 'package:dicoding_restaurant_app_sub2/data/response/restaurant_response.dart';
import 'package:dicoding_restaurant_app_sub2/provider/search_restaurant_provider.dart';
import 'package:dicoding_restaurant_app_sub2/utils/result.dart';
import 'package:dicoding_restaurant_app_sub2/widget/list_resturant.dart';
import 'package:dicoding_restaurant_app_sub2/widget/platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearch extends StatefulWidget {
  static const routeName = 'page_search';
  const RestaurantSearch({Key? key}) : super(key: key);

  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {

  Widget _buildList(){
    Timer? _debounce;
    return Scaffold(
      appBar: AppBar(title: Text('Search'), backgroundColor: secondaryColor,),
      body: Column(
        children: [
          Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  cursorColor: Colors.grey.shade600,

                  decoration: InputDecoration(
                         label: Text('Search restaurant'),
                         hintText: 'Input type name restaurant',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    prefixIcon: Icon(Icons.search,
                        size: 30.0, color: Colors.grey.shade600),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(30.0)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(30.0),),),
                  onChanged: (text){
                    if(_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      if(text.isNotEmpty){
                        SearchProvider provider = Provider.of(context, listen: false);
                        provider.fetchSearchRestaurant(text);
                      }
                    });
                  },
                ),
              )
          ),
          Flexible(
              flex: 1,
              child: Consumer<SearchProvider>(
                builder: (context, provider, _){
                  Result<RestaurantSearchResponse> state = provider.state;
                  switch (state.status){
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator(),);
                    case Status.error:
                      return Center(child: Padding(padding: const EdgeInsets.all(16),
                        child: Text(state.message!),
                      ),);
                    case Status.hasData: {
                      {
                        List<Restaurant> restaurants = state.data!.restaurant;
                        if(restaurants.isEmpty){
                          return const Center(
                            child: Text('The search result is empty'),
                          );
                        }else{
                          return ListRestaurant(restaurant: restaurants);
                        }
                      }
                    }
                  }
                },
              )
          )
        ],
      ),
    );
  }

  Widget _buildIos(BuildContext context){
    return Scaffold(
      body: _buildList(),
    );
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      body: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos
    );
  }
}
