import 'dart:convert';

ProductOrServiceDetailsResponse productOrServiceDetailsResponseFromJson(
        String str) =>
    ProductOrServiceDetailsResponse.fromJson(json.decode(str));

String productOrServiceDetailsResponseToJson(
        ProductOrServiceDetailsResponse data) =>
    json.encode(data.toJson());

class ProductOrServiceDetailsResponse {
  ProductOrServiceDetailsResponse({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory ProductOrServiceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductOrServiceDetailsResponse(
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
  Data({this.item, this.deliveryInfo});
  DeliveryInfo deliveryInfo;

  Item item;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: Item.fromJson(json["item"]),
        deliveryInfo: DeliveryInfo.fromJson(json["delivery_info"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
        "delivery_info": deliveryInfo.toJson(),
      };
}

class Item {
  Item(
      {this.id,
      this.userId,
      this.userName,
      this.brandId,
      this.taxClassId,
      this.slug,
      this.price,
      this.specialPrice,
      this.specialPriceType,
      this.specialPriceStart,
      this.specialPriceEnd,
      this.sellingPrice,
      this.sku,
      this.manageStock,
      this.qty,
      this.inStock,
      this.viewed,
      this.isActive,
      this.newFrom,
      this.newTo,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.used,
      this.isWishlist,
      this.oldPrice,
      this.newPrice,
      this.mainImage,
      this.images,
      this.reviews,
      this.relatedItems,
      this.baseImage,
      this.formattedPrice,
      this.ratingPercent,
      this.isInStock,
      this.isOutOfStock,
      this.isNew,
      this.hasPercentageSpecialPrice,
      this.specialPricePercent,
      this.name,
      this.description,
      this.shortDescription,
      this.translations,
      this.files,
      this.relatedProducts,
      this.pivot,
      this.count});

  int id;
  dynamic userId;
  String brandId, userName;
  dynamic taxClassId;
  String slug;
  Price price;
  Price specialPrice;
  String specialPriceType;
  DateTime specialPriceStart;
  DateTime specialPriceEnd;
  Price sellingPrice;
  dynamic sku;
  bool manageStock;
  dynamic qty;
  bool inStock;
  String viewed;
  bool isActive;
  dynamic newFrom;
  dynamic newTo;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String used;
  bool isWishlist;
  var oldPrice;
  var newPrice;
  String mainImage;
  List<String> images;
  List<Review> reviews;
  List<Item> relatedItems;
  BaseImage baseImage;
  String formattedPrice;
  int ratingPercent;
  bool isInStock;
  bool isOutOfStock;
  bool isNew;
  bool hasPercentageSpecialPrice;
  int specialPricePercent;
  String name;
  String description;
  dynamic shortDescription;
  List<Translation> translations;
  List<BaseImage> files;
  List<Item> relatedProducts;
  Pivot pivot;
  int count;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        brandId: json["brand_id"],
        taxClassId: json["tax_class_id"],
        slug: json["slug"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        specialPrice: json["special_price"] == null
            ? null
            : Price.fromJson(json["special_price"]),
        specialPriceType: json["special_price_type"],
        specialPriceStart: json["special_price_start"] == null
            ? null
            : DateTime.parse(json["special_price_start"]),
        specialPriceEnd: json["special_price_end"] == null
            ? null
            : DateTime.parse(json["special_price_end"]),
        sellingPrice: json["selling_price"] == null
            ? null
            : Price.fromJson(json["selling_price"]),
        sku: json["sku"],
        manageStock: json["manage_stock"],
        qty: json["qty"],
        inStock: json["in_stock"],
        viewed: json["viewed"],
        isActive: json["is_active"],
        newFrom: json["new_from"],
        newTo: json["new_to"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        used: json["used"],
        isWishlist: json["is_wishlist"] == null ? null : json["is_wishlist"],
        oldPrice: json["old_price"] == null ? null : json["old_price"],
        newPrice: json["new_price"] == null ? null : json["new_price"],
        mainImage: json["main_image"] == null ? null : json["main_image"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        reviews: json["reviews"] == null
            ? null
            : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        relatedItems: json["related_items"] == null
            ? null
            : List<Item>.from(
                json["related_items"].map((x) => Item.fromJson(x))),
        baseImage: json["base_image"] == null
            ? null
            : BaseImage.fromJson(json["base_image"]),
        formattedPrice: json["formatted_price"],
        ratingPercent:
            json["rating_percent"] == null ? null : json["rating_percent"],
        isInStock: json["is_in_stock"],
        isOutOfStock: json["is_out_of_stock"],
        isNew: json["is_new"],
        hasPercentageSpecialPrice: json["has_percentage_special_price"],
        specialPricePercent: json["special_price_percent"] == null
            ? null
            : json["special_price_percent"],
        name: json["name"],
        description: json["description"],
        shortDescription: json["short_description"],
        translations: json["translations"] == null
            ? null
            : List<Translation>.from(
                json["translations"].map((x) => Translation.fromJson(x))),
        files: json["files"] == null
            ? null
            : List<BaseImage>.from(
                json["files"].map((x) => BaseImage.fromJson(x))),
        relatedProducts: json["related_products"] == null
            ? null
            : List<Item>.from(
                json["related_products"].map((x) => Item.fromJson(x))),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "brand_id": brandId,
        "tax_class_id": taxClassId,
        "slug": slug,
        "price": price.toJson(),
        "special_price": specialPrice == null ? null : specialPrice.toJson(),
        "special_price_type": specialPriceType,
        "special_price_start": specialPriceStart == null
            ? null
            : specialPriceStart.toIso8601String(),
        "special_price_end":
            specialPriceEnd == null ? null : specialPriceEnd.toIso8601String(),
        "selling_price": sellingPrice != null ? sellingPrice.toJson() : null,
        "sku": sku,
        "manage_stock": manageStock,
        "qty": qty,
        "in_stock": inStock,
        "viewed": viewed,
        "is_active": isActive,
        "new_from": newFrom,
        "new_to": newTo,
        "deleted_at": deletedAt,
        "created_at": createdAt != null ? createdAt.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt.toIso8601String() : null,
        "used": used,
        "is_wishlist": isWishlist == null ? null : isWishlist,
        "old_price": oldPrice == null ? null : oldPrice,
        "new_price": newPrice == null ? null : newPrice,
        "main_image": mainImage == null ? null : mainImage,
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "reviews": reviews == null
            ? null
            : List<dynamic>.from(reviews.map((x) => x.toJson())),
        "related_items": relatedItems == null
            ? null
            : List<dynamic>.from(relatedItems.map((x) => x.toJson())),
        "base_image": baseImage == null ? null : baseImage.toJson(),
        "formatted_price": formattedPrice,
        "rating_percent": ratingPercent == null ? null : ratingPercent,
        "is_in_stock": isInStock,
        "is_out_of_stock": isOutOfStock,
        "is_new": isNew,
        "has_percentage_special_price": hasPercentageSpecialPrice,
        "special_price_percent":
            specialPricePercent == null ? null : specialPricePercent,
        "name": name,
        "description": description,
        "short_description": shortDescription,
        "translations": translations == null
            ? null
            : List<dynamic>.from(translations.map((x) => x.toJson())),
        "files": files == null
            ? null
            : List<dynamic>.from(files.map((x) => x.toJson())),
        "related_products": relatedProducts == null
            ? null
            : List<dynamic>.from(relatedProducts.map((x) => x.toJson())),
        "pivot": pivot == null ? null : pivot.toJson(),
        "count": count
      };
}

class BaseImage {
  BaseImage({
    this.id,
    this.filename,
    this.path,
  });

  int id;
  String filename;
  String path;

  factory BaseImage.fromJson(Map<String, dynamic> json) => BaseImage(
        id: json["id"],
        filename: json["filename"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "path": path,
      };
}

class Pivot {
  Pivot({
    this.productId,
    this.relatedProductId,
  });

  String productId;
  String relatedProductId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        productId: json["product_id"],
        relatedProductId: json["related_product_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "related_product_id": relatedProductId,
      };
}

class Price {
  Price({
    this.amount,
    this.formatted,
    this.currency,
    this.inCurrentCurrency,
  });

  String amount;
  String formatted;
  String currency;
  InCurrentCurrency inCurrentCurrency;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"],
        formatted: json["formatted"],
        currency: json["currency"],
        inCurrentCurrency: json["inCurrentCurrency"] != null
            ? InCurrentCurrency.fromJson(json["inCurrentCurrency"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "formatted": formatted,
        "currency": currency,
        "inCurrentCurrency":
            inCurrentCurrency == null ? null : inCurrentCurrency.toJson(),
      };
}

enum Currency { USD }

final currencyValues = EnumValues({"USD": Currency.USD});

class InCurrentCurrency {
  InCurrentCurrency({
    this.amount,
    this.formatted,
    this.currency,
  });

  var amount;
  String formatted;
  Currency currency;

  factory InCurrentCurrency.fromJson(Map<String, dynamic> json) =>
      InCurrentCurrency(
        amount: json["amount"],
        formatted: json["formatted"],
        currency: currencyValues.map[json["currency"]],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "formatted": formatted,
        "currency": currencyValues.reverse[currency],
      };
}

class Review {
  Review({
    this.id,
    this.reviewerId,
    this.productId,
    this.rating,
    this.reviewerName,
    this.comment,
    this.isApproved,
    this.createdAt,
    this.updatedAt,
    this.ratingPercent,
    this.createdAtFormatted,
  });

  int id;
  String reviewerId;
  String productId;
  String rating;
  String reviewerName;
  String comment;
  bool isApproved;
  DateTime createdAt;
  DateTime updatedAt;
  int ratingPercent;
  String createdAtFormatted;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        reviewerId: json["reviewer_id"],
        productId: json["product_id"],
        rating: json["rating"],
        reviewerName: json["reviewer_name"],
        comment: json["comment"],
        isApproved: json["is_approved"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ratingPercent: json["rating_percent"],
        createdAtFormatted: json["created_at_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reviewer_id": reviewerId,
        "product_id": productId,
        "rating": rating,
        "reviewer_name": reviewerName,
        "comment": comment,
        "is_approved": isApproved,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rating_percent": ratingPercent,
        "created_at_formatted": createdAtFormatted,
      };
}

class Translation {
  Translation({
    this.id,
    this.productId,
    this.locale,
    this.name,
    this.description,
    this.shortDescription,
  });

  int id;
  String productId;
  String locale;
  String name;
  String description;
  dynamic shortDescription;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        productId: json["product_id"],
        locale: json["locale"],
        name: json["name"],
        description: json["description"],
        shortDescription: json["short_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "locale": locale,
        "name": name,
        "description": description,
        "short_description": shortDescription,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

class DeliveryInfo {
  DeliveryInfo({
    this.the5Himaka,
    this.deliveryInformation,
    this.returnPolicy,
  });

  String the5Himaka;
  String deliveryInformation;
  String returnPolicy;

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
        the5Himaka: json["5himaka"],
        deliveryInformation: json["delivery_information"],
        returnPolicy: json["return_policy"],
      );

  Map<String, dynamic> toJson() => {
        "5himaka": the5Himaka,
        "delivery_information": deliveryInformation,
        "return_policy": returnPolicy,
      };
}
