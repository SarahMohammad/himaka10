import 'package:himaka/Models/FavResponse.dart';
import 'package:himaka/Models/wishlist_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class WishListViewModel extends BaseModel {
  WishListResponse _wishListResponse;
  FavResponse _favResponse;
  Api _api = locator<Api>();

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
      getWishList(lang);
    }
  }

  Future getWishList(String lang) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
      'lang': lang
    };
    _wishListResponse = await _api.getWishListApi(token);
    setState(ViewState.Idle);
  }

  FavResponse get favResponse => _favResponse;
  WishListResponse get wishListResponse => _wishListResponse;
}
