import 'package:himaka/Models/transition_response.dart';
import 'package:himaka/Models/wallet_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

class WalletViewModel extends BaseModel {
  Api _api = locator<Api>();
  WalletResponse _walletResponse;
  bool _amountValidate = true;

  Future cashBackWallet(String lang) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
    };
    _walletResponse = await _api.cashBackWallet(token);
    setState(ViewState.Idle);
  }
  Future commissionWallet() async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
    };
    _walletResponse = await _api.commissionWallet(token);
    setState(ViewState.Idle);
  }
  Future earningWallet() async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
    };
    _walletResponse = await _api.earningWallet(token);
    setState(ViewState.Idle);
  }
  Future rewardWallet() async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
    };
    _walletResponse = await _api.rewardWallet(token);
    setState(ViewState.Idle);
  }
  Future getMembers(int id) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
      "id": id,
    };
    _walletResponse = await _api.commissionWallet(token);
    setState(ViewState.Idle);
  }

  Future<TransitionResponse> transitionToPersonal(
      String lang, String amount, int walletId) async {
    //Wallet id(1- cashback , 2- commission wallet, 3- reward wallet, 4- earning wallet)
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
      "wallet_id": walletId,
      "amount": amount,
    };
    var result = await _api.transitionToPersonalWallet(token);
    setState(ViewState.Idle);
    return result;
  }
  Future<TransitionResponse> convertCommissionWalletPoints(
      String lang) async {
    setState(ViewState.Busy);
    Map<String, dynamic> token = {
      "token": Globals.userData.token,
      "lang":lang
    };
    var result = await _api.convertCommissionWalletPoints(token);
    setState(ViewState.Idle);
    return result;
  }
  bool transitionValidation(String amount) {
    bool validate = true;

    if (amount.isNotEmpty) {
      _amountValidate = true;
    } else {
      _amountValidate = false;
      validate = false;
    }

    notifyListeners();
    return validate;
  }


  bool get amountValidate => _amountValidate;

  WalletResponse get walletResponse => _walletResponse;
}
