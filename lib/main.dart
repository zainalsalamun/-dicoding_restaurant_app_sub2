import 'package:dicoding_restaurant_app_sub2/component/navigation.dart';
import 'package:dicoding_restaurant_app_sub2/component/theme.dart';
import 'package:dicoding_restaurant_app_sub2/data/api/api_service.dart';
import 'package:dicoding_restaurant_app_sub2/provider/restaurant_detail_provider.dart';
import 'package:dicoding_restaurant_app_sub2/provider/restaurant_provider.dart';
import 'package:dicoding_restaurant_app_sub2/provider/search_restaurant_provider.dart';
import 'package:dicoding_restaurant_app_sub2/page/detail_restaurant_page.dart';
import 'package:dicoding_restaurant_app_sub2/page/home_page.dart';
import 'package:dicoding_restaurant_app_sub2/page/search_restaurant_page.dart';
import 'package:dicoding_restaurant_app_sub2/page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: _apiService)),
      ChangeNotifierProvider<SearchProvider>(
        create: (_) => SearchProvider(apiService: _apiService),
      ),
      ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) =>
              RestaurantDetailProvider(apiService: _apiService)),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resataurant',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(titleTextStyle: myTextTheme.headline6)),
      navigatorKey: navigatorKey,

      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        RestaurantSearch.routeName: (context) => const RestaurantSearch(),
        DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
          restaurant:
          ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    ),
  );
}
