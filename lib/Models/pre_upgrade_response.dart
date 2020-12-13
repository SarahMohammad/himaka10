class PreUpgradeResponse {
  String msg;
  List<String> errors;
  bool status;
  PreUpgradeResponseData data;

  PreUpgradeResponse.fromJson(Map<String, dynamic> json) {
    try{
      data = json['data'] != null
          ? new PreUpgradeResponseData.fromJson(json['data'])
          : null;
    }catch(e){

    }
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

class PreUpgradeResponseData {
  List<Card> cards;

  PreUpgradeResponseData.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = new List<Card>();
      json['cards'].forEach((v) {
        cards.add(new Card.fromJson(v));
      });
    }
  }
}

class Card {
  String duration;
  int status;
  String cost;
  String currency;

  Card.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    cost = json['cost'];
    status = json['status'];
    currency = json['currency'];
  }
}
