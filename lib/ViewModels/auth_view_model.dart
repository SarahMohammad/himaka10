import 'package:himaka/Models/login_response.dart';
import 'package:himaka/Models/pre_register_response.dart';
import 'package:himaka/services/api.dart';
import 'package:himaka/services/locator.dart';

import 'base_model.dart';

class AuthViewModel extends BaseModel {
  bool _emailValidate = true;
  bool _fNameValidate = true;
  bool _lNameValidate = true;
  bool _phoneValidate = true;
  bool _codeValidate = true;
  bool _passwordValidate = true;
  bool _cPassValidate = true;
  bool _nationalValidate=true;

  ////////////
  bool _pinValidate = true;
  bool _answerValidate = true;
  bool _quesValidate = true;
  PreRegisterResponse _preRegisterResponse;

  //////////////
  CurrencyData _selectedSubscription;
  bool _currencyValidate = true;
  bool _currencySubscriptionValidate = true;

  //////////////
  bool _methodIdValidate = true;
  bool _methodFieldValidate = true;
  bool _descValidate = true;

  Api _api = locator<Api>();

  Future<LoginResponse> login(String email, String password) async {
    setState(ViewState.Busy);
    LoginUserResponse user =
        new LoginUserResponse(email: email, password: password);
    var success = await _api.login(user.signInToMap());
    setState(ViewState.Idle);
    return success;
  }

  Future preRegister(String lang) async {
    setState(ViewState.Busy);
    LoginUserResponse user = new LoginUserResponse();
    _preRegisterResponse = await _api.preRegister(user.preRegisterToMap(lang));
    setState(ViewState.Idle);
  }
  Future<LoginResponse> validateRegisterPage1(
      String lang,
      String confirmPass,
      String mobile_code,
      String code,
      String firstName,
      String lastName,
      String email,
      String password,
      String mobile,
      String nationalId) async {
    setState(ViewState.Busy);
    LoginUserResponse user = new LoginUserResponse(
        first_name: firstName,
        last_name: lastName,
        email: email,
        password: password,
        mobile: mobile,
        national_id: nationalId);
    var success = await _api.validateRegisterData(
        user.preRegisterPage1ToMap(lang, confirmPass, mobile_code, code),1);
    setState(ViewState.Idle);
    return success;
  }
  Future<LoginResponse> validateRegisterPage2(
      String lang,
      String pin,
      String ques,
      String answer) async {
    setState(ViewState.Busy);
    LoginUserResponse user = new LoginUserResponse(
        pin: pin,
        question: ques,
        answer: answer);
    var success = await _api.validateRegisterData(
        user.preRegisterPage2ToMap(lang),2);
    setState(ViewState.Idle);
    return success;
  }
  // Future<LoginResponse> validateRegisterPage3(
  //     String lang,
  //     String subscription) async {
  //   setState(ViewState.Busy);
  //   LoginUserResponse user = new LoginUserResponse();
  //   var success = await _api.validateRegisterData(
  //       user.preRegisterPage3ToMap(lang,subscription),3);
  //   setState(ViewState.Idle);
  //   return success;
  // }

  Future<LoginResponse> register(
      String lang,
      String confirmPass,
      String mobile_code,
      String code,
      String subscription,
      String firstName,
      String lastName,
      String email,
      String password,
      String mobile,
      String nationalId,
      String pin,
      String ques,
      String answer) async {
    setState(ViewState.Busy);
    LoginUserResponse user = new LoginUserResponse(
        first_name: firstName,
        last_name: lastName,
        email: email,
        password: password,
        mobile: mobile,
        pin: pin,
        question: ques,
        answer: answer,
        national_id: nationalId);
    var success = await _api.register(
        user.registerToMap(lang, confirmPass, mobile_code, code, subscription));
    setState(ViewState.Idle);
    return success;
  }

  bool authValidation(String email, String password) {
    bool validate = true;
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      _emailValidate = false;
      validate = false;
    } else {
      _emailValidate = true;
    }

    if (password.isEmpty) {
      _passwordValidate = false;
      validate = false;
    } else {
      _passwordValidate = true;
    }
    notifyListeners();
    return validate;
  }

  bool signUpValidation(String fName, String lName, String email, String phone,
      String nationalId, String password, String cPass, String code) {
    bool validate = true;
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      _emailValidate = false;
      validate = false;
    } else {
      _emailValidate = true;
    }
    if (fName.length < 3) {
      _fNameValidate = false;
      validate = false;
    } else {
      _fNameValidate = true;
    }
    if (lName.length < 3) {
      _lNameValidate = false;
      validate = false;
    } else {
      _lNameValidate = true;
    }
    if (phone.length < 8) {
      _phoneValidate = false;
      validate = false;
    } else {
      _phoneValidate = true;
    }
    if (nationalId.length < 8) {
      _nationalValidate = false;
      validate = false;
    } else {
      _nationalValidate = true;
    }
    if (code.isEmpty) {
      _codeValidate = false;
      validate = false;
    } else {
      _codeValidate = true;
    }
    if (password.length < 8) {
      _passwordValidate = false;
      validate = false;
    } else {
      _passwordValidate = true;
      if (cPass != password) {
        _cPassValidate = false;
        validate = false;
      } else {
        _cPassValidate = true;
      }
    }
    notifyListeners();
    return validate;
  }

  bool secondSignUpValidation(String pin, String ques, String answer) {
    bool validate = true;

    if (pin.length < 4) {
      _pinValidate = false;
      validate = false;
    } else {
      _pinValidate = true;
    }
    if (ques != null && ques.isNotEmpty) {
      _quesValidate = true;
    } else {
      _quesValidate = false;
      validate = false;
    }
    if (answer.length < 4) {
      _answerValidate = false;
      validate = false;
    } else {
      _answerValidate = true;
    }

    notifyListeners();
    return validate;
  }

  bool thirdSignUpValidation(String val) {
    bool validate = true;

    if (val != null && val.isNotEmpty) {
      _currencyValidate = true;
    } else {
      _currencyValidate = false;
      validate = false;
    }
    if (_selectedSubscription != null) {
      _currencySubscriptionValidate = true;
    } else {
      _currencySubscriptionValidate = false;
      validate = false;
    }

    notifyListeners();
    return validate;
  }

  bool forthSignUpValidation(
      WithdrawMethod val, String methodField, String desc) {
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

      if (desc.isEmpty) {
        _descValidate = false;
        validate = false;
      } else {
        _descValidate = true;
      }
    }

    notifyListeners();
    return validate;
  }

  List<CurrencyData> getSubscriptionList(
      String currency, PreRegisterData data) {
    List<CurrencyData> result = new List<CurrencyData>();
    if (currency != null && currency.isNotEmpty) {
      result = data.currencies1.currencies[currency];
      return result;
    }
    return result;
  }

  String getSubscriptionText(CurrencyData currencyData, String val) {
    if (currencyData.duration == "1")
      return currencyData.subscription_cost + ' ' + val + ' every 12 months';
    else if (currencyData.duration == "2")
      return currencyData.subscription_cost + ' ' + val + ' every 1 month';
    else if (currencyData.duration == "3")
      return currencyData.subscription_cost + ' ' + val + ' every 1 week';
    else
      return currencyData.subscription_cost + ' ' + val + ' every 1 Day';
  }

  String getRegisterErrors(List<String> errors) {
    String errorsResult = "";
    errors.forEach((error) {
      errorsResult += error + '\n';
    });
    return errorsResult;
  }

  bool get fNameValidate => _fNameValidate;

  PreRegisterResponse get preRegisterResponse => _preRegisterResponse;

  bool get passwordValidate => _passwordValidate;

  bool get emailValidate => _emailValidate;

  bool get lNameValidate => _lNameValidate;

  bool get phoneValidate => _phoneValidate;

  bool get codeValidate => _codeValidate;

  bool get cPassValidate => _cPassValidate;

  bool get pinValidate => _pinValidate;

  bool get quesValidate => _quesValidate;

  bool get answerValidate => _answerValidate;

  bool get descValidate => _descValidate;

  bool get methodFieldValidate => _methodFieldValidate;

  bool get methodIdValidate => _methodIdValidate;

  CurrencyData get selectedSubscription => _selectedSubscription;

  bool get currencyValidate => _currencyValidate;

  set selectedSubscription(CurrencyData value) {
    _selectedSubscription = value;
  }

  set methodIdValidate(bool value) {
    _methodIdValidate = value;
    notifyListeners();
  }


  bool get nationalValidate => _nationalValidate;

  bool get currencySubscriptionValidate => _currencySubscriptionValidate;
}
