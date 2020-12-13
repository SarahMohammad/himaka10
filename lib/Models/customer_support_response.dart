import 'dart:convert';

CustomerSupportResponse customerSupportResponseFromJson(String str) =>
    CustomerSupportResponse.fromJson(json.decode(str));

String customerSupportResponseToJson(CustomerSupportResponse data) =>
    json.encode(data.toJson());

class CustomerSupportResponse {
  CustomerSupportResponse({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory CustomerSupportResponse.fromJson(Map<String, dynamic> json) =>
      CustomerSupportResponse(
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
    this.phone,
    this.mail,
    this.workHoursAndDays,
  });

  String phone;
  String mail;
  String workHoursAndDays;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json["phone"],
        mail: json["mail"],
        workHoursAndDays: json["workHoursAndDays"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "mail": mail,
        "workHoursAndDays": workHoursAndDays,
      };
}
