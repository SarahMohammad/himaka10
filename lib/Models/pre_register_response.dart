class PreRegisterResponse {
  bool status;
  String msg;
  PreRegisterData data;

  PreRegisterResponse({this.status, this.msg, this.data});

  PreRegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null
        ? new PreRegisterData.fromJson(json['data'])
        : null;
  }
}

class PreRegisterData {
  int default_code;
  CurrencyMap currencies1;

  List<WithdrawMethod> withdraws_methods;

  PreRegisterData({this.default_code, this.withdraws_methods});

  PreRegisterData.fromJson(Map<String, dynamic> json) {
    default_code = json['default_code'];
    currencies1 = json['currencies1'] != null
        ? new CurrencyMap.fromJson(json['currencies1'])
        : null;
    if (json['withdraws_methods'] != null) {
      withdraws_methods = new List<WithdrawMethod>();
      json['withdraws_methods'].forEach((v) {
        withdraws_methods.add(new WithdrawMethod.fromJson(v));
      });
    }
  }
}

class WithdrawMethod {
  int id;
  String name, field_name, is_active;

  WithdrawMethod({this.id, this.name, this.field_name, this.is_active});

  factory WithdrawMethod.fromJson(Map<String, dynamic> json) {
    return WithdrawMethod(
      id: json['id'],
      name: json['name'],
      field_name: json['field_name'],
      is_active: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'field_name': field_name,
        'is_active': is_active,
      };
}

class CurrencyMap {
  Map<String, List<CurrencyData>> currencies =
      new Map<String, List<CurrencyData>>();
  List<CurrencyData> _currenciesSubscription;

  CurrencyMap.fromJson(Map<String, dynamic> json) {
    json.forEach((k, v) {
      _currenciesSubscription = new List<CurrencyData>();
      v.forEach((v) {
        _currenciesSubscription.add(new CurrencyData.fromJson(v));
      });
      currencies[k] = _currenciesSubscription;
    });
  }
}

class CurrencyData {
  int id;
  String currency,
      duration,
      limit,
      subscription_cost,
      commission,
      max_people,
      min_commission_to_appear;

  CurrencyData(
      {this.id,
      this.currency,
      this.duration,
      this.limit,
      this.subscription_cost,
      this.commission,
      this.max_people,
      this.min_commission_to_appear});

  CurrencyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    duration = json['duration'];
    limit = json['limit'];
    subscription_cost = json['subscription_cost'];
    commission = json['commission'];
    max_people = json['max_people'];
    min_commission_to_appear = json['min_commission_to_appear'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'currency': currency,
        'duration': duration,
        'limit': limit,
        'subscription_cost': subscription_cost,
        'commission': commission,
        'max_people': max_people,
        'min_commission_to_appear': min_commission_to_appear,
      };
}


