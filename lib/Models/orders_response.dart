import 'dart:convert';

import 'package:himaka/Models/home_response.dart';

OrdersResponse ordersResponseFromJson(String str) =>
    OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse {
  OrdersResponse({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
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
  Data({this.orders});

  List<Order> orders;

  Data.fromJson(Map<String, dynamic> json) {
    orders = (json["orders"] != null && json["orders"] != "[]")
        ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
        : [];
  }

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order(
      {this.id,
      this.customerId,
      this.customerEmail,
      this.customerPhone,
      this.customerFirstName,
      this.customerLastName,
      this.billingFirstName,
      this.billingLastName,
      this.billingAddress1,
      this.billingAddress2,
      this.billingCity,
      this.billingState,
      this.billingZip,
      this.billingCountry,
      this.shippingFirstName,
      this.shippingLastName,
      this.shippingAddress1,
      this.shippingAddress2,
      this.shippingCity,
      this.shippingState,
      this.shippingZip,
      this.shippingCountry,
      this.subTotal,
      this.shippingMethod,
      this.shippingCost,
      this.couponId,
      this.discount,
      this.total,
      this.paymentMethod,
      this.currency,
      this.currencyRate,
      this.locale,
      this.status,
      this.note,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.products});

  int id;
  List<Offer> products;
  String customerId;
  String customerEmail;
  dynamic customerPhone;
  String customerFirstName;
  String customerLastName;
  String billingFirstName;
  String billingLastName;
  String billingAddress1;
  dynamic billingAddress2;
  String billingCity;
  String billingState;
  String billingZip;
  String billingCountry;
  String shippingFirstName;
  String shippingLastName;
  String shippingAddress1;
  dynamic shippingAddress2;
  String shippingCity;
  String shippingState;
  String shippingZip;
  String shippingCountry;
  Discount subTotal;
  String shippingMethod;
  Discount shippingCost;
  dynamic couponId;
  Discount discount;
  Discount total;
  String paymentMethod;
  String currency;
  String currencyRate;
  String locale;
  String status;
  dynamic note;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        products: json["product"] != null
            ? List<Offer>.from(json["product"].map((x) => Offer.fromJson(x)))
            : null,
        customerId: json["customer_id"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
        customerFirstName: json["customer_first_name"],
        customerLastName: json["customer_last_name"],
        billingFirstName: json["billing_first_name"],
        billingLastName: json["billing_last_name"],
        billingAddress1: json["billing_address_1"],
        billingAddress2: json["billing_address_2"],
        billingCity: json["billing_city"],
        billingState: json["billing_state"],
        billingZip: json["billing_zip"],
        billingCountry: json["billing_country"],
        shippingFirstName: json["shipping_first_name"],
        shippingLastName: json["shipping_last_name"],
        shippingAddress1: json["shipping_address_1"],
        shippingAddress2: json["shipping_address_2"],
        shippingCity: json["shipping_city"],
        shippingState: json["shipping_state"],
        shippingZip: json["shipping_zip"],
        shippingCountry: json["shipping_country"],
        subTotal: Discount.fromJson(json["sub_total"]),
        shippingMethod: json["shipping_method"],
        shippingCost: Discount.fromJson(json["shipping_cost"]),
        couponId: json["coupon_id"],
        discount: Discount.fromJson(json["discount"]),
        total: Discount.fromJson(json["total"]),
        paymentMethod: json["payment_method"],
        currency: json["currency"],
        currencyRate: json["currency_rate"],
        locale: json["locale"],
        status: json["status"],
        note: json["note"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "customer_email": customerEmail,
        "customer_phone": customerPhone,
        "customer_first_name": customerFirstName,
        "customer_last_name": customerLastName,
        "billing_first_name": billingFirstName,
        "billing_last_name": billingLastName,
        "billing_address_1": billingAddress1,
        "billing_address_2": billingAddress2,
        "billing_city": billingCity,
        "billing_state": billingState,
        "billing_zip": billingZip,
        "billing_country": billingCountry,
        "shipping_first_name": shippingFirstName,
        "shipping_last_name": shippingLastName,
        "shipping_address_1": shippingAddress1,
        "shipping_address_2": shippingAddress2,
        "shipping_city": shippingCity,
        "shipping_state": shippingState,
        "shipping_zip": shippingZip,
        "shipping_country": shippingCountry,
        "sub_total": subTotal.toJson(),
        "shipping_method": shippingMethod,
        "shipping_cost": shippingCost.toJson(),
        "coupon_id": couponId,
        "discount": discount.toJson(),
        "total": total.toJson(),
        "payment_method": paymentMethod,
        "currency": currency,
        "currency_rate": currencyRate,
        "locale": locale,
        "status": status,
        "note": note,
        "product": List<dynamic>.from(products.map((x) => x.toJson())),
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Discount {
  Discount({
    this.amount,
    this.formatted,
    this.currency,
    this.inCurrentCurrency,
  });

  String amount;
  String formatted;
  String currency;
  InCurrentCurrency inCurrentCurrency;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        amount: json["amount"],
        formatted: json["formatted"],
        currency: json["currency"],
        inCurrentCurrency:
            InCurrentCurrency.fromJson(json["inCurrentCurrency"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "formatted": formatted,
        "currency": currency,
        "inCurrentCurrency": inCurrentCurrency.toJson(),
      };
}

class InCurrentCurrency {
  InCurrentCurrency({
    this.amount,
    this.formatted,
    this.currency,
  });

  int amount;
  String formatted;
  String currency;

  factory InCurrentCurrency.fromJson(Map<String, dynamic> json) =>
      InCurrentCurrency(
        amount: json["amount"],
        formatted: json["formatted"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "formatted": formatted,
        "currency": currency,
      };
}
