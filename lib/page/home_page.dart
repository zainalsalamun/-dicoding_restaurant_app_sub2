import 'package:dicoding_restaurant_app_sub2/component/theme.dart';
import 'package:dicoding_restaurant_app_sub2/data/model/restaurant_model.dart';
import 'package:dicoding_restaurant_app_sub2/data/response/restaurant_response.dart';
import 'package:dicoding_restaurant_app_sub2/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app_sub2/page/search_restaurant_page.dart';
import 'package:dicoding_restaurant_app_sub2/utils/result.dart';
import 'package:dicoding_restaurant_app_sub2/widget/list_resturant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/restaurants';
  static const routeNameHome = '/home_page';


  @override
  Widget build(BuildContext context) {
    Widget bottomNavBar() {
      return BottomNavigationBar(
        elevation: 20,
        backgroundColor: whiteColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_home.png',
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_notification.png',
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_love.png',
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_user.png',
              width: 24,
            ),
            label: '',
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text('Restaurant',),
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.only(
              left: 14.0,
              bottom: 12.0,
            ),

            alignment: Alignment.centerLeft,
            child: Text(
              'Recommended restaurant for you!',
              style: myTextTheme.subtitle2!.copyWith(
                color: whiteColor,
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(10.0),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RestaurantSearch.routeName,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: bottomNavBar(),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, _) {
          Result<RestaurantListResponse> state = provider.state;
          switch (state.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    16.0,
                  ),
                  child: Text(
                    state.message!,
                  ),
                ),
              );
            case Status.hasData:
              {
                List<Restaurant> restaurants = state.data!.restaurants;
                if (restaurants.isEmpty) {
                  return const Center(
                    child: Text('Restaurant is empty.'),
                  );
                } else {
                  return ListRestaurant(restaurant: restaurants,
                  );
                }
              }
          }
        },
      ),
    );
  }
}
