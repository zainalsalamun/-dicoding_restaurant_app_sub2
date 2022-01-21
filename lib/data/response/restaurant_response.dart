import 'package:dicoding_restaurant_app_sub2/data/model/restaurant_model.dart';

class RestaurantDetailResponse{
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) => RestaurantDetailResponse(
    error: json['error'],
    message: json['message'],
    restaurant: Restaurant.fromJson(json['restaurant']),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'restaurant': restaurant,
  };
}

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    final bool error = json['error'];
    final String message = json['message'];
    final int count = json['count'];
    final List<Restaurant> restaurants = (json['restaurants'] as List)
        .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
        .toList();

    return RestaurantListResponse(
      error: error,
      message: message,
      count: count,
      restaurants: restaurants,
    );
  }
}

class RestaurantSearchResponse{
  bool error;
  int founded;
  List<Restaurant> restaurant;

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurant,});

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) => RestaurantSearchResponse(
    error: json['error'],
    founded: json['founded'],
    restaurant: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'founded':founded,
    'restaurants':List<dynamic>.from(restaurant.map((x) => x.toJson()))
  };
}