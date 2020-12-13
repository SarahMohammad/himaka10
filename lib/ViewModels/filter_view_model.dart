import 'package:himaka/Models/prep_filter.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class FilterViewModel extends BaseModel {
  Api _api = locator<Api>();
  double _lowerValue = 0.0;
  double _upperValue = 0.0;

  PrepFilterResponse _prepFilterResponse;
  int _type = 1; // 1 product, 2 service only

  Future prepFilter(String lang) async {
    setState(ViewState.Busy);
    PrepReq req = new PrepReq(lang, Globals.userData.token, _type);
    _prepFilterResponse = await _api.prepFilter(req.prepFilterToMap());
    if (_prepFilterResponse != null && _prepFilterResponse.data != null) {
      _lowerValue = _prepFilterResponse.data.minPrice.toDouble();
      _upperValue = _prepFilterResponse.data.maxPrice.toDouble();
    }
    setState(ViewState.Idle);
  }

  int getCatId(List<MainCategory> categories, String catName) {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].name == catName) return categories[i].id;
    }
    return -1;
  }

  PrepFilterResponse get prepFilterResponse => _prepFilterResponse;

  int get type => _type;

  set type(int value) {
    _type = value;
  }

  double get upperValue => _upperValue;

  set upperValue(double value) {
    _upperValue = value;
    notifyListeners();
  }

  double get lowerValue => _lowerValue;

  set lowerValue(double value) {
    _lowerValue = value;
    notifyListeners();
  }
}
