import 'package:himaka/Models/wallet_history.dart';

class WalletResponse {
  bool status;
  List<String> errors;
  String msg;
  WalletResponseData data;

  WalletResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new WalletResponseData.fromJson(json['data'])
        : null;
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

class WalletResponseData {
  String balance;
  String points;
  bool isPoints;
  List< WalletHistory> walletHistory;
  List<Child> members;

  WalletResponseData.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    points = json['points'];
    isPoints = json['isPoints'];
    if (json['Main_Childs'] != null) {
      members = new List<Child>();
      json['Main_Childs'].forEach((v) {
        members.add(new Child.fromJson(v));
      });
    }
    if (json['wallet_history'] != null) {
      walletHistory = new List<WalletHistory>();
      json['wallet_history'].forEach((v) {
        walletHistory.add(new WalletHistory.fromJson(v));
      });
    }
  }
}

class Child {
  int id;
  String name;

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
