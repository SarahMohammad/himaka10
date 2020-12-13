import 'package:himaka/Models/pre_upgrade_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

class UpgradeViewModel extends BaseModel {
  Api _api = locator<Api>();
  PreUpgradeResponse _preUpgradeResponse;

  Future preUpgrade(String lang) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
      "lang": lang
    };
    _preUpgradeResponse = await _api.preUpgrade(token);
    setState(ViewState.Idle);
  }

  Future<PreUpgradeResponse> upgrade(String lang) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
      "lang": lang
    };
    var response = await _api.upgrade(token);
    setState(ViewState.Idle);
    return response;
  }

  PreUpgradeResponse get preUpgradeResponse => _preUpgradeResponse;
}
