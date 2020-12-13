import 'dart:convert';

import 'login_response.dart';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.user,
  });

  LoginUserResponse user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json['user']!=null?LoginUserResponse.fromJson(json['user']):null,
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.token,
    this.permissions,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.nationalId,
    this.pin,
    this.mobile,
    this.address,
    this.question,
    this.answer,
    this.commissionAcount,
    this.profitAcount,
    this.cachbackCaccount,
    this.cadeauAcount,
    this.personalAcount,
    this.withdrawFieldValue,
    this.withdrawFieldDescription,
    this.withdrawWayId,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String token;
  List<dynamic> permissions;
  DateTime lastLogin;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic nationalId;
  dynamic pin;
  String mobile;
  String address;
  dynamic question;
  dynamic answer;
  String commissionAcount;
  String profitAcount;
  String cachbackCaccount;
  String cadeauAcount;
  String personalAcount;
  String withdrawFieldValue;
  dynamic withdrawFieldDescription;
  String withdrawWayId;


  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        token: json["token"],
        permissions: json["permissions"]!=null?List<dynamic>.from(json["permissions"].map((x) => x)):null,
        lastLogin: DateTime.parse(json["last_login"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        nationalId: json["national_id"],
        pin: json["pin"],
        mobile: json["mobile"],
        address: json["address"],
        question: json["question"],
        answer: json["answer"],
        commissionAcount: json["commission_acount"],
        profitAcount: json["profit_acount"],
        cachbackCaccount: json["cachback_caccount"],
        cadeauAcount: json["cadeau_acount"],
        personalAcount: json["personal_acount"],
        withdrawFieldValue: json["withdraw_field_value"],
        withdrawFieldDescription: json["withdraw_field_description"],
        withdrawWayId: json["withdraw_way_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "token": token,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "last_login": lastLogin.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "national_id": nationalId,
        "pin": pin,
        "mobile": mobile,
        "address": address,
        "question": question,
        "answer": answer,
        "commission_acount": commissionAcount,
        "profit_acount": profitAcount,
        "cachback_caccount": cachbackCaccount,
        "cadeau_acount": cadeauAcount,
        "personal_acount": personalAcount,
        "withdraw_field_value": withdrawFieldValue,
        "withdraw_field_description": withdrawFieldDescription,
        "withdraw_way_id": withdrawWayId,
      };
}
