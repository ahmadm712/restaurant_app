import 'package:flutter/widgets.dart';
import 'package:restos/common/common.dart';
import 'package:restos/data/api/api_services.dart';
import 'package:restos/data/models/restaurant_api_model.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurant(id);
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetail get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetails = await apiService.getRestaurantDetail(id);
      if (restaurantDetails.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetails;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Terjadi gangguan. Periksa kembali koneksi internet anda';
    }
  }
}
