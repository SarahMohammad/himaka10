import 'package:himaka/Models/get_categories_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

class GetCategoriesViewModel extends BaseModel {
  Api _api = locator<Api>();
  GetCategoriesResponse _getCategoriesResponse;

  Future getCategories(String lang, int catType) async {
    setState(ViewState.Busy);
    GetCategoriesReq getCategoriesReq =
        new GetCategoriesReq(lang, Globals.userData.token, catType);
    _getCategoriesResponse =
        await _api.getCategories(getCategoriesReq.getCategoriesToMap());
    setState(ViewState.Idle);
  }

  GetCategoriesResponse get getCategoriesResponse => _getCategoriesResponse;
}
