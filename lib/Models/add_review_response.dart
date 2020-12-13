import 'dart:convert';

AddReviewResponse addReviewResponseFromJson(String str) =>
    AddReviewResponse.fromJson(json.decode(str));

String addReviewResponseToJson(AddReviewResponse data) =>
    json.encode(data.toJson());

class AddReviewResponse {
  AddReviewResponse({this.status, this.msg, this.data, this.errors});

  bool status;
  String msg;
  Data data;
  List<String> errors;

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) =>
      AddReviewResponse(
        status: json["status"],
        msg: json["msg"],
        data: json["data"]!=null?Data.fromJson(json["data"]):null,
        errors: json["errors"] != null
            ? List<String>.from(json["errors"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.review,
  });

  Review review;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        review: json["review"] != null ? Review.fromJson(json["review"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "review": review.toJson(),
      };
}

class Review {
  Review({
    this.reviewerId,
    this.productId,
    this.rating,
    this.comment,
    this.reviewerName,
    this.isApproved,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.ratingPercent,
    this.createdAtFormatted,
  });

  int reviewerId;
  var productId;
  String rating;
  String comment;
  String reviewerName;
  bool isApproved;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  int ratingPercent;
  String createdAtFormatted;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewerId: json["reviewer_id"],
        productId: json["product_id"],
        rating: json["rating"],
        comment: json["comment"],
        reviewerName: json["reviewer_name"],
        isApproved: json["is_approved"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        ratingPercent: json["rating_percent"],
        createdAtFormatted: json["created_at_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "reviewer_id": reviewerId,
        "product_id": productId,
        "rating": rating,
        "comment": comment,
        "reviewer_name": reviewerName,
        "is_approved": isApproved,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "rating_percent": ratingPercent,
        "created_at_formatted": createdAtFormatted,
      };
}
