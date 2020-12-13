import 'orders_response.dart';

class AddComplaintPreResponse {
  String msg;
  List<String> errors;
  bool status;
  AddComplaintPreData data;

  AddComplaintPreResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new AddComplaintPreData.fromJson(json['data'])
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

class AddComplaintPreData {
  List<Order> orders;

  AddComplaintPreData.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Order>();
      json['orders'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
  }
}
