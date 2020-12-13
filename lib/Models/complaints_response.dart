class GetComplaintsResponse {
  String msg;
  List<String> errors;
  bool status;
  GetComplaintsData data;

  GetComplaintsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GetComplaintsData.fromJson(json['data'])
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

class GetComplaintsData {
  List<Complaint> complaints;

  GetComplaintsData.fromJson(Map<String, dynamic> json) {
    if (json['complaints'] != null) {
      complaints = new List<Complaint>();
      json['complaints'].forEach((v) {
        complaints.add(new Complaint.fromJson(v));
      });
    }
  }
}

class Complaint {
  int id;
  String orderId;
  String productId;
  String userId;
  String details;
  String status;
  String createdAt;

  Complaint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    userId = json['user_id'];
    details = json['details'];
    status = json['status'];
    createdAt = json['created_at'];
  }
}
