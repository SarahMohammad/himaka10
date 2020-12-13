import 'package:himaka/Models/pre_register_response.dart';

class LoginResponse {
  bool status;

  // Errors errors;
  List<String> errors;
  String msg;
  LoginDataResponse data;

  LoginResponse({this.data, this.status, this.msg, this.errors});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new LoginDataResponse.fromJson(json['data'])
        : null;
    // errors =
    //     json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    status = json['status'];
    msg = json['msg'];
    if (json['errors'] != null) {
      errors = new List<String>();
      json['errors'].forEach((v) {
        errors.add(v);
      });
    }
  }
}

class LoginDataResponse {
  LoginUserResponse user;

  LoginDataResponse({this.user});

  LoginDataResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null
        ? new LoginUserResponse.fromJson(json['user'])
        : null;
  }
}

class LoginUserResponse {
  int id;

  String first_name,
      last_name,
      password,
      email,
      commission_acount,
      profit_acount,
      cachback_caccount,
      cadeau_acount,
      personal_acount,
      token,
      address,
      currency,
      withdraw_field_description,
      withdraw_field_value,
      national_id,
      pin,
      mobile,
      question,
      answer;
  WithdrawMethod withdrawMethod;
  var withdraw_way_id;
  List permissions;

  LoginUserResponse(
      {this.id,
      this.password,
      this.first_name,
      this.last_name,
      this.email,
      this.token,
      this.commission_acount,
      this.cachback_caccount,
      this.cadeau_acount,
      this.currency,
      this.personal_acount,
      this.withdraw_way_id,
      this.withdraw_field_description,
      this.withdraw_field_value,
      this.national_id,
      this.pin,
      this.withdrawMethod,
      this.address,
      this.mobile,
      this.question,
      this.answer});

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) {
    return LoginUserResponse(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      token: json['token'],
      currency: json['currency'],
      commission_acount: json['commission_acount'],
      cachback_caccount: json['cachback_caccount'],
      cadeau_acount: json['cadeau_acount'],
      personal_acount: json['personal_acount'],
      withdraw_way_id: json['withdraw_way_id'],
      withdraw_field_description: json['withdraw_field_description'],
      withdraw_field_value: json['withdraw_field_value'],
      national_id: json['national_id'],
      pin: json['pin'],
      email: json['email'],
      mobile: json['mobile'],
      address: json['address'],
      question: json['question'],
      answer: json['answer'],
      withdrawMethod: json['withdraw_method'] != null
          ? new WithdrawMethod.fromJson(json['withdraw_method'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': first_name,
        'last_name': last_name,
        'token': token,
        'currency': currency,
        'commission_acount': commission_acount,
        'cachback_caccount': cachback_caccount,
        'cadeau_acount': cadeau_acount,
        'personal_acount': personal_acount,
        'withdraw_way_id': withdraw_way_id,
        'withdraw_field_description': withdraw_field_description,
        'withdraw_field_value': withdraw_field_value,
        'national_id': national_id,
        'pin': pin,
        'mobile': mobile,
        'email': email,
        'question': question,
        'address': address,
        'answer': answer,
        'withdraw_method':
            withdrawMethod != null ? withdrawMethod.toJson() : null
      };

  Map<String, dynamic> signInToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
  Map<String, dynamic> preRegisterPage1ToMap(String lang, String confirmPass,
      String mobile_code, String code) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = confirmPass;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['mobile_code'] = mobile_code;
    data['mobile_number'] = this.mobile;
    data['national_id'] = this.national_id;
    data['code'] = code;

    return data;
  }
  Map<String, dynamic> preRegisterPage2ToMap(String lang) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['pin'] = this.pin;
    data['question'] = this.question;
    data['answer'] = this.answer;

    return data;
  }
  Map<String, dynamic> preRegisterPage3ToMap(String lang, String subscription) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['subscription'] = subscription;

    return data;
  }

  Map<String, dynamic> registerToMap(String lang, String confirmPass,
      String mobile_code, String code, String subscription) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = confirmPass;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['mobile_code'] = mobile_code;
    data['mobile_number'] = this.mobile;
    data['national_id'] = this.national_id;
    data['code'] = code;
    data['pin'] = this.pin;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['subscription'] = subscription;
    // data['withdraw_method'] = this.withdraw_way_id;
    // data['withdraw_main_field_value'] = this.withdraw_field_value;
    // data['withdraw_description'] = this.withdraw_field_description;

    return data;
  }

  Map<String, dynamic> preRegisterToMap(String lang) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_password'] = '5himaka';
    data['lang'] = lang;
    return data;
  }
}

class Errors {
  Map<String, List<String>> errorsCode = new Map<String, List<String>>();
  List<String> _errorsDesc;

  Errors.fromJson(Map<String, dynamic> json) {
    json.forEach((k, v) {
      _errorsDesc = new List<String>();
      v.forEach((v) {
        _errorsDesc.add(v);
      });
      errorsCode[k] = _errorsDesc;
    });
  }
}
