import 'dart:async';
import 'package:dicoding_restaurant_app_sub2/data/api/api_service.dart';
import 'package:dicoding_restaurant_app_sub2/data/model/restaurant_model.dart';
import 'package:flutter/material.dart';


enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late Welcome _welcome;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Welcome get result => _welcome;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.topHeadlines();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Hasil pencarian tidak ditemukan';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _welcome = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
      'Terjadi kesalahan, cek koneksi internet anda';
    }
  }
}
