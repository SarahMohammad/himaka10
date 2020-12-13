import 'package:himaka/Models/login_response.dart';
import 'package:himaka/Models/personal_wallet_cash_out.dart';
import 'package:himaka/Models/pre_personal_wallet_cash_out.dart';
import 'package:himaka/Models/pre_register_response.dart';
import 'package:himaka/ViewModels/base_model.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';
import 'package:himaka/utils/globals.dart';

class PersonalWalletViewModel extends BaseModel {
  Api _api = locator<Api>();
  PrePersonalWalletCashOutResponse _personalWalletCashOutResponse;
  bool _pinValidate = true;
  bool _answerValidate = true;
  bool _quesValidate = true;
  ///////////////
  bool _amountValidate = true;
  bool _methodIdValidate = true;
  bool _methodFieldValidate = true;
  bool _descValidate = true;


  Future prePersonalWalletCashOut(String lang) async {
    setState(ViewState.Busy);
    PrePersonalWalletCashOutReq prePersonalReq =
        new PrePersonalWalletCashOutReq(lang, Globals.userData.token);
    _personalWalletCashOutResponse = await _api.prePersonalWalletCashOut(
        prePersonalReq.prePersonalWalletCashOutToMap());
    setState(ViewState.Idle);
  }
  Future getCashOutMethods(String lang) async {
    setState(ViewState.Busy);
    PrePersonalWalletCashOutReq prePersonalReq =
    new PrePersonalWalletCashOutReq(lang, Globals.userData.token);
    _personalWalletCashOutResponse = await _api.getUserCashOutMethods(
        prePersonalReq.prePersonalWalletCashOutToMap());
    setState(ViewState.Idle);
  }
  Future<LoginResponse> changeCashOutMethod(String lang,int withId, String withValue, String withDesc) async {

    setState(ViewState.Busy);
    ChangeMethodOfCashOutReq req = new ChangeMethodOfCashOutReq(
        lang, Globals.userData.token, withId, withValue, withDesc);
    var result = await _api
        .changeUserCashOutMethods(req.changeMethodOfCashOutToMap());
    setState(ViewState.Idle);
    return result;
  }

  Future<PersonalWalletCashOutResponse> personalWalletCashOut(String lang,
      String amount, int withId, String withValue, String withDesc) async {
    setState(ViewState.Busy);
    PersonalWalletCashOutReq personalReq = new PersonalWalletCashOutReq(
        lang, Globals.userData.token, amount, withId, withValue, withDesc);
    var result = await _api
        .personalWalletCashOut(personalReq.personalWalletCashOutToMap());
    setState(ViewState.Idle);
    return result;
  }
  bool personalWalletCashOutValidation(
      WithdrawMethod val, String methodField, String amount) {
    bool validate = true;
    if (val == null) {
      _methodIdValidate = false;
      validate = false;
    } else {
      _methodIdValidate = true;
      if (methodField.length < 8) {
        _methodFieldValidate = false;
        validate = false;
      } else {
        _methodFieldValidate = true;
      }
      if (amount.isEmpty) {
        _amountValidate = false;
        validate = false;
      } else {
        _amountValidate = true;
      }
    }

    notifyListeners();
    return validate;
  }
  bool changeMethodCashOutValidation(
      WithdrawMethod val, String methodField) {
    bool validate = true;
    if (val == null) {
      _methodIdValidate = false;
      validate = false;
    } else {
      _methodIdValidate = true;
      if (methodField.length < 8) {
        _methodFieldValidate = false;
        validate = false;
      } else {
        _methodFieldValidate = true;
      }
    }

    notifyListeners();
    return validate;
  }
  bool safetyValidation(String pin, String ques, String answer) {
    bool validate = true;

    if (pin.isNotEmpty && pin== Globals.userData.pin) {
      _pinValidate = true;
    } else {
      _pinValidate = false;
      validate = false;
    }
    if (ques != null && ques.isNotEmpty&& ques== Globals.userData.question) {
      _quesValidate = true;
    } else {
      _quesValidate = false;
      validate = false;
    }
    if (answer.isNotEmpty && answer== Globals.userData.answer) {
      _answerValidate = true;
    } else {
      _answerValidate = false;
      validate = false;
    }

    notifyListeners();
    return validate;
  }

  int getUserWithdrawMethodIndex(int id) {
    for (int i = 0;
        i < _personalWalletCashOutResponse.data.withdraws_methods.length;
        i++) {
      if (_personalWalletCashOutResponse.data.withdraws_methods[i].id == id)
        return i;
    }
    return -1;
  }

  PrePersonalWalletCashOutResponse get personalWalletCashOutResponse =>
      _personalWalletCashOutResponse;

  bool get quesValidate => _quesValidate;

  bool get answerValidate => _answerValidate;

  bool get pinValidate => _pinValidate;

  bool get descValidate => _descValidate;

  bool get methodFieldValidate => _methodFieldValidate;

  bool get methodIdValidate => _methodIdValidate;

  bool get amountValidate => _amountValidate;
}
