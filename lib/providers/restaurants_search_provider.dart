import 'package:flutter/cupertino.dart';
import 'package:restos/common/common.dart';
import 'package:restos/data/api/api_services.dart';
import 'package:restos/data/models/restaurant_api_model.dart';

class RestaurantsSearchProvider extends ChangeNotifier {
  final ApiServices apiService;

  RestaurantsSearchProvider({required this.apiService}) {
    fetchSearchRestaurant(enteredWord);
  }

  RestaurantSearch? _restaurantSearch;
  ResultState? _state;
  String _message = '';
  String _enteredWord = '';

  String get message => _message;
  String get enteredWord => _enteredWord;
  RestaurantSearch? get result => _restaurantSearch;
  ResultState? get state => _state;

  Future<dynamic> fetchSearchRestaurant(String enteredWord) async {
    try {
      if (enteredWord.isNotEmpty) {
        _state = ResultState.loading;
        _enteredWord = enteredWord;
        notifyListeners();
        final restaurantSearch = await apiService.searchRestaurant(enteredWord);
        if (restaurantSearch.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantSearch = restaurantSearch;
        }
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Terjadi gangguan. Periksa kembali koneksi internet anda';
    }
  }
}
