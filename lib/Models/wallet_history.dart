class WalletHistory{
  int id;
  int walletId;
  String walletType;
  String currentTotal;
  String previousTotal;
  String amountSpent;
  String walletTypeFrom;
  String operationType;
  String createdAt;



  WalletHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['wallet_id'];
    walletType = json['wallet_type'];
    currentTotal = json['current_total'];
    previousTotal = json['pervious_total'];
    amountSpent = json['amount_spent'];
    walletTypeFrom = json['wallet_type_from'];
    operationType = json['operation_type'];
    createdAt = json['created_at'];

  }
}