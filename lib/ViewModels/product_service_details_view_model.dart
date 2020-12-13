import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:himaka/Models/FavResponse.dart';
import 'package:himaka/Models/cart.dart';
import 'package:himaka/Models/product_service_details_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';
import 'base_model.dart';

class ProductServiceDetailsViewModel extends BaseModel {
  ProductOrServiceDetailsResponse _productOrServiceDetailsResponse;
  FavResponse _favResponse;
  final _storage = FlutterSecureStorage();
  int _count = 1;
  Api _api = locator<Api>();

  Future getProductOrServiceDetails(int id, String lang) async {
    setState(ViewState.Busy);
    Map<String, dynamic> data = {
      "token": Globals.userData.token,
      "item_id": id,
      "lang": lang,
    };

    _productOrServiceDetailsResponse =
        await _api.getProductOrServiceDetailsApi(data);
    if (_productOrServiceDetailsResponse != null &&
        _productOrServiceDetailsResponse.data != null) {
      readAll(_productOrServiceDetailsResponse.data.item);
    }
    setState(ViewState.Idle);
  }

  Future addFav(String lang, int productId, int fav) async {
//    _serviceId = 2;
    print(lang);
    Map<String, dynamic> data = {
      "token": Globals.userData.token,
      'lang': lang,
      'product_id': productId,
      'isFav': fav
    };
    _favResponse = await _api.addProductServiceFav(data);

    if (_favResponse != null) {
      getProductOrServiceDetails(productId, lang);
    }
  }

  readAll(item) async {
    String value = await _storage.read(key: "cart");
    if (value != null) {
      Cart cart = Cart.fromJson(json.decode(value));
      for (int i = 0; i < cart.items.length; i++) {
        if (cart.items[i].id == item.id) {
          _count = cart.items[i].count;
          notifyListeners();
          break;
        }
      }
    }
  }

  add() {
    _count++;
  }

  minus() {
    if (_count != 1) _count--;
  }

  int get count => _count;

  set count(int value) {
    _count = value;
  }

  FavResponse get favResponse => _favResponse;
  ProductOrServiceDetailsResponse get productOrServiceDetailsResponse =>
      _productOrServiceDetailsResponse;
}
