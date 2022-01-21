import 'dart:io';
import 'dart:async';
import 'package:dicoding_restaurant_app_sub2/data/api/api_service.dart';
import 'package:dicoding_restaurant_app_sub2/data/response/restaurant_response.dart';
import 'package:dicoding_restaurant_app_sub2/utils/result.dart';
import 'package:flutter/material.dart';


class RestaurantProvider extends ChangeNotifier{
  final ApiService apiService;
  RestaurantProvider({required this.apiService}){
    _fetchAllRestaurant();
  }

  Result <RestaurantListResponse> _state = Result(status: Status.loading, message: null, data: null);

  Result<RestaurantListResponse> get state => _state;


  Future<dynamic> _fetchAllRestaurant() async{
    try{
      _state = Result(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestaurantListResponse restaurantListResponse = await apiService.getTopHeadLines();
      _state = Result(status: Status.hasData, message: null, data: restaurantListResponse);
      notifyListeners();
      return _state;
    }on TimeoutException{
      _state = Result(status: Status.error, message: 'Connection timeout, please try again!', data: null);
      notifyListeners();
      return _state;
    } on SocketException{
      _state = Result(status: Status.error, message: 'No internet, please check your internet!', data: null);
      notifyListeners();
      return _state;
    }on Error catch (e){
      _state = Result(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }
}