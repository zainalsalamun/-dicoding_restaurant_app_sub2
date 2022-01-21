import 'dart:convert';
import 'dart:async';
import 'package:dicoding_restaurant_app_sub2/data/response/restaurant_response.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://restaurant-api.dicoding.dev";

class ApiService {

  static const _slash='/';

  Future<RestaurantListResponse> getTopHeadLines() async{
    final response = await http.get(Uri.parse(baseUrl + _slash +'list'));
    try{
      if(response.statusCode == 200){
        return RestaurantListResponse.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load top headlines');
      }
    }catch(e){
      rethrow;
    }
  }

  Future<RestaurantSearchResponse> getSearch(String query) async {
    final response = await http.get(Uri.parse(baseUrl + _slash + 'search?q=$query')).timeout(const Duration(seconds: 5));
    try{
      if(response.statusCode == 200){
        return RestaurantSearchResponse.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load result search.');
      }
    } on Error {
      rethrow;
    }
  }

  Future<RestaurantDetailResponse> getDetails(String id) async{
    final response = await http.get(Uri.parse(baseUrl + _slash + 'detail/$id')).timeout((const Duration(seconds: 5)));
    try{
      if(response.statusCode == 200){
        return RestaurantDetailResponse.fromJson(json.decode(response.body));
      }else{
        throw Exception('Failed to load details.');
      }
    }on Error {
      rethrow;
    }
  }
}