import 'package:himaka/Models/FavResponse.dart';
import 'package:himaka/Models/home_response.dart';
import 'package:himaka/Models/order_details_response.dart';
import 'package:himaka/Models/orders_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class BannerProductsViewModel extends BaseModel {
  HomeResponse _bannerProductsResponse;
  FavResponse _favResponse;
  bool _isLoading = false;
  List<Offer> productsList;

  int _serviceId = 1;
  Api _api = locator<Api>();
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
      getProductsBanner(lang, productId);
    }
  }

  Future getProductsBanner(String lang, int id) async {
    setState(ViewState.Busy);
    Map<String, dynamic> header = {
      "token": Globals.userData.token,
      "banner_id": id,
      "lang": lang
    };
    _bannerProductsResponse = await _api.getBannerProducts(header);
    setState(ViewState.Idle);
  }

  FavResponse get favResponse => _favResponse;

  HomeResponse get bannerProductsResponse => _bannerProductsResponse;
}
