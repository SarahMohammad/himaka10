import 'dart:async';


import 'api.dart';
import 'locator.dart';

class AuthenticationService{
  // Inject our Api
  Api _api = locator<Api>();

//  Future<RegisterResponse> auth(Map body, int pathId) async {
//  var response = await _api.auth(body,pathId);
//  return response;
//}
//  Future<LoginResponse> login(Map body, int pathId) async {
//    var response = await _api.login(body,pathId);
//    if(response!=null && response.userData!=null){
//      Globals.userData=response.userData[0];
//    }
//    return response;
//  }


}

