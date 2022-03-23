import 'package:flutter/widgets.dart';
import 'package:restaurant_app/common/common.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/models/restaurant_api_model.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiServices apiService;
  late RestaurantList _restaurantApi;

  late ResultState _state;
  String _message = '';

  late ResultStatePost _statePost;
  String _messagePost = '';

  RestaurantsProvider({required this.apiService}) {
    _fetchRestaurants();
  }

  String get message => _message;
  RestaurantList get restaurant => _restaurantApi;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.fetchListRestaurants();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantApi = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> createCustomerReview(
      String id, String name, String review) async {
    try {
      _statePost = ResultStatePost.Loading;
      notifyListeners();
      final restaurants = await apiService.createCustomerReview(
        id: id,
        name: name,
        review: review,
      );
      if (restaurants) {
        _statePost = ResultStatePost.Succes;
        notifyListeners();
        return restaurants;
      } else {
        _statePost = ResultStatePost.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      }
    } catch (e) {
      _statePost = ResultStatePost.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
