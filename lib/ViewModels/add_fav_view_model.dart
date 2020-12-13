import 'package:himaka/Models/FavResponse.dart';
import 'package:himaka/Models/home_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class AddFavViewModel extends BaseModel {
  FavResponse _favResponse;

  Api _api = locator<Api>();

  Future addFav(String lang, int productId, int fav) async {
    print(lang);
    setState(ViewState.Busy);
    Map<String, dynamic> data = {
      "token": Globals.userData.token,
      'lang': lang,
      'product_id': productId,
      'isFav': fav
    };
    _favResponse = await _api.addProductServiceFav(data);
    setState(ViewState.Idle);
  }

  FavResponse get favResponse => _favResponse;
}
