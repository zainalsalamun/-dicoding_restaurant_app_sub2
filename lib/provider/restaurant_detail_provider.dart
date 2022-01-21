
import 'dart:async';
import 'dart:io';

import 'package:dicoding_restaurant_app_sub2/data/api/api_service.dart';
import 'package:dicoding_restaurant_app_sub2/data/response/restaurant_response.dart';
import 'package:dicoding_restaurant_app_sub2/utils/result.dart';
import 'package:flutter/material.dart';

class RestaurantDetailProvider extends ChangeNotifier{
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  Result<RestaurantDetailResponse> _state = Result(status: Status.loading, message: null, data: null);
  Result<RestaurantDetailResponse> get state => _state;

  Future<Result> getDetails(String id) async {
    try {
      _state = Result(status: Status.loading, message: null, data: null);
      notifyListeners();
      final RestaurantDetailResponse restaurantDetailResponse = await apiService.getDetails(id);
      _state = Result(status: Status.hasData, message: null, data: restaurantDetailResponse);
      notifyListeners();
      return _state;
    } on TimeoutException {
      _state = Result(
          status: Status.error, message: 'timeoutExceptionMessage', data: null);
      notifyListeners();
      return _state;
    } on SocketException {
      _state = Result(
          status: Status.error, message: 'socketExceptionMessage', data: null);
      notifyListeners();
      return _state;
    } on Error catch (e) {
      _state =
          Result(status: Status.error, message: e.toString(), data: null);
      notifyListeners();
      return _state;
    }
  }
}