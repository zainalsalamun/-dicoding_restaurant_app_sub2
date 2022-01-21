import 'package:dicoding_restaurant_app_sub2/component/theme.dart';
import 'package:dicoding_restaurant_app_sub2/data/model/restaurant_model.dart';
import 'package:dicoding_restaurant_app_sub2/data/response/restaurant_response.dart';
import 'package:dicoding_restaurant_app_sub2/provider/restaurant_detail_provider.dart';
import 'package:dicoding_restaurant_app_sub2/utils/result.dart';
import 'package:dicoding_restaurant_app_sub2/widget/platform_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String restaurant;
  const DetailRestaurantPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {

  @override
  void initState() {
    Future.microtask(() {
      RestaurantDetailProvider provider = Provider.of<RestaurantDetailProvider>(
        context,
        listen: false,
      );
      provider.getDetails(widget.restaurant);
    });
    super.initState();
  }


  Widget _buildDetails(BuildContext context){
    return Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, _) {
            Result<RestaurantDetailResponse> state = provider.state;
            switch (state.status) {
              case Status.loading:
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: secondaryColor,
                    title: const Text('Loading'),
                  ),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case Status.error:
                return Scaffold(
                  backgroundColor: secondaryColor,
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        16.0,
                      ),
                      child: Text(
                        state.message!,
                      ),
                    ),
                  ),
                );
              case Status.hasData:
                {
                  Restaurant restaurant = state.data!.restaurant;
                  return Scaffold(
                    body: NestedScrollView(
                      headerSliverBuilder: (context, isScroller) {
                        return [
                          SliverAppBar(
                            pinned: true,
                            expandedHeight: 200,
                            iconTheme: const IconThemeData(
                              color: Colors.white,
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              background: Hero(
                                tag: restaurant.id,
                                child: Image.network(
                                  restaurant.mediumPictureUrl,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              title: Text(
                                restaurant.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              centerTitle: true,
                              titlePadding: const EdgeInsets.only(
                                bottom: 16.0,
                              ),
                            ),
                          ),
                        ];
                      },
                      body: Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(8.0)),
                        child: ListView(
                          padding: const EdgeInsets.all(8.0,),
                          children: [
                            Text(restaurant.description),
                            const Divider(height: 12.0, color: Color(0xff6c5ecf),),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined),
                                Text('${restaurant.address}, '),
                                Text(restaurant.city),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star_border),
                                Text(restaurant.rating.toString()),
                              ],
                            ),
                            const Divider(
                              height: 12.0,
                              color: Color(0xff6c5ecf),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Foods'),
                                  foodmenu(context, restaurant.menus.foods),
                                  const Divider(
                                    height: 12.0,
                                      color: Color(0xff6c5ecf),
                                  ),
                                  const Text('Drinks'),
                                  drinkmene(context, restaurant.menus.drinks),
                                  const Divider(
                                    height: 12.0,
                                      color: Color(0xff6c5ecf),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            }
          },
        )
    );
  }

  Widget foodmenu(BuildContext context, List<Food> foods){
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 8,),
          SizedBox(height: 65,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foods.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(foods[index].name)
                        ],
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  Widget drinkmene(BuildContext context, List<Drink> drinks){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8,),
        SizedBox(height: 65,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: drinks.length,
              itemBuilder: (context, index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(drinks[index].name)
                      ],
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  Widget _buildAndroid(BuildContext context){
    return _buildDetails(context);

  }

  Widget _buildIos(BuildContext context){
    return _buildDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
