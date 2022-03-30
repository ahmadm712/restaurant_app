import 'package:flutter/widgets.dart';
import 'package:restos/common/common.dart';
import 'package:restos/data/api/api_services.dart';
import 'package:restos/data/models/restaurant_api_model.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiServices apiService;
  late RestaurantList _restaurantApi;

  late ResultState _state;
  String _message = '';

  late ResultState _statePost;
  String _messagePost = '';

  RestaurantsProvider({required this.apiService}) {
    _fetchRestaurants();
  }

  String get message => _message;
  RestaurantList get restaurant => _restaurantApi;
  ResultState get state => _state;

  ResultState get statePost => _statePost;
  String get messagePost => _messagePost;

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.fetchListRestaurants();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantApi = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Terjadi gangguan. Periksa kembali koneksi internet anda';
    }
  }

  Future<dynamic> createCustomerReview(
      String id, String name, String review) async {
    try {
      _statePost = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.createCustomerReview(
        id: id,
        name: name,
        review: review,
      );
      if (restaurants) {
        _statePost = ResultState.hasData;
        notifyListeners();
        return restaurants;
      } else {
        _statePost = ResultState.noData;
        notifyListeners();
        return _messagePost = 'Empty Data';
      }
    } catch (e) {
      _statePost = ResultState.error;
      notifyListeners();
      return _messagePost =
          'Terjadi gangguan. Periksa kembali koneksi internet anda';
    }
  }
}
