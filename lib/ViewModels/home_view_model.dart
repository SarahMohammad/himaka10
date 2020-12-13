import 'package:himaka/Models/FavResponse.dart';
import 'package:himaka/Models/home_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class HomeViewModel extends BaseModel {
  HomeResponse _homeResponse, temp;
  FavResponse _favResponse;
  bool _isLoading = false;
  List<Offer> productsList;
  int _page = 0;
  int _total = 0;
  Api _api = locator<Api>();
  int _serviceId = 1;

  Future addFav(String lang, int productId, int fav) async {
    _serviceId = 2;
    print(lang);
    Map<String, dynamic> data = {
      "token": Globals.userData.token,
      'lang': lang,
      'product_id': productId,
      'isFav': fav
    };
    _favResponse = await _api.addProductServiceFav(data);

    if (_favResponse != null) {
      pullToRefresh();
      getHome(lang);
    }
  }

  Future getHome(String lang) async {
    _serviceId = 1;
    print(lang);
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
      'lang': lang,
      'page': _page
    };
    temp = await _api.getHomeApi(token);
    print("iddd" + temp.data.products[0].id.toString());

    _homeResponse = temp;
    if (_total == 0 && temp != null && temp.data != null)
      _total = temp.data.total;
    if (temp != null) if (temp.data != null && temp.data.products != null)
      incrementPage(temp.data.products);
    _isLoading = false;

    setState(ViewState.Idle);
  }

  FavResponse get favResponse => _favResponse;
  int get serviceId => _serviceId;
  HomeResponse get homeResponse => _homeResponse;

  incrementPage(List<Offer> allProducts) {
    if (productsList == null) {
      productsList = allProducts;
    } else {
      if (allProducts.length > 0) {
        productsList.addAll(allProducts);
      }
    }
    if (canIncrement()) _page++;
  }

  void pullToRefresh() {
    _page = 0;
    _homeResponse = null;
    productsList = null;
  }

  bool canIncrement() {
    if (_total == 0 || (_total / 10) > _page) {
      return true;
    }
    return false;
  }

  set isLoading(bool value) {
    _isLoading = value;
  }

  set total(int value) {
    _total = value;
  }

  bool get isLoading => _isLoading;

  int get page => _page;

  int get total => _total;
}
