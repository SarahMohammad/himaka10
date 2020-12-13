class PersonalWalletCashOutResponse {
  bool status;
  List<String> errors;
  String msg;

  PersonalWalletCashOutResponse.fromJson(Map<String, dynamic> json) {
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

class PersonalWalletCashOutReq {
  String lang;
  String token;
  String amount;
  int withId;
  String withValue;
  String withValueDesc;

  PersonalWalletCashOutReq(this.lang, this.token, this.amount,this.withId,this.withValue,this.withValueDesc);

  Map<String, dynamic> personalWalletCashOutToMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = lang;
    data['token'] = token;
    data['amount'] = amount;
    data['withdraw_way_id'] = withId;
    data['withdraw_field_value'] = withValue;
    data['withdraw_field_description'] = withValueDesc;
    return data;
  }
}
