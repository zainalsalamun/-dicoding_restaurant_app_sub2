import 'package:dicoding_restaurant_app_sub2/component/theme.dart';
import 'package:dicoding_restaurant_app_sub2/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app_sub2/page/search_restaurant_page.dart';
import 'package:dicoding_restaurant_app_sub2/widget/list_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/restaurants';
  static const routeNameHome = '/home_page';


  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();
    String nameResto = 'namaRestaurant';

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
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            return Container(

                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    width: 1,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    width: 1,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.result.restaurants.length,
                                  itemBuilder: (context, index) {
                                    var restaurant =
                                    state.result.restaurants[index];
                                    return ListRestaurant(restaurant: restaurant);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

          } else if (state.state == ResultState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.Error) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
