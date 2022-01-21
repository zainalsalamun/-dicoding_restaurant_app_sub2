
import 'dart:async';
import 'dart:io';
import 'package:dicoding_restaurant_app_sub2/data/api/api_service.dart';
import 'package:dicoding_restaurant_app_sub2/data/response/restaurant_response.dart';
import 'package:dicoding_restaurant_app_sub2/utils/result.dart';
import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier{
  final ApiService apiService;

  SearchProvider({required this.apiService});

  Result<RestaurantSearchResponse> _state = Result(
      status: Status.hasData,
      message: null,
      data: RestaurantSearchResponse(
        error: false,
        founded: 0,
        restaurant: [],
      )
  );

  Result<RestaurantSearchResponse> get state => _state;


  Future<dynamic> fetchSearchRestaurant(String keyword) async{
    try{
      _state = Result(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestaurantSearchResponse restaurantSearchResponse = await apiService.getSearch(keyword);
      _state = Result(
          status: Status.hasData,
          message: null,
          data: restaurantSearchResponse);
      notifyListeners();
      return _state;
    } on TimeoutException{
      _state = Result(status: Status.error, message: 'Request time out', data: null);
      notifyListeners();
      return _state;
    }on SocketException{
      _state = Result(status: Status.error, message: '', data: null);
      notifyListeners();
      return _state;
    } on Error catch (e){
      _state = Result(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }
}
