import 'dart:convert';

import 'package:himaka/Models/ProfileResponse.dart';
import 'package:himaka/Models/login_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/caching.dart';
import 'package:himaka/utils/globals.dart';

import 'base_model.dart';

class ProfileViewModel extends BaseModel {
  ProfileResponse _profileResponse, _editedProfileResponse;
  LoginResponse _addressResponse;

  Api _api = locator<Api>();

  int _serviceId = 1;

  Future setAddress(String address) async {
    _serviceId = 2;
    setState(ViewState.Busy);
    Map<String, dynamic> data = {
      "token": Globals.userData.token,
      "address": address
    };
    _addressResponse = await _api.setAddressApi(data);
    setState(ViewState.Idle);
  }

  Future getProfileDetails(String lang) async {
    _serviceId = 1;
    setState(ViewState.Busy);
    Map<String, dynamic> token = {"token": Globals.userData.token};
    _profileResponse = await _api.getProfileApi(token);
    setState(ViewState.Idle);
  }

  Future<LoginResponse> logOut(String lang) async {
    _serviceId = 3;
    setState(ViewState.Busy);
    Map<String, dynamic> token = {"token": Globals.userData.token};
    var response = await _api.logOut(token);
    setState(ViewState.Idle);
    return response;
  }

  Future setProfileDetails(String lang, String fName, String lName,
      String phone, String oldPass, String newPass) async {
    _serviceId = 2;
    setState(ViewState.Busy);
    Map<String, dynamic> data = {
      'token': Globals.userData.token,
      'first_name': fName,
      'last_name': lName,
      'mobile': phone,
      'old_password': oldPass,
      'new_password': newPass,
    };

    _editedProfileResponse = await _api.setProfileApi(data);
    if (_editedProfileResponse != null && _editedProfileResponse.data != null) {
      saveLoginData(json.encode(_editedProfileResponse.data.user));
      Globals.userData = _editedProfileResponse.data.user;
    }
    setState(ViewState.Idle);
  }

  int get serviceId => _serviceId;
  LoginResponse get addressResponse => _addressResponse;

  ProfileResponse get profileResponse => _profileResponse;
  ProfileResponse get editedProfileResponse => _editedProfileResponse;
}
