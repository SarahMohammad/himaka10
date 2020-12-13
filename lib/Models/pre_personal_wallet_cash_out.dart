import 'package:himaka/Models/pre_register_response.dart';

import 'login_response.dart';

class PrePersonalWalletCashOutResponse {
  String msg;
  List<String> errors;
  bool status;
  PrePersonalWalletCashOutData data;

  PrePersonalWalletCashOutResponse({this.msg, this.status, this.data});

  PrePersonalWalletCashOutResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new PrePersonalWalletCashOutData.fromJson(json['data'])
        : null;
    status = json['status'];
    if (json['errors'] != null) {
      errors = new List<String>();
      json['errors'].forEach((v) {
        errors.add(v);
      });
    }
    msg = json['msg'];
  }
}
class ChangeMethodOfCashOutReq {
  String lang;
  String token;
  int withId;
  String withValue;
  String withValueDesc;

  ChangeMethodOfCashOutReq(this.lang, this.token,this.withId,this.withValue,this.withValueDesc);

  Map<String, dynamic> changeMethodOfCashOutToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    data['withdraw_method'] = withId;
    data['withdraw_main_field_value'] = withValue;
    data['withdraw_field_description'] = withValueDesc;
    return data;
  }
}

class PrePersonalWalletCashOutReq {
  String lang;
  String token;

  PrePersonalWalletCashOutReq(this.lang, this.token);

  Map<String, dynamic> prePersonalWalletCashOutToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    return data;
  }
}

class PrePersonalWalletCashOutData {
  String balance;
  LoginUserResponse user;
  List<WithdrawMethod> withdraws_methods;
  WithdrawMethod user_method;
  List<Transaction> transactions;

  PrePersonalWalletCashOutData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null
        ? new LoginUserResponse.fromJson(json['user'])
        : null;
    user_method = json['user_withdraw_method'] != null
        ? new WithdrawMethod.fromJson(json['user_withdraw_method'])
        : null;
    if (json['withdraw_methods'] != null) {
      withdraws_methods = new List<WithdrawMethod>();
      json['withdraw_methods'].forEach((v) {
        withdraws_methods.add(new WithdrawMethod.fromJson(v));
      });
    }

    if (json['withdraw_requests'] != null) {
      transactions = new List<Transaction>();
      json['withdraw_requests'].forEach((v) {
        transactions.add(new Transaction.fromJson(v));
      });
    }
    balance = json['balance'];
  }
}

class Transaction {
  int id;
  String value;
  String name;
  String amount;
  String confirm;
  String transactionDate;

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['withdraw_field_value'];
    name = json['main_filed_name'];
    amount = json['amount'];
    confirm = json['confirm'];
    transactionDate = json['created_at'];
  }
}
