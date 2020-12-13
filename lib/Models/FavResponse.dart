import 'dart:convert';

FavResponse favResponseFromJson(String str) =>
    FavResponse.fromJson(json.decode(str));

String favResponseToJson(FavResponse data) => json.encode(data.toJson());

class FavResponse {
  FavResponse({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory FavResponse.fromJson(Map<String, dynamic> json) => FavResponse(
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
  Data(
//  {
//    this.wishlist,
//    this.deliveryInfo,
//  }
      );

//  List<Wishlist> wishlist;
//  String deliveryInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
//        wishlist: json["wishlist"] != null
//            ? List<Wishlist>.from(
//                json["wishlist"].map((x) => Wishlist.fromJson(x)))
//            : null,
//        deliveryInfo: json["delivery_info"],
      );

  Map<String, dynamic> toJson() => {
//        "wishlist": List<dynamic>.from(wishlist.map((x) => x.toJson())),
//        "delivery_info": deliveryInfo,
      };
}

class Wishlist {
  Wishlist({
    this.id,
    this.userId,
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
    this.pivot,
    this.translations,
    this.files,
  });

  int id;
  dynamic userId;
  String brandId;
  dynamic taxClassId;
  String slug;
  Price price;
  Price specialPrice;
  String specialPriceType;
  dynamic specialPriceStart;
  dynamic specialPriceEnd;
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
  BaseImage baseImage;
  String formattedPrice;
  dynamic ratingPercent;
  bool isInStock;
  bool isOutOfStock;
  bool isNew;
  bool hasPercentageSpecialPrice;
  dynamic specialPricePercent;
  String name;
  String description;
  dynamic shortDescription;
  Pivot pivot;
  List<Translation> translations;
  List<BaseImage> files;

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["id"],
        userId: json["user_id"],
        brandId: json["brand_id"],
        taxClassId: json["tax_class_id"],
        slug: json["slug"],
        price: Price.fromJson(json["price"]),
        specialPrice: json["special_price"] != null
            ? Price.fromJson(json["special_price"])
            : null,
        specialPriceType: json["special_price_type"],
        specialPriceStart: json["special_price_start"],
        specialPriceEnd: json["special_price_end"],
        sellingPrice: Price.fromJson(json["selling_price"]),
        sku: json["sku"],
        manageStock: json["manage_stock"],
        qty: json["qty"],
        inStock: json["in_stock"],
        viewed: json["viewed"],
        isActive: json["is_active"],
        newFrom: json["new_from"],
        newTo: json["new_to"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        used: json["used"],
        baseImage: BaseImage.fromJson(json["base_image"]),
        formattedPrice: json["formatted_price"],
        ratingPercent: json["rating_percent"],
        isInStock: json["is_in_stock"],
        isOutOfStock: json["is_out_of_stock"],
        isNew: json["is_new"],
        hasPercentageSpecialPrice: json["has_percentage_special_price"],
        specialPricePercent: json["special_price_percent"],
        name: json["name"],
        description: json["description"],
        shortDescription: json["short_description"],
        pivot: Pivot.fromJson(json["pivot"]),
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
        files: List<BaseImage>.from(
            json["files"].map((x) => BaseImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "brand_id": brandId,
        "tax_class_id": taxClassId,
        "slug": slug,
        "price": price.toJson(),
        "special_price": specialPrice.toJson(),
        "special_price_type": specialPriceType,
        "special_price_start": specialPriceStart,
        "special_price_end": specialPriceEnd,
        "selling_price": sellingPrice.toJson(),
        "sku": sku,
        "manage_stock": manageStock,
        "qty": qty,
        "in_stock": inStock,
        "viewed": viewed,
        "is_active": isActive,
        "new_from": newFrom,
        "new_to": newTo,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "used": used,
        "base_image": baseImage.toJson(),
        "formatted_price": formattedPrice,
        "rating_percent": ratingPercent,
        "is_in_stock": isInStock,
        "is_out_of_stock": isOutOfStock,
        "is_new": isNew,
        "has_percentage_special_price": hasPercentageSpecialPrice,
        "special_price_percent": specialPricePercent,
        "name": name,
        "description": description,
        "short_description": shortDescription,
        "pivot": pivot.toJson(),
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
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
    this.userId,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  String userId;
  String productId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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

  var amount;
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
