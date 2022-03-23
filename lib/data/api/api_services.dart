import 'dart:convert';
import 'dart:developer';

import 'package:restaurant_app/data/models/restaurant_api_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String _list = '/list';
  static final String _review = '/review';
  static final String _detail = '/detail/';

  ///* Detail restaurant
  /// :id ;
  ///* Search restaurant
  /// /search?q=query

  Future<RestaurantList> fetchListRestaurants() async {
    final url = Uri.parse(_baseUrl + _list);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return RestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load List Restaurants');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final url = Uri.parse(_baseUrl + _detail + id);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant detail');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String enteredWord) async {
    String filteredWord = enteredWord.replaceAll(' ', '%20');
    final url = Uri.parse(
      _baseUrl + "/search?q=" + filteredWord,
    );
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search result');
    }
  }

  Future<bool> createCustomerReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final url = Uri.parse(
      _baseUrl + _review,
    );

    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final data = jsonEncode(
      <String, String>{
        'id': id,
        'name': name,
        'review': review,
      },
    );

    final response = await http.post(
      url,
      body: data,
      headers: header,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add review');
    }
  }
}
